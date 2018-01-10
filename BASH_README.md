
# createSet

    first argument should be the name you want to hold the set values
    second argument should be list of value to add to argument 1
    the set will contain unique values
    this function should be called before any other fucntion
```bash
    createSet mySet 1 2 3 4 bash ksh zsh zsh
    echo ${mySet[@]}  => 1 2 3 4 bash ksh zsh
```


# add

    first argument should be the set array
    that would all the values represented by shift ; ${@}
    
```bash
    add mySet 7 8 9 10 3 4
    echo ${mySet[@]} 1 2 3 4 bash ksh zsh 7 8 9 10
```

# remove

    first argument should be a set cretead by createSet
    subsequent argument should be the values specified by shift ; ${@} to be removed
    `remove mySet ksh zsh`


# size

    returns the size of a set
    first argument should be a set created by createSet
    second argument should be name of the variable to hold
    the size of the set
    
```bash
    size mySet setSize
    echo "${setSize}"
```

# intersect

    requires 3 argument
    argument 1 and 2 should be set created by createSet
    add the intersection of argument 1 and 2 to argument 3

```bash
    createSet anotherSet 1 2 3 bash foo bar baz
    intersect mySet anotherSet intersectSet
    echo ${intersectSect[@]} => 1 2 3 bash
```


# has

    requires 2 arguments
    argument 1 is a set created by createSet
    argument 2 is the value to check for it's existence in argument 1
    return value is 0 for true( arg 2 is in arg 1 ) and 1 for false ( arg 2 is not in arg 1 )
    `has anotherSet foo`
    
# union

    opposite of intersect
    requires 3 argument
    argument 1 and argument 2 are set created by createSet
    the union of argument 1 and argument 2 will be placed in argument 3
    argument 3 will be created as a set

```bash
    union mySet anotherSet unionSet
    echo ${unionSet[@]} => 1 2 3 bash foo bar baz
```


# subset

    requires 2 argument
    argument 1 and argument 2 are both sets
    this function checks if argument 1 is a subset of argument 2
    it deals with both proper subset and improper subset
    if argument 1 is a proper subset of argument 2
    global variable PROPER_SUBSET=true
    if argument 1 is not a proper subset of argument 2
    global variable IMPROPER_SUBSET=true

```bash
    subset mySet unionSet
    echo ${PROPER_SUBSET} => false
    echo ${IMPROPER_SUBSET} => true
    createSet setOne 1 2 3
    createSet setTwo 1 2 3
    subset setOne setTwo
    echo ${PROPER_SUBSET} => true
    echo ${IMPROPER_SUBSET} => false
```
    
# closestTo

    requires 3 argument
    argument 1 is created by createSet
    argument 2 is the value to check for it's closest value
    argument 3 holds the final result
```bash
    add setTwo 23 34 54 22 30
    closestTo setTwo 5 nearValue
    echo ${nearValue} 3
```


# clear

    this function clears the entire set
    requires only 1 argument
    argument 1 is a set created by createSet

```bash
    clear intersectSect
    clear unionSet
    clear mySet
    clear anotherSet
```

# sum

    this function sums up the entire set element
    requires 2 argument
    argument 1 is a set created by createSet
    argument 2 a variable to hold the sum of all elements of the set

```bash
    sum setTwo total
    echo ${total} => 169
```



# difference

    requires 3 argument
    argument 1 and 2 are set created by createSet
    the elements which are in argument 1 but not in argument 2
    is placed in the third argument
    the third argument will be created as a set by this function

```bash
    difference setOne setTwo diffSet
    echo ${diffSet[@]} => 23 34 54 22 30
```
