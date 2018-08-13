module.exports = {
    inheritate : function(base,parent){
        base.prototype = new parent()
    }
}