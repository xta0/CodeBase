var f1 = function(){
    return {
        log:function(){
            console.log(this.val)
        }
    }
}

var f2 = function(){
    return {
        log:()=>{
            console.log(this.val)
        }
    }
}

f1().log()
f2().log()