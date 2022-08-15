# Linux-Course-Tasks
# Task 1
The first task contains parts 1 - 10. Parts 7 and 10 are not scripts, therefore they can not be 
executed. All other parts can be executed.

# Task 2 
The second task contains two script files:
1. collectStats.sh script: the main script of the task that collects the data required. It is 
executed by a locally created cronjob, that executes it every 2 minutes.
2. calAvgs.sh script: calculates averages of the data collected, it is executed using the 
collectStats.sh sciprt.

A modification was added to both scripts, in order to show data to html files.

The format files are used to give a certain format for the html files, and the data is appended periodically onto them.
