echo "Bash Version ${BASH_VERSION}..."
period="3h"
echo $period

echo "Initialising auto Git"
while true; do

	# Git pull (and hope for no conflicts!)
	echo "git pull"
	git pull

	# Git add all
	echo "git add -A"
	git add -A
	# Git commit
	echo "git commit -m 'auto-commit'"
	git commit -m "auto-commit"
	# Git push (and hope for no conflicts!)
	echo "git push"
	git push

	# Period (in seconds) for git push
	sleep $period
done
