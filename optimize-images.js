/**
 * optimize-images.js
 *
 * Batch resize & convert images to WebP and optimized JPG using sharp.
 *
 * Usage:
 * 1. npm init -y
 * 2. npm install sharp
 * 3. Put your original images in ./assets/ (e.g. photo1.jpg ... photo5.jpg)
 * 4. node optimize-images.js
 *
 * Output:
 * - ./assets/optimized/{basename}-{width}.webp
 * - ./assets/optimized/{basename}-{width}.jpg
 *
 * Edit the 'files' array if your filenames differ.
 */

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