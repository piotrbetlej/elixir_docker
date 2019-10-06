#!/bin/bash

# set -x

SHARED_DIR="elixir_in_container"
PWD=$(pwd)

# sudo docker run -v ${PWD}/${SHARED_DIR}:/usr/local/elixir_ -it debian_buster:elixir /bin/bash
sudo docker run --name elixir_container -it debian_buster:elixir /bin/bash

# set +x
