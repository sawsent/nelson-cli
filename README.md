# nelson-cli
Nelson-cli is a Unix Command Line Tool written in Bash that allows for AI suggestions, error explanations, and more, all straight from the terminal. Currently using OpenAI API (because that's what I know), planning to move into an open source, local LLM in the future. 

---

## Dependencies
#### Required:
- [jq](https://github.com/jqlang/jq) <br>
#### Recommended:
- [bat](https://github.com/sharkdp/bat)

---

## Instalation
### Step 0: install dependencies with your favorite package manager
##### Debian-based systems
```sh
sudo apt-get install jq
sudo apt-get install bat
```
##### MacOS
```sh
brew install jq
brew install bat 
```
### Step 1: clone repo wherever you'd like
```sh
git clone https://github.com/sawsent/nelson-cli
```
### Step 2: add your OpenAI key, folder location, and command alias to your shell config file
```sh
# .zshrc / .bashrc / .profile / ...
export OPENAI_API_KEY="your-openai-key"
export NELSON_LOCATION="path/to/nelson-cli"
alias nelson="$NELSON_LOCATION/main.sh"
```
### Step 3: Make the script executable! 
You need to source your shell config file to access $NELSON_LOCATION
```sh
chmod +x $NELSON_LOCATION/main.sh
```

---

## Usage
You can use this tool for as many reasons as you want. It's very easy to extend the functionality with custom system prompts and/or aliases. 

### Core features:
1. Type naturally, no " needed (you cant use them otherwise jq cant do it's job)
2. Choose the model you want to use for the specific request _(ex: --model=gpt-4o)_
3. Choose temperature you want to use _(ex: --temp=0.5)_
4. Choose the max tokens you want to use _(ex: --max-tokens=100)_
5. Choose the mode (System Prompt) to use with _--\<mode>_
6. You can obviously change all defaults (see [settings.sh](settings.sh))
7. Commands run and OpenAI responses are (optionally) stored in an [output.log](./output.log) file

### Core modes 
(i didn't check if nelson was right btw, and Im using bat with some style opts for the output (see [settings.sh](./settings.sh)))

1. **--neat (-n):** Answers in the most concise way possible
<img src="./resources/screenshot3.png">

2. **--long (-l):** Explains in more detail
<img src="./resources/screenshot4.png" width=600>

3. **--code:** Simply codes what's requested. No comments and no explanations
<img src="./resources/screenshot1.png" width=600>

4. **--command (-com):** Provides a Shell command based on the given parameters
<img src="./resources/screenshot2.png">

---

### Customizability
You can easily change defaults, how the code is printed to the terminal in [settings.sh](./settings.sh). 

You can also easily add more modes (System Prompts) in the [system_prompts.sh](./system_prompts.sh). Simply follow the pattern that's already there!

```sh
case $1 in
  default)
    echo "$DEFAULT_SYSTEM_PROMPT"
    ;;
  # ...
  # ...
  your-custom-mode)
    echo "Your Custom System Prompt"
    ;;
  # ...
```

Once you do that, it will immediatly be available to use!
```sh
nelson --your-custom-mode Your question for nelson
```
(Keep in mind, you cant use any names that have already been defined as flags like --debug, --max-temperature, etc...)

---

## Upcoming
- [ ] **Adding Context Support** (ex: `nelson --explain-error` / `nelson --wtf`): Automatically sends the last command run and the output for nelson to explain.
- [ ] **Migrating / adding support for locally-hosted LLMs (like Llama):** I have an API key because I put 10€ on a project once, but not everyone does so it would be better if you could use other APIs and self-hosted LLMs.







