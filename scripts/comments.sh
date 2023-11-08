#!/usr/bin/env bash

comments::usage (){
    local __doc__
    read -r -d '' __doc__ <<-'EOM'
        Comment or Uncomment lines from stdin

        Usage:
            comments.sh <COMMENT_STRING> < lines_to_comment.txt 

        Options:
            <COMMENT_STRING>          Use this string as comment.
EOM

    printf '%s\n' "${__doc__}"
}

comments::main() {
    local comment_string="${1}"
    local line
    local line_prefix
    local added_comment
    local line_suffix

    while IFS= read -r line; do
        
        [[ "${line}" =~ ^([' '$'\t']+)?("${comment_string}"' '+?)?(.*) ]]

        line_prefix="${BASH_REMATCH[1]}"
        line_suffix="${BASH_REMATCH[3]}"

        [[ "${#BASH_REMATCH[2]}" -eq 0 ]] \
            && added_comment="${comment_string} " \
            || added_comment=''

        printf '%s%s%s\n' \
            "${line_prefix}" \
            "${added_comment}" \
            "${line_suffix}"
        
    done 
}

[[ ! "${#1}" -eq 0  ]] \
    && comments::main "${1}" \
    && exit 0

comments::usage
exit 1
