function gaa
  git add --all
end

function ggpush
  git push $argv origin (git_branch_name)
end

function gc
  git commit $argv
end

function funpush
  git push -f origin (git_branch_name)
end

function gco
  git checkout $argv
end
