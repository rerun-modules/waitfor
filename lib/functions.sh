# Shell functions for the waitfor module.
#/ usage: source RERUN_MODULE_DIR/lib/functions.sh command
#

# Read rerun's public functions
. $RERUN || {
    echo >&2 "ERROR: Failed sourcing rerun function library: \"$RERUN\""
    return 1
}

# Check usage. Argument should be command name.
[[ $# = 1 ]] || rerun_option_usage

# Source the option parser script.
#
if [[ -r $RERUN_MODULE_DIR/commands/$1/options.sh ]] 
then
    . $RERUN_MODULE_DIR/commands/$1/options.sh || {
        rerun_die "Failed loading options parser."
    }
fi

# - - -
# Your functions declared here.
# - - -



progress_tic() {
    tic=$1
    printf "$tic"
}

function show_progress {
    percDone=$(echo 'scale=2;'$1/$2*100 | bc)
    barLen=$(echo ${percDone%'.00'})
    bar=''
    fills=''
    for (( b=0; b<$barLen; b++ ))
    do
        bar=$bar"#"
    done
    blankSpaces=$(echo $((100-$barLen)))
    for (( f=0; f<$blankSpaces; f++ ))
    do
        fills=$fills"."
    done
    clear
    echo  "${barLen}%[${bar}#${fills}]"
}
