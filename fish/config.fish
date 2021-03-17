# Display system info
sh ~/Scripts/ufetch.sh

# Starship

starship init fish | source

# Nvm

nvm use node > /dev/null 2>&1

# Anaconda

source /home/fabricio/anaconda3/etc/fish/conf.d/conda.fish

# Autojump

source /usr/share/autojump/autojump.fish

# Environment

set -gx EDITOR nvim

# Abbreviations

## Apt
abbr -a -g apti sudo apt install
abbr -a -g aptu sudo apt update
abbr -a -g aptl apt list

## Cargo
abbr -a -g cbd cargo build
abbr -a -g cck cargo check
abbr -a -g cte cargo test

## Exa
abbr -a -g ls exa
abbr -a -g lsl exa -l
abbr -a -g lsla exa -la

## Git
abbr -a -g gst git status
abbr -a -g gck git checkout
abbr -a -g gcm git commit
abbr -a -g gad git add
abbr -a -g nrc npm run commit

# Tiny Care Terminal
set -gx TTC_APIKEYS false
set -gx TTC_REPOS (echo /home/fabricio/Projects/{atto-chat/{backend, frontend}, desafio-1help, everett} | sed "s/\s/,/g")
set -gx TTC_SAY_BOX parrot
set -gx TTC_WEATHER "Sao Paulo"
