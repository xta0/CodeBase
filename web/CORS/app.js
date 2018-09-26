// let myHeaders = new Headers({
//   'Access-Control-Allow-Origin': '*',
//   //   'Content-Type': 'text/plain',
//   'Content-Type': 'application/json'
// });
fetch('http://127.0.0.1:9000', {
  method: 'GET',
  //   credentials: 'include',
  headers: {
    'Content-Type': 'application/json'
  }
})
  .then(res => console.log(res))
  //   .then(function(res) {
  //     console.log(res);
  //     return res.json();
  //   })
  //   .then(function(JSON) {
  //     console.log(JSON);
  //   })
  .catch(err => console.log(err));
