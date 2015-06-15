# To see your most frequent/popular commands:  history | awk '{print $3}' | sort | uniq -c | sort -rn | head
# Erase a history line artem  >>history -d <history line number>


#### APPLE SPECIFIC ####
# alias for the wonderful airport utility, by apple
alias airport="/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport"

# alias, use this when travelling long distance and computer has to sleep. Almost the same as power off. (read the "pmset" man page)
alias enter_hibernation="sudo pmset sleep 20 hibernatemode 25;"        	
alias exit_hibernation="sudo pmset sleep 4 hibernatemode 3;"


##### SHELL TWEAKS #####
# set default editor
# Better set both, VISUAL and EDITOR. 
export VISUAL=vim
export EDITOR="$VISUAL"

# now when you do !5 to get 5th command from history, the command will be pasted on the line
# instead of directly executed
shopt -s histverify

#  forces man to display not just the first page that matches, but all matching pages. So man looks through all sections 1-8.
alias man="man -a"

# forse mv to always be verbose
alias mv="mv -v"

# alias for cp (copy). This will force it to prompt before overriding colliding files.
alias cp="cp -i"

# extended ls command, 
alias ll="ls -iHpAGlog"          

# default colors="exfxcxdxbxegedabagacad", do "man ls" for info. blue=dirs, brown/yellow=sym link, cyan/sky blue = any weird file
export LSCOLORS="exdxFxFxxxFxFxFxFxFxFx"

# time saviour 
alias up="cd .."

# Compress the cd, ls -l series of commands.
function cl () {
   if [ $# = 0 ]; then
      cd && ll
   else
      cd "$*" && ll
   fi
}

# saves time so we don't type history 300 every time, 
alias h="history 300"

# any lines matching the previous history entry will not be saved 
export HISTCONTROL=ignoreboth

# number of commands to remember in the command history 
export HISTSIZE=1000000

# Not sure exactly, but artem reckons that this is the size of the file, (maybe its just for compatibility and so its same as HISTSIZE) 
export HISTFILESIZE=200000000

# A colon-separated list of patterns used to decide which command lines should be saved on the history list. Prefix matching is used. 
export HISTIGNORE="&:pwd:ls:ls -l:ls -la:cd /:cd ..:history:h:ll" 

# Write a timestamp in front of every command. [ %d-Day | %m-Month | %y-Year | %T-Time ]
export HISTTIMEFORMAT="%y/%m/%d  "



#### PACKAGES AND TOOLS ####
# I already have the basic PostgreSQL tools available on the codline 
# (like createdb) but this path also brings "PROJ.4", "GDAL" and "PostGIS" tools. 
export PATH="/Applications/Postgres.app/Contents/Versions/9.3/bin:${PATH}"

# For cmake, cmake-gui (recommended), ccmake, and a few other cmake things.
export PATH="${PATH}:/Applications/CMake.app/Contents/bin/"

# MacPorts Installer addition on 2014-11-23_at_19:20:58: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:${PATH}"

# Setting PATH for Python 2.7
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
export PATH

#Setting for python to stop writing byte code (".pyc" files)
export PYTHONDONTWRITEBYTECODE=1

# Warning control, equivalent to specifying the -W option. See python docs for more details.
export PYTHONWARNINGS="all"

# So we can locate optional packages with pkg-config
export PKG_CONFIG_PATH="/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH"

##### PROGRAMMING IN C  ####
# compile source given full path to the file
alias comp_path="/Users/artem/shell_scripts/compile_full_path.sh"
alias makebuild_and_run="/Users/artem/shell_scripts/makebuild_and_run.sh"


## Some C libraries

# pq is for postgresql library libpq
export PQ_LIBS="-lpq"
export GLEW_LIBS="-lGLEW"
export GLFW3_LIBS="$(pkg-config --libs --static glfw3)"

export GLFW3_FLAGS="$(pkg-config --cflags glfw3)"

export OPENGL_DEV_FLAGS="$GLFW3_FLAGS"
export OPENGL_DEV_LIBS="$GLFW3_LIBS $GLEW_SETTINGS $PQ_SETTINGS -lm"


# "-m" specify target arch bitness -m32 or -m64
# -Weverything is only for clang on mac

export C_STD_FLAG="-std=c11"

export CLANG_FLAGS="-O0 $C_STD_FLAG -pedantic -Wall -Wextra -Weverything"

export GCC_FLAGS="-v $C_STD_FLAG -pedantic -Wextra -Wall -W -Wdeclaration-after-statement \
            	-Weffc++ -Wpointer-arith -Wcast-qual -Wmissing-prototypes \
            	-pedantic-errors -Waggregate-return \
            	-Wchar-subscripts  -Wcomment -Wconversion \
            	-Wdisabled-optimization \
            	-Wformat=2 -Wmultichar \
            	-Wformat-nonliteral -Wformat-security  \
            	-Wformat-y2k \
            	-Wimplicit  -Wimport  -Winit-self  -Winline \
            	-Winvalid-pch   \
            	-Wunsafe-loop-optimizations  -Wlong-long -Wmissing-braces \
            	-Wmissing-field-initializers -Wmissing-format-attribute   \
            	-Wmissing-include-dirs -Wmissing-noreturn \
            	-Wpacked -Wparentheses \
            	-Wredundant-decls -Wreturn-type \
        	-Wsequence-point -Wsign-compare  -Wstack-protector \
            	-Wstrict-aliasing=1 -Wswitch \
            	-Wswitch-enum -Wtrigraphs  -Wuninitialized \
            	-Wunknown-pragmas  -Wunreachable-code -Wunused \
            	-Wunused-function  -Wunused-label  -Wunused-parameter \
            	-Wunused-value  -Wunused-variable  -Wvariadic-macros \
            	-Wvolatile-register-var  -Wwrite-strings \
            	-Wno-missing-braces -Wno-missing-field-initializers \
            	-Wswitch-default -Wcast-align \
            	-Wbad-function-cast -Wstrict-overflow=5 -Wstrict-prototypes \
            	-Wundef -Wnested-externs -Wshadow \
            	-Wlogical-op -Wfloat-equal \
            	-Wold-style-definition -Wno-padded \
            	-g -g3 -ggdb3 \
            	-O0 \
            	-fno-omit-frame-pointer -fno-common -fstrict-aliasing -fstrict-overflow"


# making a "here document" with C
go_libs="-lm"
go_flags="-g -Wall -include stdio.h -include math.h -include stdlib.h -O3" 
alias go_c="gcc -xc '-' $go_libs $go_flags"

## use like:         	the '---' can be any chars, if they are not quoted shell will perform default expansions.
# go_c << '---'
# int main(){printf("Hello from the command line.\n");} 
# ---
# ./a.out

######## Pascal Settings #####
alias run_pascal="/Users/artem/shell_scripts/run_pascal_full_path.sh"
alias man-freepascal="man /usr/local/man/man1/fpc.1.gz"


######## C++ PLUS PLUS Settings #####
alias run_cplusplus="/Users/artem/shell_scripts/compile_cplusplus_full_path.sh"

# turn off terminal colours. Just in case you ever need this.
# export CLICOLOR=0


##### GIT ########
# autocompletion
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi


