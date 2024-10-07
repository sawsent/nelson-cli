source "$NELSON_LOCATION/src/config/settings.sh"

# error
export MSG_INVALID_MODE="$MODE: Invalid Mode, not specified in '$NELSON_LOCATION/src/config/system_prompts.sh'.. Quitting... "
export MSG_OPENAI_ERROR="Something went wrong when processing your request, I recommend checking $OUTPUT_FILE for details."

# debug
export MSG_DEBUG_ACTIVAT="Debug mode is now active."
export MSG_MULTIPLE_MODE_INPUT="Encountered argument $arg after already setting mode $MODE, parsing it as part of user prompt. (You can remove these alerts in settings)"
export MSG_USING_MODEL="Using GPT model: '$MODEL'"
export MSG_CHANGED_MODE_TO="Using mode: '$MODE'"
export MSG_USING_MAX_TOKENS="Set Max Tokens to '$MAX_TOKENS'"
export MSG_USING_TEMPERATURE="Using temperature $TEMP"
export MSG_LOGGED_TO_FILE="Logged output to '$OUTPUT_FILE'"


# help
export MSG_HELP_GENERAL="Sorry, help message isn't implemented yet. Feel free to help @ https://www.github.com/sawsent/nelson-cli !"
