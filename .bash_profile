# bash setting for ue in FreeBSD and derivatives (MacOSX)

# tell FreeBSD (and MacOSX) that we want color
export CLICOLOR=1

#### APPLE SPECIFIC ####
# alias for the wonderful airport utility, by apple
alias airport="/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport"

# alias, use this when travelling long distance and computer has to sleep. Almost the same as power off. (read the "pmset" man page)
alias enter_hibernation="sudo pmset sleep 20 hibernatemode 25;"
alias exit_hibernation="sudo pmset sleep 4 hibernatemode 3;"


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

# So we can locate optional packages with pkg-config
export PKG_CONFIG_PATH="/Library/Frameworks/Mono.framework/Versions/4.0.1/lib/pkgconfig:/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH"

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



######## Pascal Settings #####
alias run_pascal="/Users/artem/shell_scripts/run_pascal_full_path.sh"
alias man-freepascal="man /usr/local/man/man1/fpc.1.gz"

######## C++ PLUS PLUS Settings #####
alias run_cplusplus="/Users/artem/shell_scripts/compile_cplusplus_full_path.sh"

##### GIT ########
# autocompletion
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

########## MORE ALIASES ##########
# this is on by default but force it for safety
shopt -s expand_aliases

# extended ls command,
# note: in FreeBSD -G adds color
alias ll="ls -iHhAlFG"

# to execute C code on the fly with a "here document"
go_libs="-lm -lc"
go_flags="-g -std=c11 -Og -Wall -Wextra -pedantic -include string.h -include stdio.h -include stdlib.h -include math.h -include stdbool.h"
alias go_c="gcc -xc '-' $go_libs $go_flags"

# open current dir in finder
alias op='open .'


# go read the .bashrc_common file
if [ -f "$HOME/.bash_common" ]; then
    source "$HOME/.bash_common"
fi

