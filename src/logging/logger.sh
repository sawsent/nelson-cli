logger() {
    mode="$1"

    case "$mode" in
        debug)
            debug "$2" "$3"
            ;;
        to-file)
            to_file "$2" "$3"
            ;;
        log-history)
            log_history "$2"
    esac
}

export -f logger

debug() {
    if [ "$SHOW_DEBUG_INFO" != "true" ]; then
        return 1
    fi

    file="$1"
    message="$2"

    echo "[DEBUG] ($file) $message"


}

to_file() {
    to_log="$1"
    output_file="$2"

    echo "$to_log" >> $output_file

    logger debug logger "Successfully logged "$to_log" to $output_file"
}

log_history() {
    if [ "$LOG_MODE" = "never" ]; then
        logger debug logger "Didn't log histry as LOG_MODE is set to 'never'"
        exit 0
    fi
    if [ "$LOG_MODE" = "one" ]; then
        logger debug logger "LOG_MODE is set to 'one', clearing history file '$NELSON_HISTORY'"
        if [ -f $NELSON_HISTORY ]; then
            rm $NELSON_HISTORY
        fi
    fi

    log="$1"
    echo "$log" >> $NELSON_HISTORY

    logger debug logger "Successfully logged to history file '$NELSON_HISTORY'"
}

