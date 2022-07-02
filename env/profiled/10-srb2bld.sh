# SDKROOT is only a required environmental variable for macOS
if command -v srb2bld >/dev/null 2>&1
  then if test -d /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk
    then export SDKROOT="/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk"
  fi
fi