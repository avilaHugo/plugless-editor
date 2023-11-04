#!/usr/bin/env bash

set -euo pipefail

comments::usage (){
    local __doc__
    cat <<-'EOF'
	Comment or Uncomment lines from stdin

	Usage:
		comments.sh ( -c | -u ) [ -s <string> ] < lines_to_comment.txt 
		comments.sh ( --comment | --uncomment ) [ --comment-string <string> ] < lines_to_comment.txt

	Options:
        -c,--comment         Comment lines.
        -u,--uncomment       Uncomment lines.
        -s,--comment-string  Use this char as comments [default: '# ']. 
EOF

}

comments::main (){

    while IFS= read -r line; do
        already_commented=false

        for ((i=0; i < "${#line}"; i++));do

            case "${line:${i}:1}" in

                 $'\t' | " " ) # Encrease "$i" if char is tab or space.
                    ;;

                \#)            # Already commented.
                    already_commented=true
                    break
                    ;;

                *)             # Stop if you find any other.
                    break
                    ;;

            esac

        done

        if $COMMENT; then
            prefix=""
            ! ${already_commented} && prefix="${line:0:${i}}${COMMENT_STRING}"
            suffix="${line:${i}:${#line}}"
        fi

        if ! $COMMENT; then
            prefix=""            
        fi
  
    done

}


COMMENT_STRING='# '

[ "${#}" -eq 0 ] && comments::usage

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
            ;;
    esac
    shift

done

comments::main

