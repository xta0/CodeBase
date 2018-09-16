const url = 'https://www.google.com';
const request = fetch(url);
request
  .then(data => {
    console.log(data);
  })
  .catch(error => {
    console.log(error);
  });
