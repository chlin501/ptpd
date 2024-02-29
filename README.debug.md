# Debug PTPd

# Enable Debug Flag

* `./configure --enable-runtime-debug && make`

# Changes

* Remove *start* script because launch.json's **program** doesn't accept parameters

* Change files allowing debug through ssh

    * Dockerfile

    * launch.json

    * task.json

    * docker-build

    * docker-run

    * build.sh
