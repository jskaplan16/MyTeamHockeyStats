const puppeteer = require('puppeteer');
(async () => {
  const browser = await puppeteer.launch({ headless: true });
  const page = await browser.newPage();
  
  console.log('Loading page...');
  await page.goto('https://gamesheetstats.com/seasons/6570/games/1878240', {
    waitUntil: 'networkidle2',
    timeout: 60000
  });
  
  console.log('Waiting for content to load (checking for spinner to disappear)...');
  
  // Wait for spinner to disappear - adjust selector based on the actual spinner class
  try {
    await page.waitForFunction(
      () => {
        const spinners = document.querySelectorAll('.spinner, .loading, [class*="spin"], [class*="load"]');
        return spinners.length === 0 || Array.from(spinners).every(s => s.style.display === 'none');
      },
      { timeout: 30000 }
    );
    console.log('Spinner disappeared, content loaded');
  } catch (e) {
    console.log('Timeout waiting for spinner, continuing anyway...');
  }
  
  // Additional wait to ensure all data is rendered
  console.log('Waiting additional 5 seconds for data rendering...');
  await new Promise(resolve => setTimeout(resolve, 5000));
  
  console.log('Generating PDF...');
  await page.pdf({ 
    path: 'gamesheet_6570_1878240.pdf', 
    format: 'A4',
    printBackground: true
  });
  
  console.log('PDF generated successfully!');
  await browser.close();
})();