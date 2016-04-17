/**
 * Created by Zsolti on 17/04/2016.
 */


if (!Array.prototype.last){
    Array.prototype.last = function(){
        return this[this.length - 1];
    };
};