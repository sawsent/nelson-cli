logger() {
    mode="$1"

    case "$mode" in
        debug)
            debug "$2" "$3"
            ;;
    esac

}

debug() {
    if [ "$SHOW_DEBUG_INFO" != "true" ]; then
        return 1
    fi

    file="$1"
    message="$2"

    echo "[DEBUG] $file: $message"


}

export -f logger
