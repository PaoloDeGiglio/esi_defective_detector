const arrayImages = [
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0158_Back-Greige-Seam-Impression-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0140_Bias-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0178_Birdseye-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0139_Bow-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0188_Broken-Color-Pattern-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0080_Broken-End-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0078_Broken-Pattern-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0117_Broken-Pattern-Color-Misdraw-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0065_Broken-Pick-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0067_Broken-Pick-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0059_Broken-Pick-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0058_Burl-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0099_Burl-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0104_Burl-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0095_Burl-Mark-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0096_Burl-Mark-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0118_Buttonhole-Selvage-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0049_Chopped-Filling-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0050_Chopped-Filling-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0142_Clip-Mark-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0023_Coarse-End-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0024_Coarse-End-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0090_Coarse-End-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0055_Coarse-Pick-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0056_Coarse-Pick-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0060_Coarse-Pick-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0062_Coarse-Pick-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0172_Coarse-Yarn-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0054_Cockled-Yarn-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0134_Color-Fly-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0135_Color-Fly-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0159_Color-Out-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0160_Color-Smear-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0131_Color-Spot-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0181_Compactor-Creases-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0124_Correct-Cover-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0128_Corrugation-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0136_Crease-Streak-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0137_Crease-Sueded-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0152_Doctor-Blade-Streak-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0153_Doctor-Blade-Streak-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0022F_Double-End-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0022B_Double-End-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0027_Double-End-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0034_Double-End-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0170_Double-End-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0073_Double-Picks-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0165_Dragging-End-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0107_Drawback-Small-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0108_Drawback-Small-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0087_Drawbacks-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0088_Drawbacks-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0089_Drawbacks-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0038_Dropped-Picks-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0039_Dropped-Picks-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0189_Dropped-Stitches-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0190_Dropped-Stitches-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0014_End-Out-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0016_End-Out-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0017_End-Out-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0025_End-Out-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0028_End-Out-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0033_End-Out-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0162_End-Out-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0163_End-Out-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0164_End-Out-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0166_End-Out-Straying-End-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0086_Filling-Floats-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0113_Filling-Floats-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0111_Filling-Slub-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0112_Filling-Slub-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0191_Fine-Yarn-Loose-Course-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0026_Flat-Harness-Misdraw-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0032_Flat-Harness-Misdraw-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0083_Foreign-Fiber-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0121_Fuzz-Balls-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0097_Gouts-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0106_Hang-Pick-Loopy-Filling-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0091_Hang-Thread-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0066_Harness-Balk-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0035_Harness-Breakdown-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0036_Harness-Breakdown-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0013_Harness-Misdraw-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0015_Harness-Misdraw-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0183_Hole-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0184_Hole-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0149_Indigo-Dye-Range-Stop-300x300.jpg",
  "https://www.cottoninc.com/wp-content/uploads/2017/05/0046_Jerk-In-300x300.jpg",
];

const fs = require('fs');
const axios = require('axios');

/* ============================================================
  Function: Download Image
============================================================ */

const download_image = (url, image_path) =>
  axios({
    url,
    responseType: 'stream',
  }).then(
    response =>
      new Promise((resolve, reject) => {
        response.data
          .pipe(fs.createWriteStream(image_path))
          .on('finish', () => resolve())
          .on('error', e => reject(e));
      }),
  );

/* ============================================================
  Download Images in Order
============================================================ */

(async () => {

  let i =1;
  for(let img of arrayImages){
    let example_image_1 = await download_image(img, 'images/img-'+i+'.jpg')
    i++;
  }
  
})();