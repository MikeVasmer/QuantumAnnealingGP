echo "Bash Version ${BASH_VERSION}..."
period="3"
echo $period

echo "Initialising auto Git"
while true; do

	# Git pull (and hope for no conflicts!)
	echo "Git pull..."
	git pull

	# Git push (and hope for no conflicts!)
	echo "Git push..."
	git push

	# Period (in seconds) for git push
	sleep $period
done
