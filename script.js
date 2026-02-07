// script.js — site interactivity (nav, countdown, quiz, game, modal, youtube, etc.)

document.addEventListener('DOMContentLoaded', ()=> {
  // --- NAV TOGGLE (mobile) ---
  const nav = document.querySelector('.main-nav');
  const toggle = document.querySelector('.nav-toggle');
  if(toggle){
    toggle.addEventListener('click', () => {
      const expanded = toggle.getAttribute('aria-expanded') === 'true';
      toggle.setAttribute('aria-expanded', String(!expanded));
      if(nav.hasAttribute('open')) nav.removeAttribute('open');
      else nav.setAttribute('open','');
    });
  }

  // --- SMOOTH SCROLL for nav links ---
  document.querySelectorAll('.main-nav a').forEach(a=>{
    a.addEventListener('click', (e)=>{
      e.preventDefault();
      const id = a.getAttribute('href');
      const el = document.querySelector(id);
      if(el) el.scrollIntoView({behavior:'smooth',block:'start'});
      // close mobile nav
      if(nav && nav.hasAttribute('open')) nav.removeAttribute('open');
    });
  });

  // --- HERO HEART / SURPRISE ---
  const openBtn = document.getElementById('open-btn');
  const bigHeart = document.getElementById('big-heart');
  const playMusicBtn = document.getElementById('play-music');

  function spawnConfettiHearts(count=30){
    for(let i=0;i<count;i++){
      const h = document.createElement('div');
      h.className = 'heart';
      h.style.left = (10 + Math.random()*80) + '%';
      h.style.top = (-10 - Math.random()*30) + '%';
      h.style.opacity = String(0.6 + Math.random()*0.4);
      const size = 18 + Math.random()*36;
      h.style.width = size + 'px';
      h.style.height = size + 'px';
      document.body.appendChild(h);
      // animate falling
      const duration = 2500 + Math.random()*3000;
      h.animate([
        { transform: `translateY(0) rotate(-45deg)`, opacity: h.style.opacity },
        { transform: `translateY(120vh) rotate(${50 + Math.random()*200}deg)`, opacity: 0.2 }
      ], { duration, easing: 'linear' }).onfinish = ()=> h.remove();
      // allow click for small sparkle
      h.addEventListener('click', ()=> {
        h.remove();
      });
    }
  }

  if(openBtn){
    openBtn.addEventListener('click', ()=>{
      spawnConfettiHearts(40);
      typeWriter.start();
      // make big heart pulse
      if(bigHeart) bigHeart.animate([{transform:'scale(1) rotate(-45deg)'},{transform:'scale(1.12) rotate(-45deg)'},{transform:'scale(1) rotate(-45deg)'}],{duration:1200,iterations:2});
    });
  }

  if(bigHeart) bigHeart.addEventListener('click', ()=> openBtn && openBtn.click());

  // --- YOUTUBE EMBED for "Death Do Us Part" (UiKDgyfKQZE) (hidden player) ---
  let ytPlayer = null;
  let ytReady = false;
  let ytLoading = false;
  const YT_VIDEO_ID = 'UiKDgyfKQZE'; // provided YouTube link ID
  playMusicBtn.textContent = 'Play "Death Do Us Part" ♪';
  playMusicBtn.setAttribute('aria-pressed', 'false');

  window.onYouTubeIframeAPIReady = function() {
    ytPlayer = new YT.Player('player', {
      height: '0', width: '0', videoId: YT_VIDEO_ID,
      playerVars: {
        controls: 0,
        rel: 0,
        playsinline: 1,
        modestbranding: 1,
        iv_load_policy: 3
      },
      events: {
        onReady: function() { ytReady = true; },
        onStateChange: function(e) {
          if (e.data === YT.PlayerState.PLAYING) {
            playMusicBtn.setAttribute('aria-pressed', 'true');
            playMusicBtn.textContent = 'Pause "Death Do Us Part" ⏸';
          } else if (e.data === YT.PlayerState.PAUSED || e.data === YT.PlayerState.ENDED || e.data === YT.PlayerState.UNSTARTED) {
            playMusicBtn.setAttribute('aria-pressed', 'false');
            playMusicBtn.textContent = 'Play "Death Do Us Part" ♪';
          }
        }
      }
    });
  };

  function loadYouTubeAPI() {
    if (ytLoading || ytReady || window.YT) return;
    ytLoading = true;
    const tag = document.createElement('script');
    tag.src = "https://www.youtube.com/iframe_api";
    tag.async = true;
    document.head.appendChild(tag);
  }

  function toggleYouTubePlayback() {
    if (!ytPlayer || !ytReady) return;
    const state = ytPlayer.getPlayerState();
    if (state === YT.PlayerState.PLAYING) {
      ytPlayer.pauseVideo();
    } else {
      ytPlayer.playVideo();
    }
  }

  function waitAndTogglePlay(retries = 40) {
    let attempts = 0;
    const id = setInterval(() => {
      attempts++;
      if (ytReady && ytPlayer) {
        clearInterval(id);
        toggleYouTubePlayback();
      } else if (attempts >= retries) {
        clearInterval(id);
        // Fallback: open YouTube in new tab if player won't initialize
        window.open(`https://www.youtube.com/watch?v=${YT_VIDEO_ID}`, '_blank');
        playMusicBtn.setAttribute('aria-pressed', 'false');
        playMusicBtn.textContent = 'Play "Death Do Us Part" ♪';
      }
    }, 200);
  }

  playMusicBtn.addEventListener('click', (ev) => {
    if (!window.YT || !ytPlayer) {
      loadYouTubeAPI();
      playMusicBtn.disabled = true;
      playMusicBtn.textContent = 'Loading…';
      waitAndTogglePlay();
      setTimeout(() => { playMusicBtn.disabled = false; }, 2500);
    } else {
      toggleYouTubePlayback();
    }
  });

  // --- COUNTDOWN to Valentine's Day ---
  const cdDays = document.getElementById('cd-days');
  const cdTime = document.getElementById('cd-time');

  function getNextValentine() {
    const now = new Date();
    let year = now.getFullYear();
    const target = new Date(year, 1, 14, 0, 0, 0); // Feb 14
    if (now > target) {
      year = year + 1;
      return new Date(year, 1, 14, 0, 0, 0);
    }
    return target;
  }

  let valentineDate = getNextValentine();

  function updateCountdown() {
    const now = new Date();
    const diff = valentineDate - now;
    if (diff <= 0) {
      if(document.getElementById('countdown')) document.getElementById('countdown').textContent = "Happy Valentine's Day, Naledi! 💖";
      return;
    }
    const secs = Math.floor(diff / 1000);
    const days = Math.floor(secs / (3600*24));
    const hours = Math.floor((secs % (3600*24)) / 3600);
    const minutes = Math.floor((secs % 3600) / 60);
    const seconds = secs % 60;
    if(cdDays) cdDays.textContent = String(days);
    if(cdTime) cdTime.textContent = `${String(hours).padStart(2,'0')}:${String(minutes).padStart(2,'0')}:${String(seconds).padStart(2,'0')}`;
  }
  updateCountdown();
  setInterval(updateCountdown, 1000);

  // --- VALENTINE MODAL (Yes works, No dodges) ---
  const askBtn = document.getElementById('ask-btn');
  const modal = document.getElementById('valentine-modal');
  const modalClose = document.getElementById('val-close');
  const valYes = document.getElementById('val-yes');
  const valNo = document.getElementById('val-no');
  const modalPanel = modal ? modal.querySelector('.modal-panel') : null;

  function openModal(){
    if(!modal) return;
    modal.classList.remove('hidden');
    modal.setAttribute('aria-hidden','false');
    // focus yes by default
    if(valYes) valYes.focus();
    trapFocus(modal);
  }
  function closeModal(){
    if(!modal) return;
    modal.classList.add('hidden');
    modal.setAttribute('aria-hidden','true');
    releaseFocusTrap();
    if(askBtn) askBtn.focus();
    // reset No position after closing
    resetNoPosition();
  }

  if(askBtn) askBtn.addEventListener('click', openModal);
  if(modalClose) modalClose.addEventListener('click', closeModal);

  if(valYes){
    valYes.addEventListener('click', ()=>{
      spawnConfettiHearts(60);
      valYes.disabled = true;
      valYes.textContent = "SO HAPPY YOU SAID YES! I LOVE YOU! 🥰";
      setTimeout(()=> {
        closeModal();
        if(openBtn) openBtn.click();
      }, 1200);
    });
  }

  // Playful No behavior: dodge on hover/touch and refuse keyboard selection
  function moveNoButtonRandomly(){
    if(!modalPanel || !valNo) return;
    const panel = modalPanel;
    const rect = panel.getBoundingClientRect();
    const btnRect = valNo.getBoundingClientRect();
    const padding = 12;
    const maxLeft = Math.max(0, rect.width - btnRect.width - padding*2);
    const maxTop = Math.max(0, rect.height - btnRect.height - padding*2);
    const left = padding + Math.random() * maxLeft;
    const top = padding + Math.random() * maxTop;
    valNo.style.position = 'absolute';
    valNo.style.left = left + 'px';
    valNo.style.top = top + 'px';
    valNo.style.transform = `translate(-6px,-4px) rotate(${Math.random()*10-5}deg)`;
  }

  function resetNoPosition(){
    if(!valNo) return;
    valNo.style.position = '';
    valNo.style.left = '';
    valNo.style.top = '';
    valNo.style.transform = '';
  }

  if(valNo){
    valNo.addEventListener('mouseenter', moveNoButtonRandomly);
    valNo.addEventListener('touchstart', (e)=>{
      e.preventDefault();
      moveNoButtonRandomly();
    }, {passive:false});

    valNo.addEventListener('keydown', (e)=>{
      if(e.key === 'Enter' || e.key === ' '){
        e.preventDefault();
        showTemporaryTooltip(valNo, "No isn't an option 😉");
        if(valYes) valYes.focus();
        moveNoButtonRandomly();
      }
    });

    valNo.addEventListener('click', (e)=>{
      e.preventDefault();
      showTemporaryTooltip(valNo, "Not this time — try Yes 💕");
      moveNoButtonRandomly();
    });
  }

  function showTemporaryTooltip(target, text){
    if(!target) return;
    const parent = target.parentElement || target.parentNode;
    if(!parent) return;
    const existing = parent.querySelector('.tooltip-msg');
    if(existing) existing.remove();
    const msg = document.createElement('div');
    msg.className = 'tooltip-msg';
    msg.textContent = text;
    parent.appendChild(msg);
    setTimeout(()=> msg.remove(), 1600);
  }

  // Simple focus trap for modal
  let lastFocused = null;
  function trapFocus(container){
    lastFocused = document.activeElement;
    const focusable = Array.from(container.querySelectorAll('button, [href], input, select, textarea, [tabindex]:not([tabindex="-1"])'))
      .filter(el => !el.hasAttribute('disabled'));
    const first = focusable[0];
    const last = focusable[focusable.length - 1];
    function handleTab(e){
      if(e.key !== 'Tab') return;
      if(e.shiftKey && document.activeElement === first){
        e.preventDefault();
        last.focus();
      } else if(!e.shiftKey && document.activeElement === last){
        e.preventDefault();
        first.focus();
      }
    }
    container.__handleTab = handleTab;
    document.addEventListener('keydown', handleTab);
  }
  function releaseFocusTrap(){
    if(modal && modal.__handleTab) document.removeEventListener('keydown', modal.__handleTab);
    if(lastFocused) lastFocused.focus();
  }

  // close modal on Escape
  document.addEventListener('keydown', (e)=>{
    if(e.key === 'Escape' && modal && !modal.classList.contains('hidden')) closeModal();
  });

  // --- QUIZ ---
  const quizQuestions = [
    {q:"Where did we first meet?", a:["Gold Reef City","At the library","Online","At the park"], correct:0},
    {q:"What's my favourite snack?", a:["Chocolate","Marshmellows","Biltong","Nougat"], correct:2},
    {q:"Which movie did we watch on our first movie date?", a:["Sinners","F1","Den of Thieves","Wicked"], correct:0}
  ];
  let currentQ = 0, scoreQ = 0;
  const questionEl = document.getElementById('question');
  const answersEl = document.getElementById('answers');
  const nextBtn = document.getElementById('next-q');
  const resultEl = document.getElementById('quiz-result');

  function renderQ(){
    const item = quizQuestions[currentQ];
    if(!item || !questionEl || !answersEl) return;
    questionEl.textContent = item.q;
    answersEl.innerHTML = '';
    item.a.forEach((opt, idx)=>{
      const btn = document.createElement('button');
      btn.textContent = opt;
      btn.setAttribute('role','listitem');
      btn.addEventListener('click', ()=>{
        Array.from(answersEl.children).forEach(b=>b.disabled=true);
        if(idx === item.correct){ btn.style.background = '#dff7e6'; scoreQ++; resultEl.textContent='Nice!'; }
        else { btn.style.background = '#ffe6ea'; resultEl.textContent='Almost — nice try!'; }
        nextBtn.disabled = false;
      });
      answersEl.appendChild(btn);
    });
    nextBtn.disabled = true;
    if(resultEl) resultEl.textContent = '';
  }
  if(nextBtn){
    nextBtn.addEventListener('click', ()=>{
      currentQ++;
      if(currentQ >= quizQuestions.length){
        if(resultEl) resultEl.textContent = `Quiz finished — you scored ${scoreQ}/${quizQuestions.length}!`;
        nextBtn.disabled = true;
        if(questionEl) questionEl.textContent = "Well done!";
        if(answersEl) answersEl.innerHTML = '';
        currentQ = 0; scoreQ = 0;
      } else renderQ();
    });
  }
  renderQ();

  // --- SIMPLE GAME (click falling hearts) ---
  const gameArea = document.getElementById('game-area');
  const startBtn = document.getElementById('start-game');
  const scoreEl = document.getElementById('score');
  const timeEl = document.getElementById('time');
  let gameInterval, spawnInterval, score=0, timeLeft=20;

  function spawnGameHeart(){
    if(!gameArea) return;
    const h = document.createElement('div');
    h.className = 'heart';
    const w = 28 + Math.random()*32;
    h.style.width = h.style.height = w+'px';
    h.style.left = (Math.random()*(gameArea.clientWidth - w)) + 'px';
    h.style.top = '-40px';
    gameArea.appendChild(h);
    const duration = 3500 + Math.random()*2500;
    const anim = h.animate([{transform:'translateY(0)'},{transform:`translateY(${gameArea.clientHeight + 60}px)`}],{duration, easing:'linear'});
    anim.onfinish = ()=> h.remove();
    h.addEventListener('click', ()=>{
      score += 1;
      if(scoreEl) scoreEl.textContent = score;
      h.remove();
    });
  }

  function startGame(){
    score = 0; timeLeft = 20;
    if(scoreEl) scoreEl.textContent = score;
    if(timeEl) timeEl.textContent = timeLeft;
    spawnGameHeart(); // initial
    spawnInterval = setInterval(spawnGameHeart, 700);
    gameInterval = setInterval(()=>{
      timeLeft--;
      if(timeEl) timeEl.textContent = timeLeft;
      if(timeLeft <= 0){
        clearInterval(spawnInterval); clearInterval(gameInterval);
        Array.from(gameArea.querySelectorAll('.heart')).forEach(h=>h.remove());
        alert(`Time's up! Your score: ${score}`);
      }
    }, 1000);
  }

  if(startBtn) startBtn.addEventListener('click', startGame);

  // --- SECRET / TYPEWRITER ---
  const revealBtn = document.getElementById('reveal');
  const typeArea = document.getElementById('typewriter');
  const typeWriter = {
    text: "Every love story is beautiful, but ours is my favourite place to be. Today, on Valentine’s Day, and for the rest of my life.❤️",
    i: 0,
    running: false,
    start(){
      if(this.running) return;
      this.running = true;
      this.i = 0;
      if(typeArea) typeArea.textContent = '';
      if(revealBtn) revealBtn.setAttribute('aria-expanded','true');
      const step = ()=>{
        if(this.i < this.text.length){
          if(typeArea) typeArea.textContent += this.text[this.i++];
          setTimeout(step, 40 + Math.random()*40);
        } else this.running = false;
      };
      step();
    }
  };
  if(revealBtn) revealBtn.addEventListener('click', ()=> typeWriter.start());

  // --- Helpful keyboard support: press H to open surprise ---
  document.addEventListener('keydown', (e)=>{
    if(e.key.toLowerCase() === 'h' && openBtn) openBtn.click();
  });

  // --- Gallery click to open in new tab (simple) ---
  const galleryGrid = document.getElementById('gallery-grid');
  if(galleryGrid){
    galleryGrid.addEventListener('click', (e)=>{
      if(e.target.tagName === 'IMG'){
        const src = e.target.getAttribute('src');
        window.open(src, '_blank');
      }
    });
  }

  // Accessibility: focus main sections when navigated by links (for screen readers)
  document.querySelectorAll('main section[id]').forEach(s=> {
    const link = document.querySelector(`a[href="#${s.id}"]`);
    if(link) link.addEventListener('click', ()=> s.setAttribute('tabindex','-1') );
  });

});
