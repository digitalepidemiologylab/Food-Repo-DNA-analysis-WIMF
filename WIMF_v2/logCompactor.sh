#!/usr/bin/env bash

# Under Creative commons 4.0 Licence: https://creativecommons.org/licenses/by/4.0/

# logCompactor for WIMF (What's In My Food) v1.0 logs
# Olivier Emery 08/2019
# Digital Epidemiology Lab (EPFL), Campus Biotech Geneva
# logCompactor allows to "compact" a full log from WIMF (which displays colors and percentage animations as displayed by standard output in the terminal when using "cat WIMF.log") 
# by deleting percentage progression lines and special characters to display colors in the terminal which make the log less readable
# and hard to scroll through. By default WIMF compacts the log at the end of the run but not in case WIMF is interrupted before.
# log compactor may not fully work depending on which errors are displayed.

# BASIC USAGE: ./logCompactor WIMF.log 
# with WIMF.log as the full log file. The output is called WIMFcompact.log and will be located in the same folder as WIMF.log

compactLog() {  # Log compacter to get more compact log (in particular remove % progression lines from PoreChop), takes as argument the filename (including path)
  
  IFS=$'\t\n' # to allow for spaces in file/folder names, set internal field separator to exclude spaces
  FOLDER=$(echo $1 | awk 'BEGIN{FS=OFS="/"}{NF--; print}') # extract folder name without log filename
  echo -e "Compacting log from $1"
  # remove unnecessary output from PoreChop
  # delete from line containing "Loading reads" (not included) until "reads had adapters trimmed from their start" (included)
  sed '/Loading reads/,/reads had adapters trimmed from their start/{//!d}' $1 |
  # delete from line containing "reads had adapters trimmed from their end" (not included) until "reads were split based on middle adapters" (not included)
  sed "/reads had adapters trimmed from their end/,/reads were split based on middle adapters/{//!d}" |
  sed "/reads were split based on middle adapters/,/Filtering of reads without adapters with/{//!d}" |
  # remove escape characters (introduced by coloring scheme)
  sed 's/\x1b//g' |
  # remove all other unnecessary codes (introduced by coloring/bold font schemes)
  sed 's/\[32m//g; s/\[1m//g; s/\[0m//g; s/\[4m//g; s/\[31m//g; s/\[34m//g; s/\[35m//g; s/\[42m//g' >> ${FOLDER}/WIMFcompact.log 
  #sed "/Loading reads/,/{/reads loaded/!d}" $1 | head -n 100
  #sed "/Loading reads/,/reads loaded{/reads loaded/!d}/d" $1 | head -n 100
  IFS=$' \t\n' # reset internal field separator to include spaces
  echo -e "Compact log saved as ${FOLDER}/WIMFcompact.log"
  echo ""
}

compactLog $1
