# rocm-python

## Building
Run `make build` to do a new build. This will construct an apptainer image and place the output in a `bin` directory at the root of the project.

Run `make rebuild` to clean up and rebuild an image which will not prompt to overwrite an existing sif image in the output directory.

## Installing
Run `make install` as root to install the new apptainer image and corresponding shell scripts into the `/usr/local/bin` directory.

Installing the apptainer image will do 3 things.
1. Move the sif image from the local `bin` directory to `/usr/local/bin`
2. Create a version specific shell script in the `/usr/local/bin` directory for running the apptainer image
3. Create a version agnostic symlink to the version specific shell script in the `/usr/local/bin` directory

## Note:
You may end up with multiple versions of apptainer image and corresponding shell script in the `/usr/local/bin` directory.
You will need to manually clean up any unwanted sif images and shell scripts.

The version agnostic shell script will always point to the most recently installed container version

## Bootstrapping a project


## TODO
enable version switching via update-alternatives

