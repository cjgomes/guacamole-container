#!/bin/env bash
#
# Script to setup environment and provision Guacamole on containers
#
# Autor: Carlos Gomes '<cjgomes.it@gmail.com>'

# functions

set -euo pipefail

function Done() {
        echo -e "\E[96G""==> \033[096m""[ Done ]\033[0m"
}

function Fail() {
        echo -e "\E[96G""==> \033[091m""[ Fail ]\033[0m"
}

function Error() {
        echo -e "\E[96G""==> \033[091m""[ Error! ]""\033[0m"
        echo -e "\033[091m""Exiting with error...""\033[0m"
        exit 1
}

function InstallUbuntuBased() {
    echo -e "Install dependencies for Ubuntu based apt distro"
    apt update
    echo -e "Checking if jq is already installed"
    dpkg -s jq &> /dev/null
    if $? -eq 1; then
        echo -n "Installing jq..."
        apt install -qq jq < /dev/null >/dev/null && Done || Fail
    else
        echo -e "jq is already installed"
    fi
    echo -e "Checking if curl is already installed"
    dpkg -s curl &> /dev/null
    if $? -eq 1; then
        echo -n "Installing curl..."
        apt install -qq curl < /dev/null >/dev/null && Done || Fail
    else
        echo -e "curl is already installed"
    fi
    echo -e "Checking if wget is already installed"
    dpkg -s wget &> /dev/null
    if $? -eq 1; then
        echo -n "Installing wget..."
        apt install -qq wget < /dev/null >/dev/null && Done || Fail
    else
        echo -e "wget is already installed"
    fi
    echo -e "Checking if gnupg2 is already installed"
    dpkg -l gnupg2 &> /dev/null
    if $? -eq 1; then
        echo -n "Installing gnupg2..."
        apt install -qq gnupg2 < /dev/null >/dev/null && Done || Fail
    else
        echo -e "gnupg2 is already installed"
    fi

    echo -e "Checking if podman is already installed"
    dpkg -l podman &>/dev/null
    if $? -eq 1; then
        echo "Installing podman repo"
        source /etc/os-release
        echo -n "Getting source list..."
        sh -c "echo 'deb http://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/ /' > /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list" && Done || Fail
        echo -n "Getting gpg key and setup on system..."
        wget -nv https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable/xUbuntu_${VERSION_ID}/Release.key -O- | apt-key add - \
            && Done || Fail
        echo -n "Update apt repos"
        apt update -qq </dev/null > /dev/null && Done || Fail
        echo -n "And finally installing podman..."
        apt install -qq podman < /dev/null > /dev/null && Done || Fail
    else
        echo -e "Podman is already installed"
    fi

}

