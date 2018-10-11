function gaa
	git add --all
end

function ggpush
  git push origin (git_branch_name)
end

function gc
  git commit $argv
end

function funpush
  ggpush -f
end

function gco
  git checkout $argv
end
