# Knitty GUI

## Installation

### GIT

Just clone that repository with:

    git clone https://github.com/knitty/gui.git knitty_main
 
### ZIP
You can also download the latest version as zip file here:

    https://github.com/knitty/gui/archive/master.zip
	

### Processing (initial 2016 version)
Processing requires that the folder has the same name as the main .pde file (knitty_main). 

Place the files under sketchbook/knitty_main

Don't forget to download and place the libraries under sketchbook/libraries/G4P and sketchbook/libraries/sDrop
  g4p_controls.*;    // http://sourceforge.net/projects/g4p/
  sojamo.drop.*;    //  http://www.sojamo.de/libraries/drop/


## Processing (2022 update for Ubuntu 21.10 64 bits and Processing 3.5.4)
Install last Processing stable version 3.x (tested with 3.5.4). Version 4.x requires additional code update and is not yet supported:

- download the [Processing 3.5.4 release for Linux 64 bits](https://github.com/processing/processing/releases/download/processing-0270-3.5.4/processing-3.5.4-linux64.tgz)
- decompress the content in your home folder 
- go to ~/processing-3.5.4 and execute ./install.sh
- in the applicaiton menu open Processing and check the version is 3.5.4
- with git clone the knitty/gui repo into the ~/sketches folder and rename the `gui` folder into `knitty_main`.

Optional: install Arial fonts for Ubuntu with `sudo apt install ttf-mscorefonts-installer` (this requires to accept Microsft license).

Get knitty GUI and start the application:
- clone the knitty/gui repo including 2022 update for Ubuntu 21.10 into the ~/sketches folder and rename `gui` into `knitty_main`
- in Processing IDE open the `knitty_main.pde` file
- in the *sketch menu* check available libraries and import *Drop* and *G4P* libraries if they are not listed. *sojamo drop* is now replaced by *Drop*
- execute the application using `Ctrl-R` shortcut for example
- check the absence of error in the logs.


## Authors

This tool has been programmed by [ptflea](http://github.com/ptflea)

Update from [sietchcode](https://github.com/sietchcode) for Ubuntu 21.10 64 bits and Processing 3.5.4