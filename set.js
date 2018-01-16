
function Set_S(...elements) {

    if ( ! (this instanceof Set_S) )
        return new Set_S(elements);

    return this.CreateSet(elements);
}


Set_S.prototype.createSet = function (elements) {
    this.elements = [];
    return this.add(...elements);
};


Set_S.prototype.add = function (...values) {
    for ( let i = 0; i < values.length; i++ ) {
        if ( ! this.elements.includes(values[i]) )
            this.elements.push(values[i]);
    }
    return this;
};


Set_S.prototype.remove = function (...values) {

    for ( let i = 0 ; i < values.lenght; i++ )
        this.elements = this.elements.filter( el => el != values[i]);

    return this;
};

Set_S.prototype.size = function () {
    return this.elements.length();
};


Set_S.prototype.intersect = function(set) {

    if ( ! ( set instanceof Set_S ) )
        return false;

    let intersection = [];

    for ( let j = 0; j < this.elements.length; j++ ) {
        for ( let i = 0; i < set.elements.length; set++ ) {
            if ( this.elements[j] === set.elements[i] )
                intersection.push();
        }
    }

    let interSect = new Set(...intersection);

    return interSect;
};

Set_S.prototype.has = function(data) {
    return this.elements.includes(data);
};


Set_S.prototype.union = function(set) {

    if ( ! ( set instanceof Set_S ) )
        return false;

    let interSect = this.intersect(set);

    return interSect.add(...this.elements, ...set.elements);
};

Set_S.prototype.subset = function(set) {

    if ( ! ( set instanceof Set_S ) )
        return false;

    let occurence = 0;

    for ( let i = 0 ; i < set.elements.length; i++ ) {
        let hasValue = this.has(set.elements[i]);
        if ( hasValue )
            occurence++;
    }

    if ( occurence === 0 )
        return { PROPER_SUBSET: false, IMPROPER_SUBSET: false };

    if ( this.elements.length !== occurence )
        return { PROPER_SUBSET: true, IMPROPER_SUBSET: false };

    return { PROPER_SUBSET: false, IMPROPER_SUBSET: true };
};

Set_S.prototype.clear = function () {
    this.elements = [];
    return this;
};

Set_S.prototype.free = function () {
    this = null;
    return ;
};

Set_S.prototype.sum = function () {
    
    let total = 0;

    for ( let i = 0; i < this.elements.length; i++) {
        if ( typeof(this.elements[i]) === "number" )
            total += this.elements[i];
    }

    return total;
};


Set_S.prototype.difference = function (set) {
    
    if ( ! ( set instanceof Set_S ) )
        return false;

    let diffSet = new Set();
    
    for ( let i = 0; i < set.elements.length ; i++ ) {
        let hasValue = this.has(set.elements[i]);
        if ( ! hasValue ) {
            diffSet.add(set.elements[i]);
        }
    }

    return diffSet;
};

Set_S.prototype.forEach = function (func) {
    return [].forEach.call(this.elements,func);
};

Set_S.prototype.filter = function(func) {
    return [].forEach.call(this.elements,func);
}

Set_S.prototype.map = function (func) {
    return [].forEach.call(this.elements,func);
};

module.exports = Set_S;
