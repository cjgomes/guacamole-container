#!/bin/env bash
#
# Script to setup environment and provision Guacamole on containers
#
# Autor: Carlos Gomes '<cjgomes.it@gmail.com>'

# functions

function Done() {
    if $? = 0; then
        echo -e "\E[96G"'==> \033[096m'"[ Done ]\033[0m"
    fi
}

function Fail() {
    if $? = 1; then
        echo -e "\E[96G"'==> \033[091m'"[ Fail ]\033[0m"
    fi
}

function Error() {
    if $? = 1; then
        echo -e "\E[96G"'==> \033[091m'"[ Error! ]\033[0m"
        exit 1
    fi
}
