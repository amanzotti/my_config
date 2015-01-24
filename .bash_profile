#  ---------------------------------------------------------------------------
#
#  Description:  This file holds all my BASH configurations and aliases
#
#  Sections:
#  1.   Environment Configuration
#  2.   Make Terminal Better (remapping defaults and adding functionality)
#  3.   File and Folder Management
#  4.   Searching
#  5.   Process Management
#  6.   Networking
#  7.   System Operations & Information
#  8.   Web Development
#  9.   Reminders & Notes
#
#  ---------------------------------------------------------------------------

#   -------------------------------
#   1.  ENVIRONMENT CONFIGURATION
#   -------------------------------

source ~/git-completion.bash
CVS_RSH="ssh"; export CVS_RSH
# -----------------------------
# INCREASE HISTORY SIZE
export HISTSIZE=10000
export HISTCONTROL=erasedups
export PROMPT_COMMAND="history -a"
shopt -s histappend
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# show possibilities if tab ambigious
set show-all-if-ambiguous on
# ignore case when completing, lets see how it works
set completion-ignore-case on

# -----------------------------

#   -------------------------------
#   python virtualenv needed
#   -------------------------------
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/opt/local/bin/python
export PROJECT_HOME=$HOME/Devel
source /opt/local/Library/Frameworks/Python.framework/Versions/2.7/bin/virtualenvwrapper.sh




#  GIT BITBUCKET ADD

SSH_ENV=$HOME/.ssh/environment

# start the ssh-agent
function start_agent {
    echo "Initializing new SSH agent..."
    # spawn ssh-agent
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add
}

if [ -f "${SSH_ENV}" ]; then
     . "${SSH_ENV}" > /dev/null
     ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi



#   Change Prompt
#   ------------------------------------------------------------


#  GIT PROMPT


function parse_git_branch () {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

#RED="\[\033[0;31m\]"
#YELLOW="\[\033[0;33m\]"
#GREEN="\[\033[0;32m\]"
#NO_COLOR="\[\033[0m\]"

#PS1="$GREEN\u@\h$NO_COLOR:\w$YELLOW\$(parse_git_branch)$NO_COLOR\$ "








#   Set Paths
#   ------------------------------------------------------------


#   Set Default Editor (change 'Nano' to the editor of your choice)
#   ------------------------------------------------------------

  export EDITOR=/usr/bin/nano
  #export PYTHONSTARTUP=~/.pythonrc

#   -----------------------------
#  FERMILAB ACCESS NEEDED
#   -----------------------------


export KRB5_CONFIG=/etc/krb5.conf
export KRB5CCNAME=FILE:/var/tmp/krb5_cc_cache

## to open with sublime from terminal


alias subl='open  -a "Sublime Text 3"'
#   -----------------------------
#   2.  MAKE TERMINAL BETTER
#   -----------------------------

alias cp='cp -iv'                           # Preferred 'cp' implementation
alias mv='mv -iv'                           # Preferred 'mv' implementation
alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
alias ll='ls -FGlAhp'                       # Preferred 'ls' implementation
alias less='less -FSRXc'                    # Preferred 'less' implementation
#cd() { builtin cd "$@"; ll; }               # Always list directory contents upon 'cd'
alias cd..='cd ../'                         # Go back 1 directory level (for fast typers)
alias ..='cd ../'                           # Go back 1 directory level
alias ...='cd ../../'                       # Go back 2 directory levels
alias .3='cd ../../../'                     # Go back 3 directory levels
alias .4='cd ../../../../'                  # Go back 4 directory levels
alias .5='cd ../../../../../'               # Go back 5 directory levels
alias .6='cd ../../../../../../'            # Go back 6 directory levels
alias edit='subl'                           # edit:         Opens any file in sublime editor
alias f='open -a Finder ./'                 # f:            Opens current directory in MacOS Finder
alias ~="cd ~"                              # ~:            Go Home
alias c='clear'                             # c:            Clear terminal display
alias which='type -all'                     # which:        Find executables
alias path='echo -e ${PATH//:/\\n}'         # path:         Echo all executable Paths
alias show_options='shopt'                  # Show_options: display bash options settings
alias fix_stty='stty sane'                  # fix_stty:     Restore terminal settings when screwed up
alias cic='set completion-ignore-case On'   # cic:          Make tab-completion case-insensitive
mcd () { mkdir -p "$1" && cd "$1"; }        # mcd:          Makes new Dir and jumps inside
trash () { command mv "$@" ~/.Trash ; }     # trash:        Moves a file to the MacOS trash
ql () { qlmanage -p "$*" >& /dev/null; }    # ql:           Opens any file in MacOS
alias DT='tee ~/Desktop/terminalOut.txt'    # DT:           Pipe content to file on MacOS


alias adsbibdesk='python ~/Projects/Work/Software/ads_bibdesk/build/lib/adsbibdesk.py'







GLOBUS_LOCATION=/opt/ldg
export GLOBUS_LOCATION
if [ -f ${GLOBUS_LOCATION}/etc/globus-user-env.sh ] ; then
	. ${GLOBUS_LOCATION}/etc/globus-user-env.sh
fi


##################
# SET PATH
##################

export CFITSIO_DIR=/Users/alessandromanzotti/Work/Software/cfitsio
export HEALPIX_DIR=/Users/alessandromanzotti/Work/Software/Healpix_3.00
export HEALPIX_LIB=/Users/alessandromanzotti/Work/Software/Healpix_3.00/libhealpix
export PYTHONSTARTUP=~/.pythonrc


##
# Your previous /Users/alessandromanzotti/.profile file was backed up as /Users/alessandromanzotti/.profile.macports-saved_2012-01-04_at_18:53:28
##

# MacPorts Installer addition on 2012-01-04_at_18:53:28: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.


# Setting PATH for Python 3.2
# The orginal version is saved in .profile.pysave
PATH="/Library/Frameworks:${PATH}"
export PATH

# modifications by HEALPixAutoConf 3.00
[ -r /Users/alessandromanzotti/.healpix/3_00_Darwin/config ] && . /Users/alessandromanzotti/.healpix/3_00_Darwin/config




### colors http://apple.stackexchange.com/questions/33677/how-can-i-configure-mac-terminal-to-have-color-ls-output


export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced




## http://forum.chakra-project.it/index.php?topic=4881.0

#shopt -s cdspell

#http://osxdaily.com/2013/02/05/improve-terminal-appearance-mac-os-x/

alias ls='ls -GFh'

export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "

## a bunch of alias definition



alias cd..="cd .."
alias aq="aquamacs"
alias l="ls -al"
alias lp="ls -p"
alias h=history
alias updateport="sudo port -d selfupdate && sudo port upgrade outdated"
alias wayne="cd Work/Astrophysics/Wayne-B\ lensing/"
alias scott="cd Work/Astrophysics/ISW-Dodelson/ISW_code"
alias cleanport="sudo port clean --all installed && sudo port -f uninstall inactive"
alias indent_f90="emacs  --batch  ISWreconstruction.f90 -f mark-whole-buffer -f f90-indent-subprogram -f save-buffer
"
indentf90 () { emacs  --batch  "$1" -f mark-whole-buffer -f f90-indent-subprogram -f save-buffer ; }




#   ---------------------------
#   6.  NETWORKING
#   ---------------------------

alias myip='curl ip.appspot.com'                    # myip:         Public facing IP Address
alias netCons='lsof -i'                             # netCons:      Show all open TCP/IP sockets
alias flushDNS='dscacheutil -flushcache'            # flushDNS:     Flush out the DNS Cache
alias lsock='sudo /usr/sbin/lsof -i -P'             # lsock:        Display open sockets
alias lsockU='sudo /usr/sbin/lsof -nP | grep UDP'   # lsockU:       Display only open UDP sockets
alias lsockT='sudo /usr/sbin/lsof -nP | grep TCP'   # lsockT:       Display only open TCP sockets
alias ipInfo0='ipconfig getpacket en0'              # ipInfo0:      Get info on connections for en0
alias ipInfo1='ipconfig getpacket en1'              # ipInfo1:      Get info on connections for en1
alias openPorts='sudo lsof -i | grep LISTEN'        # openPorts:    All listening connections
alias showBlocked='sudo ipfw list'                  # showBlocked:  All ipfw rules inc/ blocked IPs


#   ---------------------------
#   6.  Functions Name tab and Window
#   ---------------------------
function tabname {
  printf "\e]1;$1\a"
}

function winname {
  printf "\e]2;$1\a"
}





