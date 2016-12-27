#!/bin/bash
echo "openHAB EXEC-Script Migration Tool (OHSMT), written by Alexander Karls"

# get the path to the scripts
read -p "Where are your scripts located? (/opt/scripts for example):" scriptsdir
DIRIN=$scriptsdir

# get the path to openHAB 
read -p "Where is openHAB located? (/opt/openhab for example):" ohdir
DIROUT=$ohdir/conf
 
# save and change IFS 
OLDIFS=$IFS 
IFS=$'\n' 
 
# read all file name into an array
fileArray=($(find . -name '*.sh' | cut -d/ -f 2 | cut -d. -f 1 ))
 
# restore it 
IFS=$OLDIFS
 
# get length of an array
tLen=${#fileArray[@]}
 
# use for loop read all filenames and create .things and .items based on the existing scripts
for (( i=0; i<${tLen}; i++ ));
do
  echo "Thing exec:command:${fileArray[$i]} [command=\"$DIRIN/${fileArray[$i]}.sh\", timeout=5]" >> $DIROUT/things/exec.things
  echo "Switch ${fileArray[$i]} "{"channel=\"exec:command:${fileArray[$i]}:run\""}""  >> $DIROUT/items/exec.items
done

# read only the off-file name into an array to avoid doubled entries 
fileArrayOFF=($(find . -name '*off*.sh' | cut -d/ -f 2 | cut -d. -f 1 ))

# restore it
IFS=$OLDIFS

# now read only the ON-file name into an array to use them in rules
fileArrayON=($(find . -name '*on*.sh' | cut -d/ -f 2 | cut -d. -f 1 ))

# restore it
IFS=$OLDIFS

# get length of the OFF-array
tLenOFF=${#fileArrayOFF[@]}

# use for loop read all OFF-filenames and create pseudo-.items based on the existing scripts, then create the matching rules
for (( i=0; i<${tLenOFF}; i++ ));
do
  echo "Switch exec_pseudoswitch$i \"Exec Pseudoswitch $i for ${fileArrayOFF[$i]}\""  >> $DIROUT/items/exec.items
  echo "rule \"Exec Pseudoswitch $i\" when item exec_pseudoswitch$i changed then" >> $DIROUT/rules/exec.rules
  echo "if(exec_pseudoswitch$i.state == OFF)"{"" >> $DIROUT/rules/exec.rules
  echo "${fileArrayOFF[$i]}.sendCommand(ON)" >> $DIROUT/rules/exec.rules
  echo "${fileArrayON[$i]}.postUpdate(OFF)"}"" >> $DIROUT/rules/exec.rules
  echo "if(exec_pseudoswitch$i.state == ON)"{"" >> $DIROUT/rules/exec.rules
  echo "${fileArrayON[$i]}.sendCommand(ON)" >> $DIROUT/rules/exec.rules
  echo "${fileArrayOFF[$i]}.postUpdate(OFF)"}"" >> $DIROUT/rules/exec.rules
  echo "end" >> $DIROUT/rules/exec.rules
done

