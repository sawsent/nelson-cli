# Config File for Nelsex

# Model Settings
export OPENAI_API_KEY="$OPENAI_API_KEY"
export MODEL_NAME="gpt-3.5-turbo"
export MAX_TOKENS=500
export DEFAULT_SYSTEM_PROMPT="You are a programming expert, especially when it comes to CLI tools. You know how the Unix System Command Line works, to a TEE."

# Output
export OUTPUT_DISPLAYER="bat --style grid --language md"
# I highly recommend using 'bat', but if you want you can just use cat:
# export OUTPUT_DISPLAYER="cat"

# Logging
export OUTPUT_FILE="$HOME/nelsex/output.log"
export KEEP_LOG=false

# flags
export USE_DEFAULT_ON_SYSTEM_PROMPT_FLAG_ERROR=false
