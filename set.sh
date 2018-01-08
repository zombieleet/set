#!/usr/bin/env bash
#TODO: check validity of set i.e if set
#   was actually created by createSet function

#[[ "${DEBUG}" == "true" ]] && set -u

createSet() {

    local check_valid_set_name=${1}

    [[ ! ${check_valid_set_name} =~ ^([[:alpha:]]|_) ]] && {
        return 1;
    }

    [[ ${check_valid_set_name} =~ [[:space:]] ]] && {
        echo "space"
        return 1;
    }

    local -n new_set_name=${check_valid_set_name}

    shift;

    (( $# == 0 )) && {
        return 1;
    }

    new_set_name=( ${@} );

    return 0;
}

add() {

    local check_valid_set_name=${1}

    [[ ! ${check_valid_set_name} =~ ^([[:alpha:]]|_) ]] && {
        return 1;
    }

    [[ ${check_valid_set_name} =~ [[:space:]] ]] && {
        return 1;
    }

    local -n add_to_set=${check_valid_set_name};

    declare -i add_to_set_length=${#add_to_set[@]};

    shift;

    (( $# == 0 )) && {
        return 1;
    }

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

    local check_valid_set_name=${1}

    [[ ! ${check_valid_set_name} =~ ^([[:alpha:]]|_) ]] && {
        return 1;
    }

    [[ ${check_valid_set_name} =~ [[:space:]] ]] && {
        echo "space"
        return 1;
    }

    local -n remove_from_set=${check_valid_set_name};

    declare -i remove_item_length=${#remove_from_set[@]}

    shift ;


    (( $# == 0 )) && {
        return 1;
    }

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

    local check_valid_set_name=${1}
    local check_valid_set_size=${2}

    {
        [[ ! ${check_valid_set_name} =~ ^([[:alpha:]]|_) ]] || \
            [[ ! ${check_valid_set_size} =~ ^([[:alpha:]]|_) ]]
    } && {
        echo "shit"
        return 1;
    }


    {
        [[ ${check_valid_set_name} =~ [[:space:]] ]] || \
            [[ ${check_valid_set_size} =~ [[:space:]] ]]
    } && {
        echo "space"
        return 1;
    }

    local -n set_name_=${check_valid_set_name}
    local -n set_size_=${check_valid_set_size}

    set_size_=${#set_name_[@]}

}

intersect() {

    local check_valid_first_set=${1}
    local check_valid_second_set=${2}
    local check_intersect_result=${3}

    {
        [[ ! ${check_valid_first_set} =~ ^([[:alpha:]]|_) ]] || \
            [[ ! ${check_valid_second_set} =~ ^([[:alpha:]]|_) ]] || \
            [[ ! ${check_intersect_result} =~ ^([[:alpha:]]|_) ]]

    } && {
        return 1;
    }


    {
        [[ ${check_valid_first_set} =~  [[:space:]] ]] || \
            [[ ${check_valid_second_set} =~  [[:space:]] ]] || \
            [[ ${check_intersect_result} =~ [[:space:]] ]]
    } && {
        return 1;
    }

    local -n first_set=${check_valid_first_set};
    local -n second_set=${check_valid_second_set};
    local -n intersect_result=${check_intersect_result};


    for first_set_val in ${!first_set[@]};do
        
        for second_set_val in ${!second_set[@]};do

            [[ "${first_set[$first_set_val]}" == "${second_set[$second_set_val]}" ]] && {
                intersect_result+=( "${first_set[$first_set_val]}" );
                break;
            }
            
        done
        
    done
    return 0;
}


createSet mySet 1 2 3 4 "hi" "hello" "world"

echo ${mySet[@]}

add mySet 4 5 7 2 "hi" 3

echo ${mySet[@]}

remove mySet 4 7

echo ${mySet[@]}

size mySet set_size

echo ${set_size}

createSet anotherSet 5 7 8 9 "hello" "hi"

intersection mySet anotherSet intersectResult

echo ${intersectResult[@]}
