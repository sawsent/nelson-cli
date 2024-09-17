#!/bin/bash

source $NELSEX_LOCATION/settings.sh
source $NELSEX_LOCATION/system_prompts.sh

SYSTEM_PROMPT="$DEFAULT_SYSTEM_PROMPT"

USER_PROMPT=""

for arg in "$@"; do
    case "$arg" in
        -*)
            if [ "$SYSTEM_PROMPT" != "$DEFAULT_SYSTEM_PROMPT" ]; then
                echo "Can't specify multiple modes at once. See available modes in 'nelsex/system_prompts.sh'. Quitting..." 
                exit 1
            fi
            SYSTEM_PROMPT=$(get_system_prompt "$arg")
            if [ "$?" != "0" ]; then
                echo "Invalid Mode, not specified in 'nelsex/system_prompts.sh'. Quitting... "
                exit 1
            fi
            ;;

        *)
            USER_PROMPT="$USER_PROMPT $arg"
            ;;
    esac
done

# Clean log if enabled
if [ "$KEEP_LOG" = "false" ]; then
    if [ -f $OUTPUT_FILE ]; then
        rm $OUTPUT_FILE
    fi
fi

TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
RESPONSE=$(
curl -s https://api.openai.com/v1/chat/completions \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer $OPENAI_API_KEY" \
    -d "{
    \"model\": \"$MODEL_NAME\",
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
    \"max_tokens\": $MAX_TOKENS
}" 2>&1
)

PARSED_RESPONSE=$(echo "$RESPONSE" | jq --raw-output '.choices[0].message.content')

# print response
echo "
$PARSED_RESPONSE
" | $OUTPUT_DISPLAYER 

# logging
echo "[$TIMESTAMP] $USER_PROMPT
---------- OUTPUT ----------
$RESPONSE
---------- OUTPUT END ----------" >> $OUTPUT_FILE


exit 0

