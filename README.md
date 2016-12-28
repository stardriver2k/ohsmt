# ohsmt
openHab Script Migration Tool

What does it? 
ohsmt looks for linux shell-scripts (.sh) the are currently in use in any openHAB 1.x enviroment (and its exec binding) and creates new .things, .items and .rule-files for openHab 2.x within the default OH structure below $openhabhome/conf/. 

Why would one use this script?
OH2.x use some elements in different ways then the previous version. One big thing is the new concept of things (see the openHab documentation for further details). The "old" exec binding allowed one to use some one stringer like this:

Switch	Light_GF_Living_Couch	"Steckdose Sofa"	(GF_Living)	{ exec="OFF:/opt/brematic/licht_sofa_off.sh, ON:/opt/brematic/licht_sofa_on.sh" }

In OH2.x, this isn´t possible anymore, if you want to use the new exec binding natively. Here you first have to create two things (one for ON, one for OFF if the don´t deliver its state), create items for those things and then link both things together to a pseudo-item. After that, you can create a rule to get the same result as in OH1.x. Sounds funny? It is not! 

See the following threads to get a clearer view to the problem:
https://community.openhab.org/t/exec-binding-do-not-work/17599/22
https://community.openhab.org/t/question-about-exec-binding-in-oh2/18794/3

Solution:
ohsmt targets just this migration process from OH1.x to OH2.x where one would have to understand the thing-concept first, read thru many posts and discussions and then, eventually, gets its scripts back to work. Thats what i have done ;) But for YOU and all other regular users, i created ohsmt...

Install:
Just copy the code, create a new file in your scripts home directory, make the file runable (sudo chmod 755 YOURFILE.sh, chmod +X YOURFILE.sh), paste the code into the new file, save it and run it! Currently its necessary to run the script from within your scripts home directory. If you want some other behavior (crawl subdirs, multiple storage folders etc) please let me know.

Feel free to adapt the code to your personal needs and have fun with a quick migration of your OH1.x enviroment
