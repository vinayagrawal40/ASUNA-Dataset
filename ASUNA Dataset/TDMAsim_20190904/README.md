# TDMA simulator for shared underwater network emulation database

This package collects the scripts required to run a time-division multiple access (TDMA) protocol that makes use of the ASUNA shared underwater network emulation dataset.

The dataset can be accessed here: [https://sites.google.com/marsci.haifa.ac.il/asuna/] (https://sites.google.com/marsci.haifa.ac.il/asuna/)

The simulator is written using Octave/Matlab-compatible code.

The code is meant to be a demonstrator of how the dataset can be opened and queried, and possibly integrated in other, more complex underwater network simulators.

## Structure 

All relevant code is contained in the home folder. The main file is `TDMAsim.m`.
You can open and run `TDMAsim.m` directly, and it will:

- Load all data data structures for one of the shared datasets;
- Set up and run an event-driven TDMA simulation that employs the dataset to decide whether transmissions are received correctly or not;
- Plot some basic results such as the packet delivery ratio, the total number of transmitted packets, and the throughput.

## Options

Most of the simulator's options are collected in the script `setGlobals.m` in order to be found all in the same place, and thus be easier to customize.

Examples of parameters you may vary:

- The dataset to be used in the simulation; just look for the *Load measurement dataset* section in `TDMAsim.m` and comment/uncomment the dataset you wish to use. Note that an artificial dataset is provided, where the packet delivery ratio and throughput curves should resemble a sinusoid;
- The folder where the datasets are placed: go to `setGlobals.m` and you will find it at the beginning of the file. It defaults to `../shared_measurements`;
- The folder where the simulation outcomes will be saved as images. Again go to `setGlobals.m` to change it. It defaults to `../results`;
- The bit rate of the modems: look for parameter `GLO.techBitRate` in `setGlobals.m` and change it to the value of your choice. The datasets employ up to three physical layer technologies, so you should enter three values here. 

## Note

To ensure the reproducibility of the results, the seed of the random number generator has been fixed to 20190131. In order to restore the randomness of some choices (such as the destination of a transmission and the technology to be used), please comment the lines

    mySeed = 20190131;
    rng( mySeed, 'twister' );

in `TDMAsim.m`.



