### Fish Config -----------------------------------------------------

## General Options --------------------------------------------------
set -g fish_greeting "" # Disable the welcome message
set -g fish_key_bindings fish_vi_key_bindings # Enable Vi mode natively

## Vi Mode Cursor ---------------------------------------------------
# Ensure the cursor changes shape in different vi modes
set -g fish_cursor_default block
set -g fish_cursor_insert line
set -g fish_cursor_replace_one underscore
set -g fish_cursor_visual block

# History is handled automatically by Fish, but we can set limits
set -g history_max 50000

## Homebrew ---------------------------------------------------------
if test -d /opt/homebrew/bin
    eval (/opt/homebrew/bin/brew shellenv)
end

## Completion & Interactive -----------------------------------------

# Custom uv run logic (Fish style)
complete -c uv -n "__fish_seen_subcommand_from run" -a "(__fish_complete_path)"

## Tool Setup -------------------------------------------------------

function fish_user_key_bindings
    # Make 'k' in Normal Mode trigger Atuin
    # 'up-or-search' is what Atuin hooks into by default
    bind -M default k _atuin_search

    # Make Ctrl+P go back in command history (Fish native)
    # This works in both Insert and Normal mode
    bind -M insert \cp up-or-search
    bind -M default \cp up-or-search

    # Make Ctrl+N go forward
    bind -M insert \cn down-or-search
    bind -M default \cn down-or-search
end

# Flox
if test -d ~/.config/flox/dev-base/
    eval (flox activate -d ~/.config/flox/dev-base/ -m run)
end

# rbenv
if command -v rbenv >/dev/null
    status --is-interactive; and rbenv init - fish | source
end

## Exports & Paths --------------------------------------------------

# Path Management (Fish uses $fish_user_paths for persistence)
fish_add_path "$HOME/.local/bin"
fish_add_path "$HOME/go/bin"
fish_add_path "/opt/homebrew/opt/postgresql@16/bin"

# Domino / vops
set -gx VOPS_PROJECT_PATH "$HOME/biolevate/domino"

## Aliases & Functions ----------------------------------------------

# Yazi (Function for CWD sync)
function e
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (cat "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

# Navigation
function multicd
    echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
end
abbr --add dotdot --regex '^\.\.+$' --function multicd

# Fix kitty over SSH
# alias ssh="kitty +kitten ssh"

# Trash
abbr --add tp trash

# ls aliases (Eza)
if command -v eza >/dev/null
    alias l='eza -l --icons=auto --group-directories-first'
    alias la='eza -la --icons=auto --group-directories-first'
    alias l.='eza -d .*'
    alias ls='eza'
    alias l1='eza -1'
else
    alias l='ls -lh'
    alias la='ls -lah'
end

# Tools
[ (command -v chezmoi) ]; and alias cm="chezmoi"
alias cat="bat --style plain --pager never"
# abbr --add cat bat --style plain --pager never
abbr --add gg lazygit
abbr --add lzd lazydocker
abbr --add rr rops run
abbr --add pc process-compose
