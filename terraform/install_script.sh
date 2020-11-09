#!/bin/bash

# write your script here to configure instance

sudo apt-get update -y \
&& sudo apt-get upgrade -y \
&& touch /home/ubuntu/vali \
&& sudo apt-get install nginx -y