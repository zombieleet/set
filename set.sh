#!/usr/bin/env bash


# VALID_SET array holds all set name
declare -a VALID_SET;



# checks if a set is valid
validSet() {

    local setname=${1}

    [[ ! ${setname} =~ ^([[:alpha:]]|_) ]] && return 1;

    [[ ${setname} =~ [[:space:]] ]] && return 1;


    local -n setname__=${setname}

    local found=0;

    for v_item in "${VALID_SET[@]}";do
        [[ "${setname}" == "${v_item}" ]] && found=1 && break;
    done

    for items in "${setname__[@]}";do
        declare -i contains=0;
        for items__ in "${setname_[@]}";do
            [[ "${items}" == "${items__}" ]] && contains+=1;
        done
        (( contains > 1 )) && found=0 && break;
    done

    (( found == 0 )) && return 1;

    return 0;
}

# creates a set
createSet() {

    # first argument should be the name you want to hold
    #         the set values
    # second argument should be list of value to add to argument 1
    # the set will contain unique values
    # this function should be called before any other fucntion
    # createSet mySet 1 2 3 4 bash ksh zsh zsh
    # echo ${mySet[@]}  => 1 2 3 4 bash ksh zsh


    local check_valid_set_name=${1}

    [[ ! ${check_valid_set_name} =~ ^([[:alpha:]]|_) ]] && return 1;

    [[ ${check_valid_set_name} =~ [[:space:]] ]] && return 1;

    shift;

    VALID_SET+=( "${check_valid_set_name}" )

    for n_set in "${@}";do
        add "${check_valid_set_name}" "${n_set}"
    done

    return 0;
}


add() {

    # first argument should be the set array
    #    that would all the values represented by shift ; ${@}
    # add mySet 7 8 9 10 3 4
    # echo ${mySet[@]} 1 2 3 4 bash ksh zsh 7 8 9 10

    local check_valid_set_name=${1}

    [[ ! ${check_valid_set_name} =~ ^([[:alpha:]]|_) ]] && return 1;

    [[ ${check_valid_set_name} =~ [[:space:]] ]] && return 1;

    validSet "${check_valid_set_name}"

    (( $? == 1 )) && return 1;

    local -n add_to_set=${check_valid_set_name};

    declare -i add_to_set_length=${#add_to_set[@]};

    shift;

    (( $# == 0 )) && return 1;

    for add_new_item in "${@}";do

        isin=0;

        for (( idx=0 ; idx < add_to_set_length; idx++ ));do

            [[ "${add_to_set[$idx]}" == "${add_new_item}" ]] && {
                isin=1;
                break;
            }

        done

        (( isin == 0 )) && {
            add_to_set+=( "${add_new_item}" );
        }

    done

    return 0;

}


remove() {

    # first argument should be a set cretead by createSet
    # subsequent argument should be the values specified by shift ; ${@}
    #   to be removed

    # remove mySet ksh zsh


    local check_valid_set_name=${1}

    [[ ! ${check_valid_set_name} =~ ^([[:alpha:]]|_) ]] && return 1;

    [[ ${check_valid_set_name} =~ [[:space:]] ]] && return 1;

    validSet "${check_valid_set_name}"

    (( $? == 1 )) && return 1;

    local -n remove_from_set=${check_valid_set_name};

    declare -i remove_item_length=${#remove_from_set[@]}

    shift ;


    (( $# == 0 )) && return 1;

    for remove_item in "${@}";do

        for (( idx=0 ; idx < remove_item_length; idx++ ));do

            [[ "${remove_from_set[$idx]}" == "${remove_item}" ]] && {
                unset remove_from_set[$idx];
                break;
            }

        done

    done

    return 0;

}

size() {

    # returns the size of a set
    # first argument should be a set created by createSet
    # second argument should be name of the variable to hold
    #   the size of the set

    # size mySet setSize
    # echo "${setSize}"

    local check_valid_set_name=${1}
    local check_valid_set_size=${2}

    {
        [[ ! ${check_valid_set_name} =~ ^([[:alpha:]]|_) ]] || \
            [[ ! ${check_valid_set_size} =~ ^([[:alpha:]]|_) ]]
    } && return 1;


    {
        [[ ${check_valid_set_name} =~ [[:space:]] ]] || \
            [[ ${check_valid_set_size} =~ [[:space:]] ]]
    } && return 1;

    validSet "${check_valid_set_name}"
    (( $? == 1 )) && return 1;

    local -n set_name_=${check_valid_set_name}
    local -n set_size_=${check_valid_set_size}

    set_size_=${#set_name_[@]}

}

intersect() {

    # requires 3 argument
    # argument 1 and 2 should be set created by createSet

    # add the intersection of argument 1 and 2 to argument 3

    # createSet anotherSet 1 2 3 bash foo bar baz
    # intersect mySet anotherSet intersectSet

    # echo ${intersectSect[@]} => 1 2 3 bash

    local check_valid_first_set=${1}
    local check_valid_second_set=${2}
    local check_intersect_result=${3}

    {
        [[ ! ${check_valid_first_set} =~ ^([[:alpha:]]|_) ]] || \
            [[ ! ${check_valid_second_set} =~ ^([[:alpha:]]|_) ]] || \
            [[ ! ${check_intersect_result} =~ ^([[:alpha:]]|_) ]]

    } && return 1;


    {
        [[ ${check_valid_first_set} =~  [[:space:]] ]] || \
            [[ ${check_valid_second_set} =~  [[:space:]] ]] || \
            [[ ${check_intersect_result} =~ [[:space:]] ]]
    } && return 1;

    validSet "${check_valid_first_set}"
    (( $? == 1 )) && return 1;

    validSet "${check_valid_second_set}"
    (( $? == 1 )) && return 1;


    local -n first_intersect_set=${check_valid_first_set};
    local -n second_intersect_set=${check_valid_second_set};
    local -n intersect_result=${check_intersect_result};

    VALID_SET+=( "${check_intersect_result}" )

    for first_set_val in "${!first_intersect_set[@]}";do

        for second_set_val in "${!second_intersect_set[@]}";do

            [[ "${first_intersect_set[$first_set_val]}" == "${second_intersect_set[$second_set_val]}" ]] && {
                intersect_result+=( "${first_intersect_set[$first_set_val]}" );
                break;
            }

        done

    done
    return 0;
}


has() {

    # requires 2 arguments
    # argument 1 is a set created by createSet
    # argument 2 is the value to check for it's existence in argument 1
    # return value is 0 for true( arg 2 is in arg 1 ) and 1 for false ( arg 2 is not in arg 1 )
    # has anotherSet foo


    local check_valid_set_name=${1}
    local has_data=${2}

    [[ ! ${check_valid_set_name} =~ ^([[:alpha:]]|_) ]] && return 1;

    [[ ${check_valid_set_name} =~ [[:space:]] ]] && return 1;

    [[ -z "${has_data}" ]] && return 1;

    validSet "${check_valid_set_name}";
    (( $? == 1 )) && return 1;

    local -n has_set=${check_valid_set_name};

    for has_set_item in "${has_set[@]}";do
        [[ "${has_set_item}" == "${has_data}" ]] && return 0;
    done

    return 1;
}

union() {

    # opposite of intersect
    # requires 3 argument
    # argument 1 and argument 2 are set created by createSet
    # the union of argument 1 and argument 2 will be placed in argument 3
    # argument 3 will be created as a set

    # union mySet anotherSet unionSet

    # echo ${unionSet[@]} => 1 2 3 bash foo bar baz

    local check_valid_first_set=${1}
    local check_valid_second_set=${2}
    local check_union_result=${3}

    {
        [[ ! ${check_valid_first_set} =~ ^([[:alpha:]]|_) ]] || \
            [[ ! ${check_valid_second_set} =~ ^([[:alpha:]]|_) ]] || \
            [[ ! ${check_union_result} =~ ^([[:alpha:]]|_) ]]

    } && return 1


    {
        [[ ${check_valid_first_set} =~  [[:space:]] ]] || \
            [[ ${check_valid_second_set} =~  [[:space:]] ]] || \
            [[ ${check_union_result} =~ [[:space:]] ]]
    } && return 1

    validSet "${check_valid_first_set}";
    (( $? == 1 )) && return 1;

    validSet "${check_valid_second_set}";
    (( $? == 1 )) && return 1;

    local -n first_union_set=${check_valid_first_set};
    local -n second_union_set=${check_valid_second_set};
    #local -n union_result=${check_union_result};

    createSet "${check_union_result}";

    #intersect first_union_set second_union_set union_result

    intersect "${check_valid_first_set}" "${check_valid_second_set}" "${check_union_result}"


    add "${check_union_result}" "${first_union_set[@]}"
    add "${check_union_result}" "${second_union_set[@]}"

    return 0;

}


subset() {

    # requires 2 argument
    # argument 1 and argument 2 are both sets
    # this function checks if argument 1 is a subset of argument 2
    #    it deals with both proper subset and improper subset

    # if argument 1 is a proper subset of argument 2
    #    global variable PROPER_SUBSET=true
    # if argument 1 is not a proper subset of argument 2
    #    global variable IMPROPER_SUBSET=true

    # subset mySet unionSet
    # echo ${PROPER_SUBSET} => false
    # echo ${IMPROPER_SUBSET} => true

    # createSet setOne 1 2 3
    # createSet setTwo 1 2 3

    # subset setOne setTwo
    # echo ${PROPER_SUBSET} => true
    # echo ${IMPROPER_SUBSET} => false

    local check_valid_first_set=${1}
    local check_valid_second_set=${2}

    {
        [[ ! ${check_valid_first_set} =~ ^([[:alpha:]]|_) ]] || \
            [[ ! ${check_valid_second_set} =~ ^([[:alpha:]]|_) ]]

    } && return 1;


    {
        [[ ${check_valid_first_set} =~  [[:space:]] ]] || \
            [[ ${check_valid_second_set} =~  [[:space:]] ]]
    } && return 1;

    validSet "${check_valid_first_set}";
    (( $? == 1 )) && return 1;

    validSet "${check_valid_second_set}";
    (( $? == 1 )) && return 1;

    local -n first_pset=${check_valid_first_set}
    local -n second_pset=${check_valid_second_set}


    declare -i occurence=0;


    for spset in "${second_pset[@]}";do
        #has first_pset "${spset}"
        has "${check_valid_first_set}" "${spset}"
        [[ $? == 0 ]] && occurence+=1;
    done

    # no match
    (( occurence == 0 )) && return 1;

    # proper subset, not all of second_pset is in first_pset
    [[ "${#first_pset[@]}" != "${occurence}" ]] && {
        declare -g PROPER_SUBSET="true"
        declare -g IMPROPER_SUBSET="false"
        return 0;
    }

    # improper subset, all of second_pset is in first_pset
    [[ "${#first_pset[@]}" == "${occurence}" ]] && {
        declare -g PROPER_SUBSET="false"
        declare -g IMPROPER_SUBSET="true"
        return 0;
    }
}


closestTo() {

    # requires 3 argument
    # argument 1 is created by createSet
    # argument 2 is the value to check for it's closest value
    # argument 3 holds the final result

    # add setTwo 23 34 54 22 30

    # closestTo setTwo 5 nearValue
    # echo ${nearValue} 3

    local check_valid_closest=${1}
    local data_to_check=${2}
    local check_valid_result=${3}

    {
        [[ ! ${check_valid_closest} =~ ^([[:alpha:]]|_) ]] || \
            [[ ! ${check_valid_result} =~ ^([[:alpha:]]|_) ]]

    } && return 1;


    {
        [[ ${check_valid_closest} =~  [[:space:]] ]] || \
            [[ ${check_valid_result} =~  [[:space:]] ]]
    } && return 1;


    validSet "${check_valid_closest}";
    (( $? == 1 )) && return 1;

    local -n closest_set=${check_valid_closest}
    local -n result_set=${check_valid_result}


    declare -a close_nums=( ${closest_set[@]} )


    local closest_value=${closest_set[0]}
    local prev=$( bc <<<"${closest_value} - ${data_to_check}")
    prev=${prev#-}

    for close_item in "${close_nums[@]}";do
        local diff=$( bc <<<"${close_item} - ${data_to_check}");
        diff=${diff#-}
        if (( diff < prev ));then
            prev=${diff};
            closest_value=${close_item}
        fi
    done

    result_set=${closest_value}

    return 0;
}


clear() {

    # this function clears the entire set
    # requires only 1 argument
    # argument 1 is a set created by createSet


    # clear intersectSect
    # clear unionSet
    # clear mySet
    # clear anotherSet


    local check_clear_set=${1}

    [[ ! ${check_clear_set} =~ ^([[:alpha:]]|_) ]] && return 1;


    [[ ${check_clear_set} =~ [[:space:]] ]] &&  return 1;

    validSet "${check_clear_set}";
    (( $? == 1 )) && return 1;

    local -n clear_set_name=${check_clear_set}

    unset clear_set_name;

    return 0;
}

sum() {

    # this function sums up the entire set element
    # requires 2 argument
    # argument 1 is a set created by createSet
    # argument 2 a variable to hold the sum of all elements of the set

    # sum setTwo total
    # echo ${total} => 169

    local check_sum_set=${1}
    local check_sum_output=${2}

    [[ "$(type -t bc)" != "file" ]] && return 1;

    {
        [[ ! ${check_sum_set} =~ ^([[:alpha:]]|_) ]] || \
            [[ ! ${check_sum_output} =~ ^([[:alpha:]]|_) ]]
    } && return 1;


    {
        [[ ${check_sum_set} =~ [[:space:]] ]] || \
            [[ ${check_sum_output} =~ [[:space:]] ]]
    }  && return 1;


    validSet "${check_sum_set}";
    (( $? == 1 )) && return 1;


    local -n sum_set=${check_sum_set}
    local -n sum_output=${check_sum_output}

    local total=0;

    for sum_item in "${sum_set[@]}";do
        #[[ ${sum_set} =~ ^([0-9]+|[0-9]+\.[0-9]+)$ ]] && total+=${sum_item}
        total=$( bc <<<"${sum_item} + ${total}")
    done

    sum_output=${total}

    return 0;
}

difference() {

    # requires 3 argument
    # argument 1 and 2 are set created by createSet

    # the elements which are in argument 1 but not in argument 2
    #   is placed in the third argument

    # the third argument will be created as a set by this function

    # difference setOne setTwo diffSet

    # echo ${diffSet[@]} => 23 34 54 22 30


    local check_diff_first=${1}
    local check_diff_second=${2}
    local check_diff_output=${3}

    {
        [[ ! ${check_diff_first} =~ ^([[:alpha:]]|_) ]] || \
            [[ ! ${check_diff_second} =~ ^([[:alpha:]]|_) ]] || \
            [[ ! ${check_diff_output} =~ ^([[:alpha:]]|_) ]]
    }  && return 1;


    {
        [[ ${check_diff_first} =~ [[:space:]] ]] || \
            [[ ${check_diff_second} =~ [[:space:]] ]] || \
            [[ ${check_diff_output} =~ [[:space:]] ]]
    } && return 1;

    validSet "${check_diff_first}";
    (( $? == 1 )) && return 1;

    validSet "${check_diff_second}";
    (( $? == 1 )) && return 1;

    #local -n first_diff=${check_diff_first}
    local -n second_diff=${check_diff_second}
    local -n output_diff=${check_diff_output}

    VALID_SET+=( "${check_diff_output}" )

    for second_item in "${second_diff[@]}";do
        has "${check_diff_first}" "${second_item}"
        (( $? == 1 )) && output_diff+=( "${second_item}" )
    done

    return 0;
}
