## Getting the code

Clone this code repository locally:

```
git clone https://github.com/osrf/ariac-docker
cd ariac-docker
```

## Preparing the workspace

Team configuration files must be put in the `ariac-docker` directory in a folder with the name of the team.

Let's get the configuration files for an example team called `example_team`:

```
./get_example_team_system.bash
ls
```

You should now see that there is a directory called `example_team` that has the required configuration files in it.

## Preparing the ARIAC system

To prepare the ARIAC competition system (but not run it), call:

```
./prepare_ariac_system.bash
```

This will build a Docker image of the competition server, ready to be launched later.

## Preparing your team's system

To prepare your team's system (but not run it), call:

```
./prepare_team_system.bash example_team

# For your team you will run:
# ./prepare_team_system.bash <your_team_name>
```

This will build a Docker image of your team's system, ready to be launched with the ARIAC competition server.

## Running a single trial

To run a trial (in this case the trial called `example_trial1`), call:

```
./run_trial.bash example_team example_trial1

# For your team you will run:
# ./run_trial.bash <your_team_name> <trial_name>
```

This will instantiate Docker "containers" of the images that we prepared earlier: one for the ARIAC competition, and one for your team's system.
The competition will be started using the competition configuration file associated with the trial name, and the user configuration file associated with your team name.

Once the trial has finished (because your system completed the trial, because you made a call to the `/ariac/end_competition` service, or because time ran out), the logs from the trial will be available in the `logs` directory that has now been created locally.

## Playing back the simulation

To play-back a competition log file, you must have ARIAC installed on your machine, and then you can call:

```
roslaunch osrf_gear gear_playback.launch state_log_path:=`pwd`/logs/example_team/example_trial1/gazebo/state.log
```
