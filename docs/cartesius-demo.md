Examples on Cartesius
=====================

## Logging into Cartesius
Depending on your operating system, you need to login to Cartesius with different tools. If you are on Linux or macOS, you can open a Terminal and type:

    ssh user_name@cartesius.surfsara.nl
    
If you are on Windows, you need to install an additional program to emulate a terminal. Frequently used programs are Putty, Gitbash or MobaXterm.

**NB** If you have troubles connecting to Cartesius, it might be because your IP address is not on the whitelist. The shortest, less convenient, way to work around this is to access SURFsara through the the LifeScience Grid UI:

    ssh user_name@gb-ui-kun.els.sara.nl

and to type on the UI:

    ssh user_name@cartesius.surfsara.nl

That is only for today, since the UI is going to be decommissioned soon.

The more convenient way is, of course, requesting the SURFsara helpdesk to have your IP address whitelisted. Please send a mail to the [helpdesk](helpdesk@surfsara.nl), after you figured out your IP address by visiting, for example, [this](http://whatsmyip.org) website.

## First example - (non-planar) benzene?

In this document with examples, the commands typed during the course are explicitly included in the gray blocks. The commands can be copied and pasted into terminal windows.

    cd
    git clone https://github.com/sara-nl/demokun.git

With this command you first go to your home-directory and then obtain the demo material. It will create a directory cartesius-demo. 

### View coordinates of the molecule

Go to the benzene directory and view the coordinates file (12 atoms, 6 carbon atoms (C) and 6 hydrogen atoms (H)).

    cd
    cd cartesius-demo/
    cd examples/
    cd benzene
    cat molecule.zmat
        
or

    cd cartesius-demo/examples/benzene
    cat molecule.zmat
    
### View the molecule (in Molden, only with X11)

    ../../bin/molden molecule.zmat

**NB** Exit Molden by pressing the skull icon

### Inspect the job file

    cat molecule.sh


### Submit the task

    sbatch molecule.sh
    squeue -u your_username

Submit the job and check its status. Replace your_username with your actual username.

### View the result (in Molden, only with X11)

    ../../bin/molden slurm-*.out

Open Molden one more time and see that benzene becomes planar by clicking the movie button. Exit with the skull icon. 

## Second Example

The second example is located in the tertbutylchloride1 subdirectory.

    cd
    cd cartesius-demo/
    cd examples/
    cd tertbutylchloride1
    ls

or

    cd cartesius-demo/examples/tertbutylchloride1/
    ls

This will switch to the right directory and list its contents.

    cat template
    cat run_job.sh
    cat submit_job.sh
    cat plot.gnuplot

The files are discussed one by one:

  * **template** contains the instructions for GAMESS-UK to do a quantum chemical computation on tertbutylchloride with fixed C-Cl bond lengths.
  * **run_job.sh** contains the instructions to run computations for single bond length parameters in the loop of submit_job.sh.
  * **submit_job.sh** is the batch script that is submitted to the scheduler. It starts a run_job.sh for each bondlength on a separate core.
  * **plot.gnuplot** contains the instructions to create a plot from the computed energy values.

Now it is time to submit the job to the scheduler.

    sbatch submit_job.sh

This command will submit your task to the scheduler. As a result, your jobid will show on the screen.

    squeue -u your_username

With this command you will see the status of your job. It will be "Q" initially; once it is running it will change to "R" and finally it will disappear once it is finished.

    ssh node_number

Please replace node_number with your actual node (tcn..) you see. During your job, you have the ability (rights) to login to the nodes where your job is running. 

(Each run\_job will start producing an output file. There should be 10 output files in starting with output\_1.6 until output_10.0)

    grep "total energy      =" output_* | sed 's/output_//g' | sed 's/\://g' | awk '{print $1,$5;}' | \
       sort -n > energy.dat

With this very long command you look for the total energy value (final result) of each separate computation (85 in total). These values are "cleaned" with two "sed" commands and one "awk" command to be in a two column form.

A tool that is frequently used to create plot is gnuplot. On Cartesius, gnuplot is available as a module.

    module load gnuplot
    
With this command the gnuplot environment is loaded.

    gnuplot < plot.gnuplot

With this command, you will create a PNG on Cartesius called energy.png. 

Now, there are two ways to show the result. Firstly, you can install a graphical tool on your laptop so that the cluster can show you the resulting PNG, or you can transfer the PNG to your laptop and open it in a viewer or browser. Tools you need depend on your operating system.

 **a)** View the file on Cartesius

To be able to view the file, you will need an X11 server on your laptop. Depending on your OS, you need to install the following tools:

Windows - Install MobaXterm, or Xming32 (Google them)
Mac OSX - Instal Xquartz (Google it)

If you installed either of these tools, you can view the file by typing:

    display energy.png

**b)**	Download the file to your laptop

To be able to transfer files, you may need a graphical tool. Again, depending on your operating system, you may need to install:

Windows - Install MobaXterm, or WinSCP (Google them)
Mac OSX - You can use the command line (see command below), or install a graphical tool, like Cyberduck (Google it)

The command to transfer the file from Cartesius to your local system is:

    scp your_username@cartesius.surfsara.nl:cartesius-demo/examples/tertbutylchloride/energy.png . 

**NB** Please note that this is one line that should be type on your local terminal.

## Third Example

The third example, the stopos demo, is located in the tertbutylchloride2 subdirectory.

    cd
    cd cartesius-demo/
    cd examples/
    cd tertbutylchloride2
    ls

or

    cd cartesius-demo/examples/tertbutylchloride2/
    ls

This will switch to the right directory and list its contents.

    cat create_pool.sh
    cat template
    cat run_job.sh
    cat submit_job.sh
    cat plot.gnuplot

The files are discussed one by one:

  * **create_pool.sh** will create the token pool (with bond lengths 1.6 to 10.0 Angstrom in steps of 0.1 Angstrom).
  * **template** contains the instructions for GAMESS-UK to do a quantum chemical computation on tertbutylchloride with fixed C-Cl bond lengths.
  * **run_job.sh** contains the instructions to run computations for single bond length parameters until the bond length pool is exhausted.
  * **submit_job.sh** is the batch script that is submitted to the scheduler. It computes the number of cores and starts a run_job.sh for each available core.
  * **plot.gnuplot** contains the instructions to create a plot from the computed energy values.

Continuing with the commands:

     ./create_pool.sh

This command will create the Stopos pool. On your screen you will see a progress indicator. Once finished, there will be 85 values stored in the pool ranging from 1.6 to 10.0.

    sbatch submit_job.sh

This command will submit your task to the scheduler. As a result, your jobid will show on the screen.

    squeue -u your_username

With this command you will see the status of your job. It will be "Q" initially; once it is running it will change to "R" and finally it will disappear once it is finished.

    ssh node_number

Please replace node_number with your actual node (tcn..) you see. During your job, you have the ability (rights) to login to the nodes where your job is running. 

(Each run\_job will start producing output files. For each bond length, you will obtain an output file. These range from output\_1.6 until output_10.0)

    grep "total energy      =" output_* | sed 's/output_//g' | sed 's/\://g' | awk '{print $1,$5;}' | \
       sort -n > energy.dat

With this very long command you look for the total energy value (final result) of each separate computation (85 in total). These values are "cleaned" with two "sed" commands and one "awk" command to be in a two column form. 

A tool that is frequently used to create plot is gnuplot. On Cartesius, gnuplot is available as a module.

    module load gnuplot
    
With this command the gnuplot environment is loaded.

    gnuplot < plot.gnuplot

With this command, you will create a PNG on Cartesius called energy.png. 

Now, there are two ways to show the result. Firstly, you can install a graphical tool on your laptop so that the cluster can show you the resulting PNG, or you can transfer the PNG to your laptop and open it in a viewer or browser. Tools you need depend on your operating system.

 **a)** View the file on Cartesius

To be able to view the file, you will need an X11 server on your laptop. Depending on your OS, you need to install the following tools:

Windows - Install MobaXterm, or Xming32 (Google them)
Mac OSX - Instal Xquartz (Google it)

If you installed either of these tools, you can view the file by typing:

    display energy.png

**b)**	Download the file to your laptop

To be able to transfer files, you may need a graphical tool. Again, depending on your operating system, you may need to install:

Windows - Install MobaXterm, or WinSCP (Google them)
Mac OSX - You can use the command line (see command below), or install a graphical tool, like Cyberduck (Google it)

The command to transfer the file from Cartesius to your local system is:

    scp your_username@cartesius.surfsara.nl:cartesius-demo/examples/tertbutylchloride/energy.png . 

Please note that this is one line.

