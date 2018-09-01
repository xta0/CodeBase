module.exports = {
    inheritate : function(base,parent){
        base.prototype = Object.create(parent.prototype)
        base.prototype.constructor = base;
    }
}