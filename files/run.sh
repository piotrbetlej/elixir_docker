#!/bin/bash

# To be sourced!
service apache2 start

. /etc/profile
cd /usr/local/elixir && ./update.py
