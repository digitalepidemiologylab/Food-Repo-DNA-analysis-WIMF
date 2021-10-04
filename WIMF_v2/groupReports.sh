#!/usr/bin/env bash

BC_FOLDER="$1" # define path to folder containing WIMF analysis
INSTALL_PATH="${WIMF_INSTALL_PATH}" 	# $WIMF_INSTALL_PATH must be defined during install and saved in ~/.bashrc see documentation
REPORT_FOLDER="${BC_FOLDER}/FullReport"
HTML_FOLDER="${BC_FOLDER}/FullReport/HTML_files"

mkdir -p "$REPORT_FOLDER"
mkdir -p "$HTML_FOLDER"

printf "Copying reports to allReports folder... "
# Copy Filt1 Reports into the REPORT_FOLDER while renaming them

numFilt1=0 # number of "normal" analyses (only one filter applied)
numNot=0 # number of  analysis only one filter applied

# First determine if there are report files for Filt1_Samples:
ls ${BC_FOLDER}/Filt1_Samples/BC*/REPORT/*.html &> /dev/null
isEmpty=$?    # $? gives the previous command output code (0=OK, 2=No such file or directory)
#echo $isEmpty
if [ $isEmpty -eq 0 ]; then
  for i in $(ls ${BC_FOLDER}/Filt1_Samples/BC*/REPORT/*.html); do # List all Filt1 reports
   #echo $i
   thisBC=$(echo $i|awk -F'/' '{print $3}')
   cp -p $i "$REPORT_FOLDER/${thisBC}.html"
  done
fi

# First determine if there are report files for Filt2_Samples:
ls ${BC_FOLDER}/Filt2_Samples/BC*/REPORT/*.html &> /dev/null
isEmpty=$?    # $? gives the previous command output code (0=OK, 2=No such file or directory)
#echo $isEmpty
if [ $isEmpty -eq 0 ]; then
  for i in $(ls ${BC_FOLDER}/Filt2_Samples/BC*/REPORT/*.html); do # List all Filt2 reports
   #echo $i
   thisBC=$(echo $i|awk -F'/' '{print $3}')
   cp -p $i "$REPORT_FOLDER/${thisBC}.html"
  done
fi

# First determine if there are report files for LowFiltReadsSamples:
ls ${BC_FOLDER}/LowFiltReadsSamples/BC*/REPORT/*.html &> /dev/null
isEmpty=$?    # $? gives the previous command output code (0=OK, 2=No such file or directory)
#echo $isEmpty
if [ $isEmpty -eq 0 ]; then
  for i in $(ls ${BC_FOLDER}/LowFiltReadsSamples/BC*/REPORT/*.html); do # List all LowFiltReadsSamples reports
   #echo $i
   thisBC=$(echo $i|awk -F'/' '{print $3}')
   cp -p $i "$REPORT_FOLDER/${thisBC}.html"
  done
fi

# First determine if there are report files for LowRawReadsSamples:
ls ${BC_FOLDER}/LowRawReadsSamples/BC*/REPORT/*.html &> /dev/null
isEmpty=$?    # $? gives the previous command output code (0=OK, 2=No such file or directory)
#echo $isEmpty
if [ $isEmpty -eq 0 ]; then
  for i in $(ls ${BC_FOLDER}/LowRawReadsSamples/BC*/REPORT/*.html); do # List all LowRawReadsSamples reports
   #echo $i
   thisBC=$(echo $i|awk -F'/' '{print $3}')
   cp -p $i "$REPORT_FOLDER/${thisBC}.html"
  done
fi

# Copy Filt1_Samples Report images into the HTML_FOLDER while renaming them
# First determine if there are files for Filt1_Samples:
ls ${BC_FOLDER}/Filt1_Samples/BC*/REPORT/HTML_files/*.png &> /dev/null
isEmpty=$?    # $? gives the previous command output code (0=OK, 2=No such file or directory)
#echo $isEmpty
if [ $isEmpty -eq 0 ]; then
for i in $(ls ${BC_FOLDER}/Filt1_Samples/BC*/REPORT/HTML_files/*.png); do # List all Filt1 reports images
   thisBC=$(echo $i|awk -F'/' '{print $3}')
   oriName=$(echo $i|awk -F'/' '{print $6}')
   newImgName="${thisBC}_${oriName}"
   imgType=$(basename $i) # to distinguish the raw and the filtered reads images
   #echo "IMG_TYPE=$imgType"
   if [ "$imgType" == "LengthvsQualityScatterPlot_dot.png" ]; then
     #echo "RAW"
     sed -i "s/LengthvsQualityScatterPlot_dot.png/$newImgName/g" "$REPORT_FOLDER/${thisBC}.html"
   fi

   if [ "$imgType" == "LengthvsQualityScatterPlot_dotFilt.png" ]; then
     #echo "FILT"
     sed -i "s/LengthvsQualityScatterPlot_dotFilt.png/$newImgName/g" "$REPORT_FOLDER/${thisBC}.html"
   fi
 
   cp "$i" "$newImgName"
   mv "$newImgName" "$HTML_FOLDER"  
  done
fi

# Copy Filt2 Report images into the HTML_FOLDER while renaming them
# Copy Filt2_Samples Report images into the HTML_FOLDER while renaming them
# First determine if there are files for Filt2_Samples:
ls ${BC_FOLDER}/Filt2_Samples/BC*/REPORT/HTML_files/*.png &> /dev/null
isEmpty=$?    # $? gives the previous command output code (0=OK, 2=No such file or directory)
#echo $isEmpty
if [ $isEmpty -eq 0 ]; then
for i in $(ls ${BC_FOLDER}/Filt2_Samples/BC*/REPORT/HTML_files/*.png); do # List all Filt2 reports images
   thisBC=$(echo $i|awk -F'/' '{print $3}')
   oriName=$(echo $i|awk -F'/' '{print $6}')
   newImgName="${thisBC}_${oriName}"
   imgType=$(basename $i) # to distinguish the raw and the filtered reads images
   #echo "IMG_TYPE=$imgType"
   if [ "$imgType" == "LengthvsQualityScatterPlot_dot.png" ]; then
     #echo "RAW"
     sed -i "s/LengthvsQualityScatterPlot_dot.png/$newImgName/g" "$REPORT_FOLDER/${thisBC}.html"
   fi

   if [ "$imgType" == "LengthvsQualityScatterPlot_dotFilt.png" ]; then
     #echo "FILT"
     sed -i "s/LengthvsQualityScatterPlot_dotFilt.png/$newImgName/g" "$REPORT_FOLDER/${thisBC}.html"
   fi
 
   cp "$i" "$newImgName"
   mv "$newImgName" "$HTML_FOLDER" 
  done
fi

# Copy LowFiltReadsSamples Report images into the HTML_FOLDER while renaming them
# First determine if there are files for lowFiltReadsSamples:
ls ${BC_FOLDER}/LowFiltReadsSamples/BC*/REPORT/HTML_files/*.png &> /dev/null
isEmpty=$?    # $? gives the previous command output code (0=OK, 2=No such file or directory)
#echo $isEmpty
if [ $isEmpty -eq 0 ]; then
for i in $(ls ${BC_FOLDER}/LowFiltReadsSamples/BC*/REPORT/HTML_files/*.png); do # List all LowFiltReadsSamples reports images
   thisBC=$(echo $i|awk -F'/' '{print $3}')
   oriName=$(echo $i|awk -F'/' '{print $6}')
   newImgName="${thisBC}_${oriName}"
   imgType=$(basename $i) # to distinguish the raw and the filtered reads images
   #echo "IMG_TYPE=$imgType"
   if [ "$imgType" == "LengthvsQualityScatterPlot_dot.png" ]; then
     #echo "RAW"
     sed -i "s/LengthvsQualityScatterPlot_dot.png/$newImgName/g" "$REPORT_FOLDER/${thisBC}.html"
   fi

   if [ "$imgType" == "LengthvsQualityScatterPlot_dotFilt.png" ]; then
     #echo "FILT"
     sed -i "s/LengthvsQualityScatterPlot_dotFilt.png/$newImgName/g" "$REPORT_FOLDER/${thisBC}.html"
   fi
 
   cp "$i" "$newImgName"
   mv "$newImgName" "$HTML_FOLDER" 
  done
fi

cp "$WIMF_INSTALL_PATH/ReportTemplates/Chart.min.js" "$HTML_FOLDER"  # copy canvas to HTML_files folder


# Copy LowRawReadsSamples Report images into the HTML_FOLDER while renaming them
# First determine if there are files for lowReadSamples:
ls ${BC_FOLDER}/LowRawReadsSamples/BC*/REPORT/HTML_files/*.png &> /dev/null
isEmpty=$?    # $? gives the previous command output code (0=OK, 2=No such file or directory)
#echo $isEmpty
if [ $isEmpty -eq 0 ]; then
  for i in $(ls ${BC_FOLDER}/LowRawReadsSamples/BC*/REPORT/HTML_files/*.png); do # List all LowFiltReadsSamples reports images
   thisBC=$(echo $i|awk -F'/' '{print $3}')
   oriName=$(echo $i|awk -F'/' '{print $6}')
   newImgName="${thisBC}_${oriName}"
   imgType=$(basename $i) # to distinguish the raw and the filtered reads images
   #echo "IMG_TYPE=$imgType"
   if [ "$imgType" == "LengthvsQualityScatterPlot_dot.png" ]; then
     #echo "RAW"
     sed -i "s/LengthvsQualityScatterPlot_dot.png/$newImgName/g" "$REPORT_FOLDER/${thisBC}.html"
   fi

   if [ "$imgType" == "LengthvsQualityScatterPlot_dotFilt.png" ]; then
     #echo "FILT"
     sed -i "s/LengthvsQualityScatterPlot_dotFilt.png/$newImgName/g" "$REPORT_FOLDER/${thisBC}.html"
   fi
 
   cp "$i" "$newImgName"
   mv "$newImgName" "$HTML_FOLDER" 
  done
fi

cp "$WIMF_INSTALL_PATH/ReportTemplates/Chart.min.js" "$HTML_FOLDER"  # copy canvas to HTML_files folder

echo "DONE"
echo ""

