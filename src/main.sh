#!/bin/bash
source $NELSON_LOCATION/src/config/settings.sh
source $NELSON_LOCATION/src/config/system_prompts.sh
source $NELSON_LOCATION/src/display/messages.sh
source $NELSON_LOCATION/src/logging/output_log_template.sh
source $NELSON_LOCATION/src/logging/logger.sh


SYSTEM_PROMPT="$DEFAULT_SYSTEM_PROMPT"
MODE="default"
MODEL="$DEFAULT_MODEL"
MAX_TOKENS="$DEFAULT_MAX_TOKENS"
TEMPERATURE="$DEFAULT_TEMPERATURE"

USER_PROMPT=""
DEBUG_FULL_COMMAND=""


for arg in "$@"; do
    DEBUG_FULL_COMMAND="$DEBUG_FULL_COMMAND$arg "
    case "$arg" in
        --help)
            echo "$MESSAGE_HELP_GENERAL"
            exit 0
            ;;
        -h)
            echo "$MESSAGE_HELP_GENERAL"
            exit 0
            ;;

        --wtf)
            LAST_COMMAND=$(tail -n 2 "$HISTFILE" | head -n 1 | sed 's/.*;//' )

            if [ "$ASK_WTF_CONFIRMATION" = "true" ]; then
                read -p "Warning: this will run the last command: '$LAST_COMMAND' again. Do you wish to continue? (this alert can be disabled in settings) (y/n) >> " response

                if [ "$response" != "y" ] && [ "$response" != "Y" ]; then
                    echo "Aborting..."
                    exit 2
                else 
                    echo "Running '$LAST_COMMAND' and evaluating the result."
                fi
            else
                logger debug main "Running '$LAST_COMMAND' and evaluating the result."
            fi

            MODE="wtf"
            ;;

        --debug)
            SHOW_DEBUG_INFO=true
            logger debug main "$MSG_DEBUG_ACTIVE"
            ;;

        --model=*)
            MODEL="${arg#--model=}"
            logger debug main "Changed Model to '$MODEL'" 
            ;;

        --max-tokens=*)
            MAX_TOKENS="${arg#--max-tokens=}"
            logger debug main "Set max tokens to: $MAX_TOKENS"
            ;;

        --temp=*)
            TEMPERATURE="${arg#--temp=}" 
            logger debug main "Using temperature: $TEMPERATURE"
            ;;


        # mode
        --mode=*)
        MODE="${arg#--mode=}"
        logger debug main "$MSG_CHANGED_MODE_TO $MODE"
        ;;  

    --system-prompt=*)
        SYSTEM_PROMPT=${arg#--system-prompt=}
        MODE="custom"
        ;;

        # simple mode choice
        -*)
        if [ "$MODE" = "default" ]; then

            MODE="${arg#--}"
            MODE="${MODE#-}"
            logger debug main "$MSG_CHANGED_MODE_TO '$MODE'"

        else

            USER_PROMPT="$USER_PROMPT $arg"
            logger debug main "Encountered argument $arg after already setting mode $MODE, parsing it as part of user prompt."
        fi
        ;;

        # Anything else that isn't a command -> added to the USER_PROMPT string
        *)
        USER_PROMPT="$USER_PROMPT$arg "
        ;;
    esac
done

if [ "$MODE" != "custom" ]; then

    SYSTEM_PROMPT=$(get_system_prompt "$MODE")

    if [ "$?" != "0" ]; then
        echo "$MODE: $MSG_INVALID_MODE"
        exit 1
    fi
fi


if [ "$MODE" = "wtf" ]; then 

    OUTPUT=$(eval $LAST_COMMAND 2>&1)
    USER_PROMPT="COMMAND: $LAST_COMMAND; OUTPUT: $(echo $OUTPUT | tr '\n', ' ' | tr '"' "'")"

    if [ "$SHOW_COMMAND_BEFORE_WTF_RESPONSE" = "true" ]; then
        echo -e "COMMAND: $LAST_COMMAND \nOUTPUT: \n$OUTPUT"
    fi
fi

TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
RESPONSE=$(
curl -s https://api.openai.com/v1/chat/completions \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer $OPENAI_API_KEY" \
    -d "{
    \"model\": \"$MODEL\",
    \"messages\": 
    [
    {\
        \"role\": \"system\", \
        \"content\": \
        \"$SYSTEM_PROMPT\"
    },
    {\
        \"role\": \"user\", \
        \"content\": \
        \"$USER_PROMPT\"
    }
    ],
    \"max_tokens\": $MAX_TOKENS,
    \"temperature\": $TEMPERATURE 
}" 2>&1
)

PARSED_RESPONSE=$(echo "$RESPONSE" | jq --raw-output '.choices[0].message.content')
if [ "$PARSED_RESPONSE" = "null" ]; then
    PARSED_RESPONSE="$MSG_OPENAI_ERROR"
fi

# Logging to file

# DONT CHANGE THIS, SEE 'log_template.sh' TO MAKE CHANGES TO THE LOG TEMPLATE
log=$(get_log "$TIMESTAMP" "$DEBUG_FULL_COMMAND" "$SYSTEM_PROMPT" "$USER_PROMPT" "$MODEL" "$MODE" "$MAX_TOKENS" "$TEMPERATURE" "$RESPONSE" "$PARSED_RESPONSE")  
logger log-history "$log"

# print response through output displayer of choice
echo "
$PARSED_RESPONSE
" | $OUTPUT_DISPLAYER 

# Logging
exit 0
