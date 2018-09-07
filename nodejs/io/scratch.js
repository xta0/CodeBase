var fs =  require('fs');
fs.writeFile(__dirname + "/index.html", "<h1>HTML is greate</h1>",(error)=>{
    if(error){
        return console.log(error);
    }else{
        return console.log("Succeed!");
    }
});