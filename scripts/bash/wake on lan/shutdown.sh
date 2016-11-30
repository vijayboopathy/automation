#!/bin/bash
while true
do
echo "Please select which PC you need to start:"
echo "Press 1 to shutdown Red"
echo "Press 2 to shutdown Yellow"
echo "Press 3 to shutdown Brown"
echo "Press 4 to shutdown Elliots"
echo "Press 5 to shutdown All of them"
echo "Press 6 to exit"
read numb
case $numb in
"1") echo "Shutdown Red"
     ssh ubuntu@192.168.0.25 "sudo poweroff"
     ;;
"2") echo "Shutdown Yellow"
     ssh ubuntu@192.168.0.26 "sudo poweroff"
;;
"3") echo "Shutdown Brown"
     ssh ubuntu@192.168.0.27 "sudo poweroff"
;;
"4") echo "Shutdown Elliots"
     ssh ubuntu@192.168.0.21 "sudo poweroff"
;;
"5") echo "Shutdown all the PC"
ssh ubuntu@192.168.0.21 "sudo poweroff"
echo "elliots got shutdown"
ssh ubuntu@192.168.0.25 "sudo poweroff"
echo "red got shutdown"
ssh ubuntu@192.168.0.26 "sudo poweroff"
echo "yellow got shutdown"
ssh ubuntu@192.168.0.27 "sudo poweroff"
echo "brown got shutdown"
sleep 2
;;
"6") echo "Exiting out of the script"
     exit
     ;;
"*") echo "Invalid Entry"
     ;;
esac
clear
done