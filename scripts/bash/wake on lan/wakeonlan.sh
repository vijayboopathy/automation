#!/bin/bash
while true
do
echo "Please select which PC you need to start:"
echo "Press 1 to start Red"
echo "Press 2 to start Yellow"
echo "Press 3 to start Brown"
echo "Press 4 to start Elliots"
echo "Press 5 to start All of them"
echo "Press 6 to exit"
read numb
case $numb in
"1") echo "Starting Red"
     wakeonlan 70:8b:cd:9f:62:e3
     ;;
"2") echo "Starting Yellow"
     wakeonlan 70:8b:cd:9f:60:ba
     ;;
"3") echo "Starting Brown"
     wakeonlan 70:8b:cd:9f:5e:2b
     ;;
"4") echo "Starting Elliots"
     wakeonlan 00:1e:8c:f4:2c:2c
     ;;
"5") echo "Starting all the PC"
     wakeonlan 70:8b:cd:9f:62:e3
     wakeonlan 70:8b:cd:9f:60:ba
     wakeonlan 70:8b:cd:9f:5e:2b
     wakeonlan 00:1e:8c:f4:2c:2c
     ;;
"6") echo "Exiting out of the script"
     exit
     ;;
"*") echo "Invalid Entry"
     ;;
esac
clear
done