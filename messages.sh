source "$NELSON_LOCATION/settings.sh"

# error
export MESSAGE_INVALID_MODE="Invalid Mode, not specified in '$NELSON_LOCATION/system_prompts.sh'.. Quitting... "
export MESSAGE_OPENAI_ERROR="Something went wrong when processing your request, I recommend checking $OUTPUT_FILE for details."

# debug
export MESSAGE_MULTIPLE_MODE_INPUT="Encountered argument $arg after already setting mode $MODE, parsing it as part of user prompt. (You can remove these alerts in settings)"
export MESSAGE_USING_MODEL="Using GPT model: "
export MESSAGE_CHANGED_MODE_TO="Using mode: "

# help
export MESSAGE_HELP_GENERAL="Sorry, help message isn't implemented yet. Feel free to help @ https://www.github.com/sawsent/nelson-cli !"
