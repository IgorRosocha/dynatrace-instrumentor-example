export PATH="$PATH:/usr/local/bin"
export PATH="$PATH:/opt/homebrew/bin"

if [[ -x "$SRCROOT/.dynatrace/DTSwiftInstrumentor" ]]
then
    instrumentorExecutable="$SRCROOT/.dynatrace/DTSwiftInstrumentor"
    echo "using local Dynatrace SwiftUI instrumentor in: $instrumentorExecutable"
elif [[ -x "$(command -v DTSwiftInstrumentor)" ]]
then
    instrumentorExecutable="$(command -v DTSwiftInstrumentor)"
    echo "using system Dynatrace SwiftUI instrumentor in: $instrumentorExecutable"
else
    echo "error: No installed Dynatrace SwiftUI instrumentor found."
    exit 1
fi

"$instrumentorExecutable" get-forward-messages "$SRCROOT"
exit $?
