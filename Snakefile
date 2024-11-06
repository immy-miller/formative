#!/bin/bash

rule all:
    input: "data/derived/log-bm.txt", "data/derived/log-accel.txt"

rule check_bm:
    "check bmx data"
    input: "data/original/BMX_D.csv"
    output:"data/derived/log-bm.txt"
    shell: """
    cd code/Initial-data-prep
    bash 1-data-check-bm.sh > ../../data/derived/log-bm.txt
    """

rule check_accel:
    "check accel data"
    input: "data/original/accel/accel-31132.txt"
    output:"data/derived/log-accel.txt"
    shell: """
    cd code/Initial-data-prep
    bash 2-data-check-accel.sh > ../../data/derived/log-accel.txt
    """
