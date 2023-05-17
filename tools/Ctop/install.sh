#!/bin/bash

{
    sudo curl -L https://github.com/bcicen/ctop/releases/download/v0.7.7/ctop-0.7.7-linux-amd64 -o /usr/local/bin/ctop
    sudo chmod +x /usr/local/bin/ctop
    ctop
}
