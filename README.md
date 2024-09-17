# nelson-cli
Nelson-cli is a Unix Command Line Tool written in Bash that allows for AI suggestions, error explanations, and more, all straight from the terminal. Currently using OpenAI API (because that's what I know), planning to move into an open source, local LLM in the future. 

---

### Dependencies
#### Required:
- [jq](https://github.com/jqlang/jq) <br>
#### Recommended:
- [bat](https://github.com/sharkdp/bat)

---

### Instalation
#### Step 1: clone repo wherever you'd like
```bash
git clone https://github.com/sawsent/nelson-cli
```
#### Step 2: add your OpenAI key, folder location, and command alias to your shell config file
```bash
# .zshrc / .bashrc / .profile / ...
export OPENAI_API_KEY="your-openai-key"
export NELSON_LOCATION="path/to/nelson-cli"
alias nelson="$NELSON_LOCATION/main.sh"
```
#### Step 3: Make the script executable! (you might need to source your shell config file)
```bash
chmod +x $NELSON_LOCATION/main.sh
```
