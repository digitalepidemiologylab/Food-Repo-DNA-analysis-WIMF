#!/usr/bin/env bash

# Configuration of WIMF v.2.0
# Sets path variables

chmod +x groupReports.sh wimf logCompactor.sh init_dictionary.sh # make scripts executable

echo ""

echo "export PATH=$PWD:\$PATH" >> ~/.bashrc
echo "export WIMF_INSTALL_PATH="$(pwd)"/" >> ~/.bashrc
source ~/.bashrc
echo ""
echo ""
echo "WIMF v2 configuration FINISHED."





