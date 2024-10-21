# Config File for nelson-cli 

# Model Settings
export OPENAI_API_KEY="$OPENAI_API_KEY"
export DEFAULT_MODEL="gpt-4o"
export DEFAULT_MAX_TOKENS=500
export DEFAULT_TEMPERATURE=0.7
export DEFAULT_SYSTEM_PROMPT="You are a programming expert, especially when it comes to CLI tools. You know how the Unix System Command Line works, to a TEE."
export DEFAULT_MODE="command"

# Command mode
export ALWAYS_COPY_COMMAND=false

# Output
export OUTPUT_DISPLAYER="bat --style grid --paging=never --language md"
# I highly recommend using 'bat', but if you want you can just use cat:
# export OUTPUT_DISPLAYER="cat"

export SHOW_DEBUG_INFO=false

# ----- --wtf -----

# because we're using bash to run the script, it might be different than your main zsh or fish $HISTFILE (I think)
# run 'echo $HISTFILE' in your main shell to get the location. 
export HISTFILE="/Users/vicente.figueiredo/.zhistory"
export ASK_WTF_CONFIRMATION=true
export SHOW_COMMAND_BEFORE_WTF_RESPONSE=false

# Logging
export OUTPUT_FILE="$NELSON_LOCATION/output.log"
export NELSON_HISTORY="$NELSON_LOCATION/history.log"
export LOG_MODE="one" # "never" / "one" / "always"

# flags
export USE_DEFAULT_ON_SYSTEM_PROMPT_FLAG_ERROR=false
