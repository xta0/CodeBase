var a = 1;
{
  var a = 2;
}
console.log(a);

function getClothing(isCold) {
  if (isCold) {
    var freezing = 'Grab a jacket!';
  } else {
    {
      var freezing2 = "a";
    }
    var hot = 'It’s a shorts kind of day.';
    console.log(freezing);//undefined
    console.log(freezing2);//undefined
  }
}
getClothing(false)


