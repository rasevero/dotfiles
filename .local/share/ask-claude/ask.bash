ask() {
  local model="${ASK_MODEL:-sonnet}"
  local effort="${ASK_EFFORT:-low}"

  while [[ $# -gt 0 ]]; do
    case "$1" in
      -m) model="$2"; shift 2 ;;
      -e) effort="$2"; shift 2 ;;
      --) shift; break ;;
      *)  break ;;
    esac
  done

  local bin
  bin="$(readlink -f "$(command -v claude)")"

  bwrap \
    --unshare-all --share-net \
    --die-with-parent --new-session \
    --ro-bind /usr /usr \
    --symlink usr/bin /bin \
    --symlink usr/sbin /sbin \
    --symlink usr/lib /lib \
    --symlink usr/lib64 /lib64 \
    --ro-bind-try /etc/resolv.conf /etc/resolv.conf \
    --ro-bind-try /etc/hosts /etc/hosts \
    --ro-bind-try /etc/nsswitch.conf /etc/nsswitch.conf \
    --ro-bind-try /etc/passwd /etc/passwd \
    --ro-bind-try /etc/localtime /etc/localtime \
    --ro-bind-try /etc/ssl /etc/ssl \
    --ro-bind-try /etc/ca-certificates /etc/ca-certificates \
    --ro-bind-try /etc/pki /etc/pki \
    --proc /proc \
    --dev /dev \
    --tmpfs /tmp \
    --tmpfs "$HOME" \
    --bind "$HOME/.claude" "$HOME/.claude" \
    --bind "$HOME/.claude.json" "$HOME/.claude.json" \
    --bind "$HOME/.local/share/ask-claude/AGENTS.md" "$HOME/AGENTS.md" \
    --ro-bind "$bin" "$bin" \
    --setenv HOME "$HOME" \
    --setenv DISABLE_AUTOUPDATER 1 \
    --chdir $HOME \
    "$bin" -p --tools "" --max-turns 1 --no-session-persistence \
    --model "$model" --effort "$effort" \
    "$*"
}
