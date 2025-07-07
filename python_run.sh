command="docker ps | grep python-ip &> /dev/null"
eval $command
if [ $? -ne 0 ] ; then
    open /Applications/Utilities/XQuartz.app
    docker start python-citam-pydraw
    docker exec -it python-citam-pydraw /bin/bash
else
    docker stop python-citam-pydraw
fi
