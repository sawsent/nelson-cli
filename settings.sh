# Config File for nelson-cli 

# Model Settings
export OPENAI_API_KEY="$OPENAI_API_KEY"
export DEFAULT_MODEL="gpt-3.5-turbo"
export DEFAULT_MAX_TOKENS=500
export DEFAULT_TEMPERATURE=0.7
export DEFAULT_SYSTEM_PROMPT="You are a programming expert, especially when it comes to CLI tools. You know how the Unix System Command Line works, to a TEE."

# Output
export OUTPUT_DISPLAYER="bat --style grid --paging=never --language md"
# I highly recommend using 'bat', but if you want you can just use cat:
# export OUTPUT_DISPLAYER="cat"

export SHOW_DEBUG_INFO=false
export HISTFILE="/Users/vicente.figueiredo/.zhistory"

# Logging
export OUTPUT_FILE="$NELSON_LOCATION/output.log"
export LOG_MODE="never" # "never" / "one" / "always"

# flags
export USE_DEFAULT_ON_SYSTEM_PROMPT_FLAG_ERROR=false
