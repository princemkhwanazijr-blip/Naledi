# from project root
# 1) (optional) optimize images
npm init -y
npm install sharp
node optimize-images.js

# 2) create a zip of the assets (optional)
zip -r valentine-assets.zip assets

# 3) create repo on GitHub and push
gh repo create princemkhwanazijr-blip/valentine-site --public --source=. --remote=origin --push

# After this, visit:
# https://github.com/princemkhwanazijr-blip/valentine-site/settings/pages
# and enable Pages if needed (or, if the repo name is princemkhwanazijr-blip.github.io, the site will be live at that URL).