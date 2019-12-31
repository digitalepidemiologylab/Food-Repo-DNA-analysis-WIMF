# WIMF Under Creative commons 4.0 Licence: https://creativecommons.org/licenses/by/4.0/

#!/usr/bin/env bash

echo "STARTED..."
wimf -i "../SwissDecodeData/RAWDATA/20190123 Sequencing/" -e
echo "JOB1 done"
wimf -i "../SwissDecodeData/RAWDATA/20190312 Sequencing/" -e
echo "JOB2 done"
wimf -i "../SwissDecodeData/RAWDATA/20190504 Sequencing/" -e
echo "JOB3 done"
wimf -i "../SwissDecodeData/RAWDATA/20190710 Sequencing/" -e
echo "JOB4 done"
wimf -i "../SwissDecodeData/RAWDATA/20190711 Sequencing/" -e
echo "JOB5 done"
wimf -i "../SwissDecodeData/RAWDATA/20190730 Sequencing/" -e
echo "JOB6 done"
wimf -i "../SwissDecodeData/RAWDATA/20190805 Sequencing/" -e
echo "JOB7 done"
wimf -i "../SwissDecodeData/RAWDATA/20190807 Sequencing/" -e

echo "FINISHED"
