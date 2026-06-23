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

## Homebrew ---------------------------------------------------------
if test -d /opt/homebrew/bin
    eval (/opt/homebrew/bin/brew shellenv)
end

## Completion & Interactive -----------------------------------------

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

## Exports & Paths --------------------------------------------------

# Domino / vops
set -gx VOPS_PROJECT_PATH "$HOME/biolevate/domino"

## Aliases & Functions ----------------------------------------------

# Navigation
function multicd
    echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
end
abbr --add dotdot --regex '^\.\.+$' --function multicd

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
alias cat="bat --style plain --pager never"
abbr --add gg lazygit
abbr --add lzd lazydocker
abbr --add rr rops run
abbr --add pc process-compose

# FIXME: whatever happens with $PATH and tmux
alias vi=nvim

# FIXME: very strange things are happening with child fish shells and completions

function __dedupe_fish_complete_path
    set -l seen
    set -l out

    for p in $fish_complete_path
        if not contains -- $p $seen
            set -a seen $p
            set -a out $p
        end
    end

    set -g fish_complete_path $out
end

set -g fish_complete_path \
    (string match -v "$HOME/.nix-profile/share/fish/vendor_completions.d" $fish_complete_path)

set -g fish_complete_path \
    (string match -v "/nix/var/nix/profiles/default/share/fish/vendor_completions.d" $fish_complete_path)

set -g fish_complete_path \
    (string match -v "$HOME/.nix-profile/etc/fish/completions" $fish_complete_path)

set -g fish_complete_path \
    (string match -v "/nix/var/nix/profiles/default/etc/fish/completions" $fish_complete_path)

__dedupe_fish_complete_path
