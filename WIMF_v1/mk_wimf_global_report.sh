#!/usr/bin/env bash

# Under Creative commons 4.0 Licence: https://creativecommons.org/licenses/by/4.0/
# Recover input directory path

INPUT_PATH="$1"
if [[ "$INPUT_PATH" == */ ]]
               then INPUT_PATH="${INPUT_PATH::-1}"
            fi
echo $INPUT_PATH

# Delete temporary file "reportPaths" if present
if [ -f reportPaths ]; then
  rm reportPaths
fi

# Delete temporary file "imgPaths" if present
if [ -f imgPaths ]; then
  rm imgPaths
fi

# Create directory GlobalReport and the subdirectory GlobalReport/images_plot which will contain the reports and associated files
# If output directories do not exist, create them
if [ ! -d "$INPUT_PATH/GlobalReport" ]; then
  mkdir "$INPUT_PATH/GlobalReport"
fi
if [ ! -d "$INPUT_PATH/GlobalReport/images_plot" ]; then
  mkdir "$INPUT_PATH/GlobalReport/images_plot"
fi

# Retrieve the paths of all report files contained in the input path directory and subdirectories

echo "Finding html report files..."
for i in "$(ls "$INPUT_PATH"/*_WIMF/*/*/REPORT/*.html)"; do   # get a
   echo "$i"|grep "report.html" >> reportPaths; done


# copy all WIMF reports (reports.html) to GlobalReport directory and give them a new name (which includes their sequencing run name and sample category name and the name of the sample itself).

outputRep=""
while read i; do 
  thisFileName=$(echo "$i"| sed 's/\/.*_WIMF\///' | sed 's/\/REPORT\/report//' | sed 's/\.\.//' | sed 's/\//_/')
  prefix=$(echo "$i" | awk -F "_WIMF/" '{print $1}' | awk -v var="$INPUT_PATH" -F $INPUT_PATH '{print $2}' | sed 's/ /_/')
  echo "Copying report: $i" 
  cp "$i" "$INPUT_PATH/GlobalReport/"
#  echo "DEBUG $INPUT_PATH/GlobalReport/report.html $INPUT_PATH/GlobalReport/$thisFileName"
  mv "$INPUT_PATH/GlobalReport/report.html" "$INPUT_PATH/GlobalReport${prefix}_${thisFileName}"
  echo "$INPUT_PATH/GlobalReport${prefix}_${thisFileName}" >> outputRep

done <reportPaths


# copy the javascript file which is needed to display the barplot (the exact same file is used for all reports)

cp "${WIMF_INSTALL_PATH}ReportTemplates/Chart.min.js" "${INPUT_PATH}/GlobalReport/images_plot/" 

# Retrieve the plot images and save them in a unique name corresponding to the run/quality/sample

for i in "$(ls "$INPUT_PATH"/*_WIMF/*/*/REPORT/HTML_files/*.png)"; do   # get a
   echo "$i"|grep ".png" >> imgPaths; done

while read i; do 
  thisFileName=$(echo "$i"| sed 's/\/.*_WIMF\///' | sed 's/\/REPORT\/HTML_files\/LengthvsQualityScatterPlot_dot.png/plot1.png/' | sed 's/\/REPORT\/HTML_files\/LengthvsQualityScatterPlot_dotFilt.png/plot2.png/' | sed 's/\.\.//' | sed 's/\//_/'| sed 's/ /_/')
  prefix=$(echo "$i" | awk -F "_WIMF/" '{print $1}' | awk -v var="$INPUT_PATH" -F $INPUT_PATH '{print $2}' | sed 's/ /_/')
  echo "Copying image: $i" 
  cp "$i" "${INPUT_PATH}/GlobalReport/images_plot/"
  if [ -f "$INPUT_PATH/GlobalReport/images_plot/LengthvsQualityScatterPlot_dot.png" ]; then
    mv "$INPUT_PATH/GlobalReport/images_plot/LengthvsQualityScatterPlot_dot.png" "$INPUT_PATH/GlobalReport/images_plot${prefix}_${thisFileName}"
  fi
  if [ -f "$INPUT_PATH/GlobalReport/images_plot/LengthvsQualityScatterPlot_dotFilt.png" ]; then
    mv "$INPUT_PATH/GlobalReport/images_plot/LengthvsQualityScatterPlot_dotFilt.png" "$INPUT_PATH/GlobalReport/images_plot${prefix}_${thisFileName}"
  fi
done <imgPaths

rm imgPaths

# Update HTML code of reports to include the paths to images and to Chart.min.js 

while read i; do 
  #echo "ReportPATH = $i"
  repName=$(echo "$i" | rev | cut -d"/" -f 1-5 | rev | sed 's/\//_/g' | sed 's/ /_/g' | sed 's/_REPORT_report//g' | sed 's/_WIMF//g' )
  #echo $repName
  img1Name=$(echo $repName | sed 's/.html/plot1.png/')
  img2Name=$(echo $repName | sed 's/.html/plot2.png/')
  #echo $img1Name
  #echo $img2Name
 # echo "TEST ${INPUT_PATH}/GlobalReport/images_plot/${img1Name}"
  sed -i "s/HTML_files\/Chart.min.js/images_plot\/Chart.min.js/g" "$i"
  sed -i "s/HTML_files\/LengthvsQualityScatterPlot_dot.png/images_plot\/$img1Name/g" "$i"
  sed -i "s/HTML_files\/LengthvsQualityScatterPlot_dotFilt.png/images_plot\/$img2Name/g" "$i"
done <reportPaths


#rm reportPaths





