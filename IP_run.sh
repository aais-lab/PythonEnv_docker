command="docker ps | grep python-ip &> /dev/null"
eval $command
if [ $? -ne 0 ] ; then
    open /Applications/Utilities/XQuartz.app
    docker start python-IP
    docker exec -it python-IP /bin/bash
else
    docker stop python-IP
fi
