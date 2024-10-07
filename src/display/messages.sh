source "$NELSON_LOCATION/src/config/settings.sh"
HELP_MESSAGE_LOCATION="$NELSON_LOCATION/help.txt"

# error
export MSG_INVALID_MODE="Invalid Mode, not specified in '$NELSON_LOCATION/src/config/system_prompts.sh'.. Quitting... "
export MSG_OPENAI_ERROR="Something went wrong when processing your request, I recommend checking $NELSON_HISTORY for details."

# debug
export MSG_DEBUG_ACTIVE="Debug mode is now active."
export MSG_MULTIPLE_MODE_INPUT="Encountered argument $arg after already setting mode $MODE, parsing it as part of user prompt. (You can remove these alerts in settings)"
export MSG_CHANGED_MODE_TO="Using Mode: "


# help
export MSG_HELP_GENERAL="Sorry, help message isn't implemented yet. Feel free to help @ https://www.github.com/sawsent/nelson-cli !"

SHOW_HELP() {
    case "$1" in 
        general)
            cat $HELP_MESSAGE_LOCATION
            ;;
    esac
}

export -f SHOW_HELP
