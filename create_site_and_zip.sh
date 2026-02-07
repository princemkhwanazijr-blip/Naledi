#!/usr/bin/env bash
# create_site_and_zip.sh
# Creates a valentine_site directory with all source files and zips it to valentine_site.zip
# Run from the folder where you want the valentine_site created.

set -euo pipefail

OUT_DIR="valentine_site"
OUT_ZIP="${OUT_DIR}.zip"

echo "Creating ${OUT_DIR} ..."

# Remove existing folder/zip if present
rm -rf "$OUT_DIR" "$OUT_ZIP"

mkdir -p "$OUT_DIR/assets"
mkdir -p "$OUT_DIR/assets/optimized"

cat > "$OUT_DIR/index.html" <<'HTML'
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <title>For You — Happy Valentine's Day</title>
  <link rel="stylesheet" href="styles.css" />
</head>
<body>
  <header class="site-header" role="banner">
    <div class="container">
      <h1 id="brand">For You ♥</h1>
      <nav class="main-nav" aria-label="Main navigation">
        <button class="nav-toggle" aria-controls="nav-links" aria-expanded="false">☰</button>
        <ul id="nav-links">
          <li><a href="#hero">Home</a></li>
          <li><a href="#story">Our Story</a></li>
          <li><a href="#gallery">Gallery</a></li>
          <li><a href="#quiz">Quiz</a></li>
          <li><a href="#game">Game</a></li>
          <li><a href="#message">Secret</a></li>
        </ul>
      </nav>
    </div>
  </header>

  <main>
    <section id="hero" class="hero" tabindex="-1">
      <div class="container hero-inner">
        <div class="hero-text">
          <h2>Happy Valentine's Day, Naledi!</h2>
          <p>Open your surprise — tap the heart below or see how long until Valentine's Day.</p>

          <div class="countdown" aria-live="polite" id="countdown" title="Countdown to Valentine's Day">
            <strong id="cd-days">--</strong> days
            <span id="cd-time">--:--:--</span>
          </div>

          <div class="cta-row">
            <button id="open-btn" class="btn btn-primary" aria-haspopup="true">Open Surprise ♥</button>
            <button id="ask-btn" class="btn">Ask Her Now 💌</button>
            <button id="play-music" class="btn" aria-pressed="false">Play "Death Do Us Part" ♪</button>
          </div>
        </div>
        <div class="hero-art" aria-hidden="true">
          <div class="big-heart" id="big-heart" title="Click me"></div>
        </div>
      </div>
    </section>

    <section id="story" class="container section">
      <h3>Our Story</h3>
      <ol class="timeline" aria-label="Timeline of our story">
        <li><strong>Met:</strong> The day we met — replace with your date and short note.</li>
        <li><strong>First date:</strong> Where we went and a fond memory.</li>
        <li><strong>Special moments:</strong> A short sweet note or two.</li>
      </ol>
    </section>

    <section id="gallery" class="container section">
      <h3>Gallery</h3>
      <p class="muted">Click to view the full-size optimized image — replace images in the /assets folder if needed.</p>

      <div class="gallery-grid" id="gallery-grid">
        <figure>
          <picture>
            <source type="image/webp"
              srcset="assets/optimized/photo1-400.webp 400w, assets/optimized/photo1-800.webp 800w, assets/optimized/photo1-1200.webp 1200w"
              sizes="(max-width:600px) 100vw, 33vw">
            <source type="image/jpeg"
              srcset="assets/optimized/photo1-400.jpg 400w, assets/optimized/photo1-800.jpg 800w, assets/optimized/photo1-1200.jpg 1200w"
              sizes="(max-width:600px) 100vw, 33vw">
            <img src="assets/optimized/photo1-800.jpg" alt="Gallery photo 1" loading="lazy" data-full="assets/optimized/photo1-1200.jpg" />
          </picture>
          <figcaption>Museum fun</figcaption>
        </figure>

        <figure>
          <picture>
            <source type="image/webp"
              srcset="assets/optimized/photo2-400.webp 400w, assets/optimized/photo2-800.webp 800w, assets/optimized/photo2-1200.webp 1200w"
              sizes="(max-width:600px) 100vw, 33vw">
            <source type="image/jpeg"
              srcset="assets/optimized/photo2-400.jpg 400w, assets/optimized/photo2-800.jpg 800w, assets/optimized/photo2-1200.jpg 1200w"
              sizes="(max-width:600px) 100vw, 33vw">
            <img src="assets/optimized/photo2-800.jpg" alt="Gallery photo 2" loading="lazy" data-full="assets/optimized/photo2-1200.jpg" />
          </picture>
          <figcaption>Dinner night</figcaption>
        </figure>

        <figure>
          <picture>
            <source type="image/webp"
              srcset="assets/optimized/photo3-400.webp 400w, assets/optimized/photo3-800.webp 800w, assets/optimized/photo3-1200.webp 1200w"
              sizes="(max-width:600px) 100vw, 33vw">
            <source type="image/jpeg"
              srcset="assets/optimized/photo3-400.jpg 400w, assets/optimized/photo3-800.jpg 800w, assets/optimized/photo3-1200.jpg 1200w"
              sizes="(max-width:600px) 100vw, 33vw">
            <img src="assets/optimized/photo3-800.jpg" alt="Gallery photo 3" loading="lazy" data-full="assets/optimized/photo3-1200.jpg" />
          </picture>
          <figcaption>Infinity mirrors</figcaption>
        </figure>

        <figure>
          <picture>
            <source type="image/webp"
              srcset="assets/optimized/photo4-400.webp 400w, assets/optimized/photo4-800.webp 800w, assets/optimized/photo4-1200.webp 1200w"
              sizes="(max-width:600px) 100vw, 33vw">
            <source type="image/jpeg"
              srcset="assets/optimized/photo4-400.jpg 400w, assets/optimized/photo4-800.jpg 800w, assets/optimized/photo4-1200.jpg 1200w"
              sizes="(max-width:600px) 100vw, 33vw">
            <img src="assets/optimized/photo4-800.jpg" alt="Gallery photo 4" loading="lazy" data-full="assets/optimized/photo4-1200.jpg" />
          </picture>
          <figcaption>Aquarium day</figcaption>
        </figure>

        <figure>
          <picture>
            <source type="image/webp"
              srcset="assets/optimized/photo5-400.webp 400w, assets/optimized/photo5-800.webp 800w, assets/optimized/photo5-1200.webp 1200w"
              sizes="(max-width:600px) 100vw, 33vw">
            <source type="image/jpeg"
              srcset="assets/optimized/photo5-400.jpg 400w, assets/optimized/photo5-800.jpg 800w, assets/optimized/photo5-1200.jpg 1200w"
              sizes="(max-width:600px) 100vw, 33vw">
            <img src="assets/optimized/photo5-800.jpg" alt="Gallery photo 5" loading="lazy" data-full="assets/optimized/photo5-1200.jpg" />
          </picture>
          <figcaption>Sea life memories</figcaption>
        </figure>

      </div>
    </section>

    <section id="quiz" class="container section" aria-labelledby="quiz-title">
      <h3 id="quiz-title">How well do you know me?</h3>
      <div id="quiz-area" class="quiz">
        <div id="question"></div>
        <div id="answers" role="list"></div>
        <div class="quiz-controls">
          <button id="next-q" class="btn" disabled>Next</button>
          <div id="quiz-result" aria-live="polite"></div>
        </div>
      </div>
    </section>

    <section id="game" class="container section">
      <h3>Catch the Hearts</h3>
      <p>Click hearts to collect points. Try to get as many as you can in 20 seconds!</p>
      <div id="game-area" class="game-area" tabindex="0" aria-label="Catch the hearts game"></div>
      <div class="game-controls">
        <button id="start-game" class="btn btn-primary">Start Game</button>
        <span>Score: <strong id="score">0</strong></span>
        <span>Time: <strong id="time">20</strong>s</span>
      </div>
    </section>

    <section id="message" class="container section">
      <h3>Secret Message</h3>
      <p>Press the red heart to reveal a message.</p>
      <div class="secret-area">
        <button id="reveal" class="heart-small" aria-expanded="false">♥</button>
        <div id="typewriter" class="typewriter" aria-live="polite"></div>
      </div>
    </section>

    <footer class="site-footer container" role="contentinfo">
      <p>Made with ♥ — Customize this page and surprise her.</p>
      <p class="muted">Tip: Replace the placeholder images in /assets and edit messages in script.js</p>
    </footer>
  </main>

  <!-- Modal: Will you be my Valentine? -->
  <div id="valentine-modal" class="modal hidden" role="dialog" aria-modal="true" aria-labelledby="val-title" aria-hidden="true">
    <div class="modal-panel" role="document">
      <h2 id="val-title">Will you be my Valentine?</h2>
      <p>I picked something special just for you — will you be mine?</p>
      <div class="modal-actions" id="modal-actions">
        <button id="val-yes" class="btn btn-primary">Yes! ❤️</button>
        <button id="val-no" class="btn" aria-label="No (not clickable)">No</button>
      </div>
      <button class="modal-close" id="val-close" aria-label="Close dialog">✕</button>
    </div>
  </div>

  <!-- YouTube player (visually hidden offscreen) -->
  <div id="youtube-player-wrapper" aria-hidden="true" style="position:absolute;left:-9999px;top:auto;width:1px;height:1px;overflow:hidden">
    <div id="player"></div>
  </div>

  <script src="script.js"></script>

  <script>
    // Small enhancement: open the data-full (largest optimized) on click
    document.addEventListener('DOMContentLoaded', () => {
      const gallery = document.getElementById('gallery-grid');
      if(!gallery) return;
      gallery.addEventListener('click', (e) => {
        const img = e.target.closest('img');
        if(!img) return;
        const full = img.getAttribute('data-full') || img.src;
        window.open(full, '_blank');
      });
    });
  </script>
</body>
</html>
HTML

cat > "$OUT_DIR/styles.css" <<'CSS'
:root{
  --bg:#fff7fb;
  --card:#ffffff;
  --accent:#ff5e8a;
  --accent-2:#ffb3c6;
  --text:#333;
  --muted:#666;
  --radius:14px;
  --max-width:1000px;
  --gap:1rem;
  --font-sans: "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
}

*{box-sizing:border-box}
html,body{height:100%}
body{
  margin:0;
  font-family:var(--font-sans);
  background-image:
    linear-gradient(rgba(255,94,138,0.12), rgba(255,255,255,0.88)),
    url('assets/background.jpg');
  background-size: cover;
  background-position: center center;
  background-attachment: fixed;
  color:var(--text);
  -webkit-font-smoothing:antialiased;
  -moz-osx-font-smoothing:grayscale;
  line-height:1.45;
}

@media (max-width:720px){
  body { background-attachment: scroll; }
}

/* Container */
.container{max-width:var(--max-width);margin:0 auto;padding:1rem}

/* Header */
.site-header{background: linear-gradient(rgba(255,255,255,0.6), rgba(255,255,255,0.4)); padding:0.5rem 0; position:sticky; top:0; z-index:40; backdrop-filter: blur(4px);}
.site-header .container{display:flex;align-items:center;justify-content:space-between}
#brand{margin:0;font-size:1.25rem;color:var(--accent)}

/* Nav */
.main-nav ul{display:flex;gap:0.5rem;list-style:none;margin:0;padding:0}
.main-nav a{color:var(--muted);text-decoration:none;padding:0.35rem 0.6rem;border-radius:8px}
.main-nav a:hover, .main-nav a:focus{background:var(--accent-2);color:#fff}

/* Mobile toggle */
.nav-toggle{display:none;background:none;border:none;font-size:1.1rem}
@media(max-width:720px){
  .main-nav ul{display:none;flex-direction:column;background:rgba(255,255,255,0.95);position:absolute;right:1rem;top:3.6rem;padding:0.5rem;border-radius:10px;box-shadow:0 6px 18px rgba(0,0,0,0.08)}
  .nav-toggle{display:inline-block}
  .main-nav[open] ul{display:flex}
}

/* Hero */
.hero{padding:2rem 0 3rem}
.hero-inner{display:flex;gap:2rem;align-items:center;justify-content:space-between}
.hero-text h2{font-size:1.6rem;margin:0 0 0.4rem;color:var(--text);text-shadow: 0 1px 0 rgba(255,255,255,0.7)}
.hero-text p{margin:0 0 1rem;color:var(--muted)}
.btn{background:#fff;border:1px solid #eee;padding:0.5rem 0.9rem;border-radius:10px;cursor:pointer}
.btn-primary{background:var(--accent);color:#fff;border:none}
.cta-row{display:flex;gap:0.6rem;align-items:center}
.countdown{margin:0.5rem 0;padding:0.4rem 0.6rem;border-radius:10px;background:linear-gradient(90deg,#fff,#fff6f7);display:inline-block;border:1px solid #ffe6ef;font-weight:600;color:var(--accent)}

/* Big heart */
.big-heart{width:140px;height:140px;background:var(--accent);position:relative;border-radius:50% 50% 0 0;transform:rotate(-45deg);margin:10px auto;box-shadow:0 8px 30px rgba(255,94,138,0.12)}
.big-heart::before,.big-heart::after{content:"";position:absolute;background:var(--accent);width:140px;height:140px;border-radius:50%}
.big-heart::before{top:-70px;left:0}
.big-heart::after{left:70px;top:0}
.big-heart:hover{filter:brightness(1.05);transform:scale(1.03) rotate(-45deg);transition:transform 200ms}

/* Sections */
.section{padding:1.25rem 0}
.muted{color:var(--muted)}
.quiz, .site-footer, .modal-panel, .typewriter{
  background: rgba(255,255,255,0.95);
  box-shadow: 0 8px 24px rgba(0,0,0,0.08);
  border-radius: var(--radius);
}

/* Timeline & gallery */
.timeline{padding-left:1rem}
.gallery-grid{
  display:grid;
  grid-template-columns:repeat(auto-fit,minmax(160px,1fr));
  gap:0.8rem;
  align-items:start;
}
.gallery-grid figure{margin:0; background:rgba(255,255,255,0.9); border-radius:10px; overflow:hidden; box-shadow:0 8px 20px rgba(0,0,0,0.06);}
.gallery-grid img{width:100%;height:200px;object-fit:cover;display:block}
.gallery-grid figcaption{padding:0.5rem 0.6rem;font-size:0.95rem;color:var(--muted);text-align:center;border-top:1px solid rgba(0,0,0,0.03)}

/* Make captions easier to edit later (js-friendly) */
.gallery-grid figcaption[contenteditable="true"]{outline:2px dashed rgba(255,94,138,0.12)}

/* Quiz */
.quiz{background:var(--card);padding:1rem;border-radius:var(--radius);box-shadow:0 6px 18px rgba(0,0,0,0.04)}
#answers button{display:block;margin:0.4rem 0;padding:0.6rem;border-radius:8px;border:1px solid #eee;background:#fff;width:100%;text-align:left}

/* Game */
.game-area{height:220px;background:linear-gradient(0deg,rgba(255,255,255,0.9), rgba(255,247,251,0.8));border-radius:12px;position:relative;overflow:hidden;border:1px dashed #ffe6ef}
.heart{position:absolute;width:36px;height:36px;pointer-events:auto;transform:rotate(-45deg)}
.heart:before,.heart:after{content:"";position:absolute;width:36px;height:36px;background:var(--accent);border-radius:50%}
.heart:before{top:-18px;left:0}
.heart:after{left:18px;top:0}

/* Small heart for secret */
.heart-small{background:var(--accent);color:#fff;border:none;border-radius:50%;width:64px;height:64px;font-size:28px;line-height:64px;box-shadow:0 8px 30px rgba(255,94,138,0.25);cursor:pointer}

/* Typewriter */
.typewriter{margin-top:1rem;background:#fff;padding:1rem;border-radius:10px;min-height:56px;border:1px solid #f2d9e1}

/* Footer */
.site-footer{padding:2rem 0;color:var(--muted);font-size:0.9rem}

/* Modal */
.modal{position:fixed;inset:0;display:flex;align-items:center;justify-content:center;background:rgba(0,0,0,0.45);z-index:100}
.modal.hidden{display:none}
.modal-panel{background:var(--card);padding:1.25rem;border-radius:12px;max-width:420px;width:90%;box-shadow:0 10px 40px rgba(0,0,0,0.18);position:relative;text-align:center}
.modal-actions{display:flex;gap:0.8rem;justify-content:center;margin-top:1rem;position:relative}
.modal-close{position:absolute;right:8px;top:8px;border:none;background:transparent;font-size:18px;cursor:pointer}

/* Tooltip-ish message (for playful no) */
.tooltip-msg{display:block;margin-top:0.5rem;color:var(--muted);font-size:0.95rem}

/* Utility */
.hidden{display:none}
CSS

cat > "$OUT_DIR/script.js" <<'JS'
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
      if(document.getElementById('countdown')) document.getElementById('countdown').textContent = "Happy Valentine's Day! 💖";
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
      valYes.textContent = "She said YES! 🥰";
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
    {q:"Where did we first meet?", a:["At the coffee shop","At the library","Online","At the park"], correct:0},
    {q:"What's my favorite dessert?", a:["Ice cream","Cheesecake","Chocolate cake","Fruit tart"], correct:2},
    {q:"Which movie did we watch on our first date?", a:["La La Land","Inception","A romcom","Toy Story"], correct:0}
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
JS

cat > "$OUT_DIR/optimize-images.js" <<'NODE'
// optimize-images.js
//
// Batch resize & convert images to WebP and optimized JPG using sharp.
//
// Usage:
// 1. npm init -y
// 2. npm install sharp
// 3. Put your original images in ./assets/ (e.g. photo1.jpg ... photo5.jpg)
// 4. node optimize-images.js
//
// Output:
// - ./assets/optimized/{basename}-{width}.webp
// - ./assets/optimized/{basename}-{width}.jpg

const fs = require('fs');
const path = require('path');
const sharp = require('sharp');

const srcDir = path.join(__dirname, 'assets');
const outDir = path.join(srcDir, 'optimized');
if (!fs.existsSync(outDir)) fs.mkdirSync(outDir, { recursive: true });

const files = [
  'photo1.jpg',
  'photo2.jpg',
  'photo3.jpg',
  'photo4.jpg',
  'photo5.jpg'
];

// widths to generate (responsive)
const widths = [400, 800, 1200];

(async () => {
  for (const file of files) {
    const name = path.basename(file, path.extname(file));
    const srcPath = path.join(srcDir, file);
    if (!fs.existsSync(srcPath)) {
      console.warn(`Skipping ${file} (not found in ${srcDir})`);
      continue;
    }
    for (const w of widths) {
      const outJpg = path.join(outDir, `${name}-${w}.jpg`);
      const outWebp = path.join(outDir, `${name}-${w}.webp`);
      try {
        // Resize and create a high-quality JPG optimized for web
        await sharp(srcPath)
          .rotate() // respect EXIF orientation
          .resize({ width: w, withoutEnlargement: true })
          .jpeg({ quality: 78, mozjpeg: true })
          .toFile(outJpg);
        // Create a good-quality WebP (smaller)
        await sharp(srcPath)
          .rotate()
          .resize({ width: w, withoutEnlargement: true })
          .webp({ quality: 72 })
          .toFile(outWebp);
        console.log(`Created: ${path.relative(process.cwd(), outJpg)} and ${path.relative(process.cwd(), outWebp)}`);
      } catch (err) {
        console.error(`Error processing ${file} @ ${w}px:`, err);
      }
    }
  }
  console.log('Done. Optimized images saved in ./assets/optimized/');
})();
NODE

cat > "$OUT_DIR/pack-and-optimize.sh" <<'BASH'
#!/usr/bin/env bash
# pack-and-optimize.sh
#
# Runs optimize-images.js (if present and Node is available) then creates
# valentine-assets.zip containing the ./assets directory (recursively).
#
# Usage:
#   ./pack-and-optimize.sh         # run optimizer if present, then zip
#   SKIP_OPT=1 ./pack-and-optimize.sh   # skip the optimizer even if present

set -euo pipefail

SRC_DIR="assets"
OUT="valentine-assets.zip"
OPT_SCRIPT="optimize-images.js"

echo "Starting pack-and-optimize.sh"
echo "Project root: $(pwd)"

# Check assets directory exists
if [ ! -d "$SRC_DIR" ]; then
  echo "Error: '$SRC_DIR' directory not found in $(pwd). Place your images in ./$SRC_DIR and retry."
  exit 1
fi

# Run optimizer if present and not explicitly skipped
if [ -f "$OPT_SCRIPT" ] && [ "${SKIP_OPT:-0}" != "1" ]; then
  echo "Found $OPT_SCRIPT — attempting to run image optimizer..."
  if command -v node >/dev/null 2>&1; then
    echo "Node.js detected: $(node --version)"
    # If sharp not installed, attempt to install dependencies
    if [ ! -d "node_modules/sharp" ]; then
      echo "sharp not found in node_modules. Installing dependencies..."
      # Prefer npm ci if lockfile exists, otherwise npm install
      if [ -f package-lock.json ]; then
        npm ci
      else
        npm install sharp
      fi
    else
      echo "sharp already installed."
    fi

    echo "Running: node $OPT_SCRIPT"
    node "$OPT_SCRIPT"
    echo "Image optimization complete."
  else
    echo "Warning: Node.js not found. Skipping image optimization."
    echo "Install Node.js (https://nodejs.org/) and run this script again to generate optimized images."
  fi
else
  if [ -f "$OPT_SCRIPT" ]; then
    echo "Image optimizer present but SKIP_OPT is set. Skipping optimization."
  else
    echo "No optimizer script ($OPT_SCRIPT) found — skipping optimization."
  fi
fi

# Create ZIP of the assets directory
if [ -f "$OUT" ]; then
  echo "Removing existing $OUT"
  rm -f "$OUT"
fi

echo "Creating zip archive $OUT from directory $SRC_DIR ..."
# Use zip -r; exclude macOS .DS_Store files
zip -r "$OUT" "$SRC_DIR" -x "**/.DS_Store" > /dev/null

echo "Created archive: $(ls -lh "$OUT")"
echo "Contents (first 50 lines):"
unzip -l "$OUT" | sed -n '1,50p'

echo "Done."
BASH

cat > "$OUT_DIR/.gitignore" <<'TXT'
node_modules/
*.log
.DS_Store
valentine-assets.zip
*.zip
TXT

cat > "$OUT_DIR/README.md" <<'MD'
Valentine Site
===============

This folder contains the single-page Valentine site.

Important:
- Add your images to the assets/ folder:
  - background.jpg
  - photo1.jpg ... photo5.jpg
- To generate optimized images run the optimizer:
  - npm init -y
  - npm install sharp
  - node optimize-images.js
  or simply run the included pack-and-optimize.sh

To zip the assets:
- ./pack-and-optimize.sh  (or use create_site_and_zip.sh which created this project)

Enjoy!
MD

echo "Writing complete. Creating zip ${OUT_ZIP} ..."
cd "$OUT_DIR"
zip -r "../$OUT_ZIP" . -x "**/.DS_Store" > /dev/null
cd ..

echo "Done. Created ${OUT_ZIP} in $(pwd)"
echo ""
echo "Next steps:"
echo " 1) Add your images into ${OUT_DIR}/assets/ (background.jpg, photo1.jpg ... photo5.jpg)."
echo " 2) Optionally run optimize-images.js (see README) to generate assets/optimized/."
echo " 3) Use the created zip (valentine_site.zip) for upload or extraction."