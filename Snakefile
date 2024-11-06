#!/bin/bash

import glob
import re

# Get the list of pid values from the filenames in data/original/accel/
accel_files = glob.glob("data/original/accel/accel-*.txt")
ACC_PID = [int(re.search(r"accel-(\d+).txt", f).group(1)) for f in accel_files]

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
    input: "data/original/accel/accel-*.txt"
    output:"data/derived/log-accel.txt"
    shell: """
    cd code/Initial-data-prep
    bash 2-data-check-accel.sh > ../../data/derived/log-accel.txt
    """
