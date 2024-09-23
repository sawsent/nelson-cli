#!/bin/bash

source $NELSON_LOCATION/settings.sh
source $NELSON_LOCATION/system_prompts.sh
source $NELSON_LOCATION/messages.sh
source $NELSON_LOCATION/log_template.sh

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

        --debug)
            SHOW_DEBUG_MESSAGES=true
            ;;

        --model=*)
            MODEL="${arg#--model=}"
            if [ "$SHOW_DEBUG_MESSAGES" = "true" ]; then
                echo "$MESSAGE_USING_MODEL $MODEL"
            fi
            ;;

        --max-tokens=*)
            MAX_TOKENS="${arg#--max-tokens=}"
            if [ "$SHOW_DEBUG_MESSAGES" = "true" ]; then
                echo "$MESSAGE_USING_MAX_TOKENS $MAX_TOKENS"
            fi
            ;;

        --temp=*)
            TEMPERATURE="${arg#--temp=}" 
            if [ "$SHOW_DEBUG_MESSAGES" = "true" ]; then
                echo "$MESSAGE_USING_TEMPERATURE $TEMPERATURE"
            fi
            ;;


        # mode
        --mode=*)
            MODE="${arg#--mode=}"
            if [ "$SHOW_DEBUG_MESSAGES" = "true" ]; then 
                echo "$MESSAGE_CHANGED_MODE_TO $MODE"
            fi
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
                if [ "$SHOW_DEBUG_MESSAGES" = "true" ]; then
                    echo "$MESSAGE_CHANGED_MODE_TO $MODE"
                fi

            else

                USER_PROMPT="$USER_PROMPT $arg"
                if [ "$SHOW_DEBUG_MESSAGES" = "true" ]; then
                    echo "$MESSAGE_MULTIPLE_MODE_INPUT"
                fi
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
        echo "$MODE: $MESSAGE_INVALID_MODE"
        exit 1
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
    PARSED_RESPONSE="$MESSAGE_OPENAI_ERROR"
fi

# print response through output displayer of choice
echo "
$PARSED_RESPONSE
" | $OUTPUT_DISPLAYER 

# Logging
if [ "$LOG_MODE" = "never" ]; then
   exit 0 
fi

if [ "$LOG_MODE" = "one" ]; then
    if [ -f $OUTPUT_FILE ]; then
        rm $OUTPUT_FILE
    fi
fi

# DONT CHANGE THIS, SEE 'log_template.sh' TO MAKE CHANGES TO THE LOG TEMPLATE
get_log "$TIMESTAMP" "$DEBUG_FULL_COMMAND" "$SYSTEM_PROMPT" "$USER_PROMPT" "$MODEL" "$MODE" "$MAX_TOKENS" "$TEMPERATURE" "$RESPONSE" "$PARSED_RESPONSE" >> $OUTPUT_FILE

exit 0
