#!/bin/bash

target_app=$1
target_directory=$2

temp_sbom=`mktemp` 
syft $target_app -o cyclonedx-json=$temp_sbom

grype $temp_sbom
