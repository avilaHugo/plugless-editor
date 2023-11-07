#!/usr/bin/env bash

comments::usage (){
    local __doc__
    read -r -d '' __doc__ <<-'EOM'
        Comment or Uncomment lines from stdin

        Usage:
            comments.sh ( -c | -u ) [ -s <string> ] < lines_to_comment.txt 
            comments.sh ( --comment | --uncomment ) [ --comment-string <string> ] < lines_to_comment.txt

        Options:
            -c,--comment         Comment lines.
            -u,--uncomment       Uncomment lines.
            -s,--comment-string  Use this char as comments [default: '#'].
EOM

    printf '%s\n' "${__doc__}"
}

comments::main() {
    local line
    local ADDED_COMMENT="${COMMENT_STRING}"

    if ! ${COMMENT}; then
        ADDED_COMMENT=""
    fi

    while IFS= read -r line; do

        [[ "${line}" =~ ^([' '$'\t']+)?("${COMMENT_STRING}")?(.*) ]]

        LINE_PREFIX="${BASH_REMATCH[1]}"
        # LINE_COMMENT_STRINT="${BASH_REMATCH[2]}" # <- I dont need this one, is here just for reference.
        LINE_SUFFIX="${BASH_REMATCH[3]}"

        printf '%s%s%s\n' \
            "${LINE_PREFIX}" \
            "${ADDED_COMMENT}" \
            "${LINE_SUFFIX}"
        
    done 

}

COMMENT_STRING='#'

[ "${#}" -eq 0 ] && {
    comments::usage
    exit 1
}

while [[ "${#}" -gt 0 ]];do

    case "${1}" in

        -c|--comment)
            COMMENT=true
            ;;

        -u|--uncomment)
            COMMENT=false
            ;;

        -s*|--comment_string=*)
            shift
            COMMENT_STRING="${1}"
            ;;

        *)
            echo "Unknown Command: ${1}" >&2
            comments::usage 
            exit 1
            ;;
    esac
    shift

done

comments::main
exit 0
