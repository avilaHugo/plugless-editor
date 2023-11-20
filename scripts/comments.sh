#!/usr/bin/env bash

comments::usage (){
    local __doc__
    read -r -d '' __doc__ <<-'EOM'
    Comment or uncomment lines from stdin.
    If the count of commented lines is greater than the uncommented ones,
    the script will comment them; otherwise, it will uncomment them.

        Usage:
            comments.sh <COMMENT_STRING> < lines_to_comment.txt 

        Options:
            <COMMENT_STRING>          Use this string as comment.
EOM

    printf '%s\n' "${__doc__}"
}

comments::main() {
    # Argument variables
    local comment_string="${1}"
    
    # Loop variables 
    local line
    local i

    # Body variables 
    local added_comment="${comment_string} "
    local is_already_commented=0
    declare -a line_prefixes
    declare -a line_prexisting_comments
    declare -a line_suffixes

    # Break lines intro <PREFIX> <COMMENT(if any)> <SUFFIX>
    while IFS= read -r line; do
        
        [[ "${line}" =~ ^([' '$'\t']+)?("${comment_string}"' '+?)?(.*) ]]

        [[ ! "${#BASH_REMATCH[2]}" -eq 0 ]] && ((is_already_commented++))
	
	line_prefixes+=( "${BASH_REMATCH[1]}" )
	line_prexisting_comments+=( "${BASH_REMATCH[2]}" )
	line_suffixes+=( "${BASH_REMATCH[3]}" )
        
    done

    # Count lines that are already commented
    # to decide if comment or uncomment.
    if [[ "${is_already_commented}" -eq "${#line_prefixes[@]}" ]];then
	added_comment=''
	line_prexisting_comments=()
    fi

    for (( i=0; i < "${#line_prefixes[@]}"; i++ ));do
	printf '%s%s%s\n' \
	       "${line_prefixes[$i]}" \
	       "${added_comment}${line_prexisting_comments[$i]}" \
	       "${line_suffixes[$i]}" 
    done
}

[[ ! "${#1}" -eq 0  ]] \
    && comments::main "${1}" \
    && exit 0

comments::usage
exit 1
