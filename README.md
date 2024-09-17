# nelson
Nelsex is a Unix Command Line Tool written in Bash that allows for AI suggestions in the terminal via the OpenAI API. 

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
git clone https://wwww.github.com/sawsent/nelsex
```
#### Step 2: add your OpenAI key, folder location, and command alias to your shell config file
```bash
export OPENAI_API_KEY="your-openai-key"
export NELSON_LOCATION="path/to/nelson/folder"
alias nelson="$NELSON_LOCATION/main.sh"
```
#### Step 3: make the script executable!
```bash
chmod +x $NELSON_LOCATION/main.sh
```
