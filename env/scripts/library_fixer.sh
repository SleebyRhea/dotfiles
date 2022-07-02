#!/bin/sh
#
# library_fixer: A configurable shell wrapper for gcc/clang to correct
#   library names for luarocks specifically. This is made to cover cases
#   where libraries that have been left unmaintained (though still usable)
#   fail to build on systems due to library file name mismatches.
#
# Author: Alison Wyatt
#
# Example configuration file:
#   ~/.libfix:
#     zzip := zzip-0
#     lib2 := lib2_6.2

PERFORM_EXEC=1

debug() { :; }

for arg
do
  shift

  case $arg in
    (--libfixer-debug-mode)
      PERFORM_EXEC=0
      debug() { echo "$@" ; }
      echo "!!! Enabled debug mode !!!"
      continue
      ;;

    (-l*)
      debug "Testing existence of ~/.libfix"
      if ! test -f ~/.libfix
        then set -- "$@" "$arg" && continue
        else debug "Confirmed, continuing"
      fi

      library="${arg}"
      debug "Checking library variable: ${library}"
      if test -z "$library"
        then set -- "$@" "$arg" && continue
        else debug "Variable not empty, continuing"
      fi

      debug "Checking existence of ${library} in ~/.libfix"
      if ! grep "^${library} *:=..*" ~/.libfix >/dev/null 2>&1
        then set -- "$@" "$arg" && continue
        else debug "Library present, continuing"
      fi

      debug "Getting ${library} from ~/.libfix"
      replacement="$( sed "/^${library} *:=/{s#^${library} *:= *\(..*\)\$#\1#;q;}" ~/.libfix )"


      if test -z "$replacement"
      then
        echo "library_fixer: Failed to fixup ${arg}: $( grep "${library} *:= " ~/.libfix)"
        exit 1
      fi

      echo "!!! library_fixer: replacing ${arg} with ${replacement} !!!"
      arg="${replacement}"
      ;;
  esac

  set -- "$@" $arg
done

if test "$PERFORM_EXEC" = 0
then
  echo "$@"
  exit 0
fi

"$@"
exit $?