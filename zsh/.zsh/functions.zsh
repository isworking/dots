kg() {
    pkill -f "$1"
}

agrep() {
    grep -RIn --color=always -E \
        "(^|[^[:alnum:]_])$1([^[:alnum:]_]|$)" .
}

multi() {
    local n="$1"
    shift

    for ((i = 1; i <= n; i++)); do
        print -P "%F{green}Running $i time(s)%f"
        "$@" >/dev/null 2>&1
    done
}
