#!/usr/bin/env bash

# Configuration of WIMF v.1.0
# Downloads database and sets path variables

chmod +x mk_wimf_global_report.sh wimf multipleWIMFs.sh logCompactor.sh # make scripts executable
if test -f "BLASTdb_16SrbcL.gz"; 
        then # if file exists, delete it (to avoid problems if the download was interrupted before)
          rm "BLASTdb_16SrbcL.gz"
fi
# Download database (771Mb)
wget https://foodrepo-dna-analysis.s3.eu-central-1.amazonaws.com/db/BLASTdb_16SrbcL.gz
echo ""
echo "Decompressing BLAST database:"
tar -zxvf BLASTdb_16SrbcL.gz # uncompress database (1.4Gb)
echo "Removing compressed BLAST database file."
rm -v BLASTdb_16SrbcL.gz # remove compressed file
echo "export PATH=$PWD:\$PATH" >> ~/.bashrc
echo "export WIMF_INSTALL_PATH="$(pwd)"/" >> ~/.bashrc
source ~/.bashrc
echo ""
echo ""
echo "WIMF configuration FINISHED."




