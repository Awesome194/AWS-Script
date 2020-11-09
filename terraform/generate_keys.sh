#!/bin/bash
KeyName="login_key"
ssh-keygen -b 2048 -t rsa -f $KeyName -q -N ""
