function safe
    safehouse --add-dirs-ro="$HOME/code" $argv
end

# Sandboxed helpers without overriding the original binary names.
function sandbox-claude
    safe claude --dangerously-skip-permissions $argv
end

function sandbox-codex
    safe codex --dangerously-bypass-approvals-and-sandbox $argv
end

function sandbox-amp
    safe amp --dangerously-allow-all $argv
end

function sandbox-gemini
    set -lx NO_BROWSER true
    safe gemini --yolo $argv
end
