export CLICOLOR=1
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

##
# Your previous /Users/gpandit/.bash_profile file was backed up as /Users/gpandit/.bash_profile.macports-saved_2013-11-14_at_16:19:48
##
# MacPorts Installer addition on 2013-11-14_at_16:19:48: adding an appropriate PATH variable for use with MacPorts.
export ANDROID_HOME=${HOME}/android-sdk-macosx
export PATH=/opt/local/libexec/:/opt/local/bin:/opt/local/sbin:$ANDROID_HOME/tools:$ANDROID_HOME/build_tools:$ANDROID_HOME/platform-tools:$PATH
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
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo "(${BRANCH}${STAT})"
	else
		echo ""
	fi
}

# get current status of git repo
function parse_git_dirty {
	status=`git status 2>&1 | tee`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
	newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	bits=''
	if [ "${renamed}" == "0" ]; then
		bits=">${bits}"
	fi
	if [ "${ahead}" == "0" ]; then
		bits="*${bits}"
	fi
	if [ "${newfile}" == "0" ]; then
		bits="+${bits}"
	fi
	if [ "${untracked}" == "0" ]; then
		bits="?${bits}"
	fi
	if [ "${deleted}" == "0" ]; then
		bits="x${bits}"
	fi
	if [ "${dirty}" == "0" ]; then
		bits="!${bits}"
	fi
	if [ ! "${bits}" == "" ]; then
		echo " ${bits}"
	else
		echo ""
	fi
}
# prompt with git
if [[ $UUID == 0 ]]; then
  export PS1="\[\033[32m\]\u:\[\033[33;1m\]\W\[\033[m\]\# "
else
  export PS1="\u:\[\e[33m\]\h\[\e[m\] @\[\e[32m\]\W\[\e[m\]\[\e[31m\]\`parse_git_branch\`\[\e[m\] \\$ "
fi
# set_prompt () {
#     Last_Command=$? # Must come first!
#     Blue='\[\e[01;34m\]'
#     White='\[\e[01;37m\]'
#     Red='\[\e[01;31m\]'
#     Green='\[\e[01;32m\]'
#     Reset='\[\e[00m\]'
#     FancyX='\342\234\227'
#     Checkmark='\342\234\223'
#     Yellow='\e[0;33m'

#     # Add a bright white exit status for the last command
#     PS1="$White\$? "
#     # If it was successful, print a green check mark. Otherwise, print
#     # a red X.
#     if [[ $Last_Command == 0 ]]; then
#         PS1+="$Green$Checkmark "
#     else
#         PS1+="$Red$FancyX "
#     fi
#     # If root, just print the host in red. Otherwise, print the current user
#     # and host in green.
#     if [[ $EUID == 0 ]]; then
#         PS1+="$Red\\h "
#     else
#         PS1+="$Green\\u@$Yellow\\h: "
#     fi
#     # Print the working directory and prompt marker in blue, and reset
#     # the text color to the default.
#     PS1+="$Blue\\W $White\`parse_git_branch\`$Red\\\$$Reset "
# }
# PROMPT_COMMAND='set_prompt'
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
	open -a Sublime\ Text $1
}
alias SublimeText=myst
alias f='open -a Finder ./' #Open Finder in HOME
alias myip='curl ip.appspot.com' # myip: Public facing IP Address
alias lsock='sudo /usr/sbin/lsof -i -P'             # lsock: Display open sockets
alias lsockU='sudo /usr/sbin/lsof -nP | grep UDP'   # lsockU: Display only open UDP sockets
alias lsockT='sudo /usr/sbin/lsof -nP | grep TCP'   # lsockT: Display only open TCP sockets
alias qfind="find . -name " # qfind: Quickly search for file
alias ll="ls -alth " #extended version of ls

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
#   cleanupDS:  Recursively delete .DS_Store files
#   -------------------------------------------------------------------
alias cleanupDS="find . -type f -name '*.DS_Store' -ls -delete"

#   finderShowHidden:   Show hidden files in Finder
#   finderHideHidden:   Hide hidden files in Finder
#   -------------------------------------------------------------------
alias finderShowHidden='defaults write com.apple.finder ShowAllFiles TRUE'
alias finderHideHidden='defaults write com.apple.finder ShowAllFiles FALSE'

#    sudo kextunload /System/Library/Extensions/AppleHDA.kext
alias soundOff='sudo kextunload /System/Library/Extensions/AppleHDA.kext'
alias soundOn='sudo kextload /System/Library/Extensions/AppleHDA.kext'

# opens skype from terminal
alias skype='open -a Skype'

#   memHogsTop, memHogsPs:  Find memory hogs
#   -----------------------------------------------------
alias memTopHogs='top -l 1 -o rsize | head -20'
alias memPsHogs='ps -ef -o pid,stat,vsize,rss,time,command | head -10'

# Add play to path

export PLAY_HOME=/Users/girishpandit/Developer/play-2.2.3
export PATH=$PATH:$PLAY_HOME


# Initialization for FDK command line tools.Thu Mar 20 18:35:50 2014
#FDK_EXE="/Users/girishpandit/bin/FDK/Tools/osx"
#PATH=${PATH}:"/Users/girishpandit/bin/FDK/Tools/osx"
#export PATH
#export FDK_EXE
# export PATH=/usr/local/bin:$PATH
export GIT_EXEC_PATH=/opt/local/libexec/git-core
export PATH=$GIT_EXEC_PATH:$PATH
##
# Your previous /Users/girishpandit/.bash_profile file was backed up as /Users/girishpandit/.bash_profile.macports-saved_2014-05-03_at_17:03:34
##

# MacPorts Installer addition on 2014-05-03_at_17:03:34: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

#Echo JAVA_HOME to update jdk path
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_66.jdk/Contents/Home
export PATH=$JAVA_HOME/bin:$PATH

# eval "$(chef shell-init bash)"
export GREP_OPTIONS='--color=always'
export GREP_COLOR='1;35;40'
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
  [ -r "$file" ] && source "$file"
done
unset file

function weather(){
	curl -s "http://api.openweathermap.org/data/2.5/find?q=$1&units=imperial"|jq '.list[]|{city: [.name,.sys.country], temp: .main.temp, humidity: .main.humidity, weather: .weather[0].description}'
}

alias weather=weather

export GOPATH=/usr/local/Cellar/go/1.4
export PATH=$PATH:$GOPATH/bin