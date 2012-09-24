# generated by stubbs:add-option
# Tue Sep  4 14:58:01 PDT 2012

# print USAGE and exit
rerun_option_error() {
    [ -z "$USAGE"  ] && echo "$USAGE" >&2
    [ -z "$SYNTAX" ] && echo "$SYNTAX $*" >&2
    return 2
}

# check option has its argument
rerun_option_check() {
    [ "$1" -lt 2 ] && rerun_option_error
}

# options: [file interval maxtries progress]
while [ "$#" -gt 0 ]; do
    OPT="$1"
    case "$OPT" in
          -p|--port) rerun_option_check $# ; PORT=$2 ; shift ;;
  -i|--interval) rerun_option_check $# ; INTERVAL=$2 ; shift ;;
  -m|--maxtries) rerun_option_check $# ; MAXTRIES=$2 ; shift ;;
  -P|--progress) rerun_option_check $# ; PROGRESS=$2 ; shift ;;
        # unknown option
        -?)
            rerun_option_error
            ;;
        # end of options, just arguments left
        *)
          break
    esac
    shift
done

# If defaultable options variables are unset, set them to their DEFAULT
[ -z "$INTERVAL" ] && INTERVAL="30"
[ -z "$PROGRESS" ] && PROGRESS="false"
# Check required options are set
[ -z "$PORT" ] && { echo "missing required option: --file" >&2 ; return 2 ; }
[ -z "$MAXTRIES" ] && { echo "missing required option: --maxtries" >&2 ; return 2 ; }
#
return 0