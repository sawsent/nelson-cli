source $NELSON_LOCATION/settings.sh

get_system_prompt() {

    case "$1" in 
        --neat)
            echo "You are a Unix Command Line expert. You know the normal Unix commands, aswell as all the available tools that have been developed over the years. You are a concise responder. You always respond in a very concise manner, using concise language."
            ;;
        -n)
            echo "You are a Unix Command Line expert. You know the normal Unix commands, aswell as all the available tools that have been developed over the years. You are a concise responder. You always respond in a very concise manner, using concise language."
            ;;
            
        --long)
            # TODO implement "long" system prompt
            echo "$DEFAULT_SYSTEM_PROMPT" 
            ;;
        -l)
            # TODO implement "long" system prompt
            echo "$DEFAULT_SYSTEM_PROMPT" 
            ;;

        --code)
            echo "You are a Unix Command Line expert. You know the normal Unix commands, aswell as all the available tools that have been developed over the years. When you get a request for a command, you only respond with the command itself needed to do what is asked. Nothing more." 
            ;;
        -c)
            echo "You are a Unix Command Line expert. You know the normal Unix commands, aswell as all the available tools that have been developed over the years. When you get a request for a command, you only respond with the command itself needed to do what is asked. Nothing more." 
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
