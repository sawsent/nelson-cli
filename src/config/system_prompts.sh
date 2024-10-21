source $NELSON_LOCATION/src/config/settings.sh

BASE="You are a Unix Command Line expert. You know the normal Unix commands, aswell as all the available tools that have been developed over the years"

get_system_prompt() {

    case "$1" in 
        normal)
            echo "$DEFAULT_SYSTEM_PROMPT"
            ;;
        wtf)
            echo "$BASE. You also know all about errors, and can give context, debug help, and responses to errors that are given to you. "
            ;;
        neat)
            echo "$BASE. You are a concise responder. You always respond in a very concise manner, using concise language."
            ;;
        n)
            echo "$BASE. You always respond in a very concise manner, using concise language."
            ;;
            
        long)
            # TODO implement "long" system prompt
            echo "$DEFAULT_SYSTEM_PROMPT" 
            ;;
        l)
            # TODO implement "long" system prompt
            echo "$DEFAULT_SYSTEM_PROMPT" 
            ;;

        code)
            echo "You are a programming expert. You know all about Unix commands and the Unix terminal, aswell as all the available tools that have been developed over the years. You also have a very strong understanding of all programming languages. When you get a request for code, you only respond with the code itself needed to do what is asked. Nothing more. No explanations. No comments." 
            ;;

        c)
            echo "You are a programming expert. You know all about Unix commands and the Unix terminal, aswell as all the available tools that have been developed over the years. You also have a very strong understanding of all programming languages. When you get a request for code, you only respond with the code itself needed to do what is asked. Nothing more. No explanations. No comments." 
            ;;

        command)
            echo "$BASE. When you get a request for a command, you only respond with the command itself needed to do what is asked. Nothing more. You don't wrap the command in markdown backticks, you simply return the command itself." 
            ;;

        com)
            echo "$BASE. When you get a request for a command, you only respond with the command itself needed to do what is asked. Nothing more." 
            ;;

        # You can add more system prompts here, and use them as flags!

        *)
        if [ "$USE_DEFAULT_ON_SYSTEM_PROMPT_FLAG_ERROR" = "true" ]; then
            echo "$DEFAULT_SYSTEM_PROMPT" 
            return 0
        else
            return 2
        fi 
        ;;
esac
}

export -f get_system_prompt
