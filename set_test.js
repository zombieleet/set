const assert = require("assert");

const Set_S = require("./set.js");

const mySet_S = new Set_S("victory", "favour", "christopher", "fumilayo");

const anotherSet_S = Set_S(1,2,3,4,"victory");

//console.log(anotherSet_S);

Object.assign(assert, {
    
    isFalse(condition,assertion) {
        
        if ( ! condition )
            return ;
        
        new assert.AssertionError({
            actual: true,
            expected: false
        });
        
        return ;
    }
});

assert(mySet_S instanceof Set_S, "mySet_S is not an instance of Set_S");
assert(anotherSet_S instanceof Set_S, "mySet_S is not an instance of Set_S");


mySet_S.add("johnson", "gideon");

assert(mySet_S.has("johnson"), "johnson is not in set");
assert(mySet_S.has("gideon"), "gideon is not in set");


mySet_S.remove("johnson", "victory");

assert.isFalse(mySet_S.has("johnson"), "johnson is still in set");
assert.isFalse(mySet_S.has("victory"), "victory is still in set");
assert(mySet_S.size(), "unexpected error in size method");


const intersectResult = mySet_S.intersect(anotherSet_S);

assert(intersectResult.has("victory"), "cannot find victory in intersectResult");


const unifySet_S = mySet_S.union(anotherSet_S);


mySet_S.forEach( elem => {
    assert(unifySet_S.has(elem), elem + " is not in unifySet_S");
});


anotherSet_S.forEach( elem => {
    assert(unifySet_S.has(elem), elem + " is not in unifySet_S");
});


let subsetResult = unifySet_S.subset(anotherSet_S);

assert.strictEqual(subsetResult.PROPER_SUBSET, true, "set is a proper subset");
assert.strictEqual(subsetResult.IMPROPER_SUBSET, false, "set is not a proper subset");

subsetResult = unifySet_S.subset(new Set_S());

assert.strictEqual(subsetResult.PROPER_SUBSET, false, "new set is not a subset of unifySet");
assert.strictEqual(subsetResult.IMPROPER_SUBSET, false, "new set is not a subset of unifySet");


subsetResult = unifySet_S.subset(new Set_S(...unifySet_S.elements));


assert.strictEqual(subsetResult.PROPER_SUBSET, false, "new set is not a proper subset of unifySet");
assert.strictEqual(subsetResult.IMPROPER_SUBSET, true, "new set is an improper subset of unifySet");

const numbers = new Set_S(1,2,5,12,30,50);

assert.strictEqual(numbers.sum(), 100, "sum should add all numbers");

const diff = anotherSet_S.difference(mySet_S);

assert(! diff.has("victory"), "victory is the difference of the sets");

assert(diff.peek(), "get a randomv value");
