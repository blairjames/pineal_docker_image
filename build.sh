#!/usr/bin/env bash

# Env Vars for SSH.
source /root/.ssh/agent/root || . /root/.ssh/agent/root

# Log file
log="/home/docker/pineal_docker_image/log.build"

# Generate timestamp
timestamp () {
    date +"%Y%m%d_%H%M%S"
}

# Log and Print
logger () {
    printf "$1\n"
    printf "$(timestamp) - $1\n" >> $log
}

# Exception Catcher
except () {
    logger $1
    exit 1
}

# Assign timestamp to ensure var is a static point in time.
timestp=$(timestamp)
logger "Starting Build.\n"

# Build the image using timestamp as tag.
if /usr/bin/docker build /home/docker/pineal_docker_image -t docker.io/blairy/pineal:$timestp --no-cache --rm --pull >> $log; then
    logger "Build completed successfully.\n\n"
else
    logger "Build FAILED!! Aborting.\n\n"
    exit 1
fi

# Push to github - Triggers builds in github and Dockerhub.
# TODO: Make this a function and add better exception management.. 
# only run this if the SSH function is successful.
git () {
    git="/usr/bin/git -C /home/docker/pineal_docker_image"
    $git pull git@github.com:blairjames/pineal_docker_image.git >> $log || except "git pull failed!"
    $git add --all >> $log || except "git add failed!"
    $git commit -a -m 'Automatic build '$(timestamp) >> $log || except "git commit failed!"
    $git push >> $log || except "git push failed!"
}

# Run the git transactions
if git; then
    logger "git completed successfully." 
else
    logger "git failed!!" 
fi

# Push the new tag to Dockerhub.
if docker push blairy/pineal:$timestp >> $log; then 
    logger "Docker push completed successfully.\n\n"
else
    logger "Docker push FAILED!!\n\n"
    exit 1 
fi

# Prune
cd /home/docker/pineal_docker_image && /usr/bin/git gc --prune || logger "ERROR! git-gc failed!"

# All completed successfully
logger "All completed successfully"
