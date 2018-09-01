const execSync = require('child_process').execSync;
execSync('ls -al',{stdio:[0,1,2]}, (error, stdout, stderr) => {
  if (error) {
    console.error(`exec error: ${error}`);
    return;
  }
  console.log(`stdout: ${stdout}`);
  console.log(`stderr: ${stderr}`);
});
console.log('finished')