# from project root
# ensure Node is installed, then:
npm init -y
npm install sharp
# run the optimizer script (ensure optimize-images.js is in the project root)
node optimize-images.js
# the optimized images will be in ./assets/optimized/
ls -lah assets/optimized || echo "No optimized folder found"