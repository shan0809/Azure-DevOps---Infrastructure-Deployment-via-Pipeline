#!/usr/bin/env bash

function detect_os {
    uname="$(uname)"
    case "$uname" in
        Darwin*)
            echo darwin
            ;;
        Linux*)
            echo linux
            ;;
        MINGW*)
            echo windows
            ;;
        *)
            # assuming for now that Windows is used (cygwin, git-bash, ...)
            echo windows
            ;;
    esac
}
function install_tf {
    platform=$(detect_os)
    architecture=amd64
    tf_version='0.12.24'
    download_url="https://releases.hashicorp.com/terraform/${tf_version}/terraform_${tf_version}_${platform}_${architecture}.zip"

    echo "Downloading Terraform from '${download_url}'"
    curl --fail -o tf.zip "${download_url}"
    rm -f ./terraform
    unzip -o tf.zip
    chmod +x terraform
    ./terraform --version | grep "${tf_version}"
    rm tf.zip
}

install_tf
echo "Version of Terraform is"


