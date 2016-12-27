# ohsmt
openHab Script Migration Tool
What does it? 
ohsmt looks for scripts the are currently in use in any openHAB 1.x enviroment and creates new .things, .items and .rule-files for openHab 2.x. Background: OH2.x use some elements in different ways then the previous version. One big thing is the new concept of things (see the openHab documentation for further details). The "old" exec binding allowed one to use some one stringer like this:
Switch	Light_GF_Living_Couch	"Steckdose Sofa"	(GF_Living)	{ exec="OFF:/opt/brematic/licht_sofa_off.sh, ON:/opt/brematic/licht_sofa_on.sh" }
In OH2.x, this isn´t possible anymore, if you want to use the new exec binding natively. Here you first have to create two things (one for ON, one for OFF), create items for those things and then link both things together to a pseudo-item. After that, you can create a rule to get the same result as in OH1.x. Sounds funny? It is not! 

ohsmt targets just this migration process from OH1.x to OH2.x where one would have to understand the thing-concept first, read thru many posts and discussions and then, eventually, gets the scripts back to work. Thats what i have done ;) But for YOU and all other regular users, i created ohsmt...

Install:
Just copy the code, create a new file in your scripts home directory, make the file runable (chmod 755, chomd +X), paste the code into the new file, save it and run it!

Feel free to adapt the code to your personal needs and have fun with a quick migration of your OH1.x enviroment
