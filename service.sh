#!/bin/bash

# help function
function help_f {
    echo " Usage: $0 {start|stop|restart}"
}

# start services
function start_f {
    cd /opt/loep_v1.0
    for each_service in $(ls *.sh); do
	echo -n "[+] starting $each_service service ... " 
	$(pwd)/$each_service > /dev/null 2>1 &
	if [ "$?" = "0" ]; then
	    echo "done."
	else
	    echo "failed!"
	fi
    done
}

# stop services
function stop_f {
    cd /opt/loep_v1.0
    for each_service in $(ls *.sh); do
	echo -n "[+] stopping $each_service service ... "
	pid=$(ps ax | grep "$each_service" | grep -v grep | awk '{print $1}')
	kill $pid
	if [ "$?" = "0" ]; then
	    echo "done."
	else
	    echo "failed!"
	fi
    done
}

# restart services
function restart_f {
    stop_f
    echo ""
    start_f
}

case $1 in
    start) start_f ;;
    stop) stop_f ;;
    restart) restart_f ;;
    *) help_f ;;
esac
