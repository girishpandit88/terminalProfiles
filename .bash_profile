export CLICOLOR=1
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

##
# Your previous /Users/gpandit/.bash_profile file was backed up as /Users/gpandit/.bash_profile.macports-saved_2013-11-14_at_16:19:48
##

# MacPorts Installer addition on 2013-11-14_at_16:19:48: adding an appropriate PATH variable for use with MacPorts.
export ANDROID_HOME=/Users/gpandit/Developer/Android/sdk
export PATH=/opt/local/bin:/opt/local/sbin:$ANDROID_HOME/tools:$ANDROID_HOME/build_tools:$ANDROID_HOME/platform-tools:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

# bash completion
[ -f `brew --prefix`/etc/bash_completion ] && source `brew --prefix`/etc/bash_completion

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Don't put duplicate lines in the history
export HISTCONTROL=ignoredups:ignorespace

# Append to the history file, don't overwrite it
shopt -s histappend

# Set history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=1000
export HISTFILESIZE=2000

# prompt with git
export PS1="\[\033[36m\]\[\033[m\]\h@\[\033[32m\]\u:\[\033[33;1m\]\W\[\033[m\]\$ "

# Setting PATH for Python 2.7
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
export PATH

# Setting PATH for Python 3.3
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.3/bin:${PATH}"
export PATH

#   -----------------------------
#   2.  MAKE TERMINAL BETTER
#   -----------------------------

function myst()
{
	open -a Sublime\ Text\ 2 $1
}
alias SublimeText=myst
alias f='open -a Finder ./' #Open Finder in HOME
alias myip='curl ip.appspot.com' # myip: Public facing IP Address
alias lsock='sudo /usr/sbin/lsof -i -P'             # lsock: Display open sockets
alias lsockU='sudo /usr/sbin/lsof -nP | grep UDP'   # lsockU: Display only open UDP sockets
alias lsockT='sudo /usr/sbin/lsof -nP | grep TCP'   # lsockT: Display only open TCP sockets
alias qfind="find . -name " # qfind: Quickly search for file

#   extract:  Extract most know archives with one command
#   ---------------------------------------------------------
    extract () {
        if [ -f $1 ] ; then
          case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)     echo "'$1' cannot be extracted via extract()" ;;
             esac
         else
             echo "'$1' is not a valid file"
         fi
    }


