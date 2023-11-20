#!/usr/bin/env bash

enclose::usage (){
    local __doc__
    read -r -d '' __doc__ <<-EOM
Enclose String.

    Usage:
        enclose.sh <ENCLOSING_CHAR> <STRING>

    Options:
        <ENCLOSING_CHAR> Character to use for enclosing:
        <STRING>         String to enclose.


    Some characters have reverse counterparts. If a character
    doesn't have a counterpart, it will be repeated. See chars
    with counterparts bellow:
    Examples:
        - word '"'      -> "word"
        - word '[{<(/\' -> [{<(/\word/\)>}]
EOM

    printf '%s\n' "${__doc__}"
}

enclose::main() {
    # Arguments
    local table_string="${1}"
    local string_to_enclose="${2}"
    local enclosing_char="${3}"

    # Loop variables
    local key
    local value
    local char

    # Body variables
    declare -A counterpart_table
    local counterpart
    local prefix
    local suffix
    local suffix_reverse
    local single_enclosing_char 

    # Parsing counterpart table
    while IFS=' ' read -r key value;do
	counterpart_table["${key}"]="${value}"
    done < <(printf '%s\n' "${table_string}")

    # Creating prefix and suffix
    for ((char=0; char<"${#enclosing_char}"; char++));do
	single_enclosing_char="${enclosing_char:$char:1}"
	counterpart="${counterpart_table[${single_enclosing_char}]}"
	prefix+="${enclosing_char[${char}]}"
	suffix+="${counterpart:-${single_enclosing_char}}"
    done

    # Suffix is created in the same order the prefix
    # so we have to revert it to make it right.
    for ((i=$(( "${#suffix}" - 1 )); i >= 0; i--));do
	suffix_reverse+="${suffix:$i:1}"
    done

    printf '%s' "${prefix}${string_to_enclose}${suffix_reverse}"
}


[[ "${BASH_SOURCE[0]}" == "${0}" ]] && {

    # Checking number of args, should be 2
    [[ ! "${#@}" -eq 2 ]] && {
	enclose::usage
	exit 1
    }
    
read -r -d '' COUNTERPART_TABLE <<-'EOF'
[ ]
{ }
< >
( )
/ \
\ /
EOF

    enclose::main "${COUNTERPART_TABLE}" "${@}" \
	&& exit 0

    enclose::usage
    exit 1
}

