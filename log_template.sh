get_log() {
# ! Don't change these unless you know what you're doing
TIMESTAMP="$1" 
FULL_COMMAND="$2"
SYSTEM_PROMPT="$3"
USER_PROMPT="$4"
USED_MODEL="$5"
USED_MODE="$6"
USED_MAX_TOKENS="$7"
USED_TEMPERATURE="$8"
OPENAI_RESPONSE="$9"
OPENAI_RESPONSE_PARSED="$10"

# log template starts here
echo "
----------------------------------------

[$TIMESTAMP] $FULL_COMMAND

System Prompt: 
$SYSTEM_PROMPT

User Prompt: 
$USER_PROMPT

Settings used:
model        =>  $USED_MODEL
mode         =>  $USED_MODE
max-tokens   =>  $USED_MAX_TOKENS
temperature  =>  $USED_TEMPERATURE

OpenAI Response: 
$OPENAI_RESPONSE

----------------------------------------
"
return 0
}

export -f get_log
