#!/bin/bash

FILELIST=/home/bo/Desktop/omega/mcrhopath

# 0 for all files in FILELIST; everything else for desired number
numberOfFilesToAnalyse=0

root -b compile.C
rm /home/bo/Desktop/omega/mcrhout/*
rm /home/bo/Desktop/omega/mcrhoutpath

#FileNb=$(ls -1 | wc -l)
#echo $FileNb

iFile=0
COUNT0=1

#while [ $iFile -lt 5 ]; do
while read FILE; do
  runscript=run$iFile.C
  echo '#include <iostream>' > $runscript
  echo "void run$iFile() {" >> $runscript
  echo "TString inputFileName = \"$FILE\";" >> $runscript
  echo "TString outputFileName = \"output$iFile.root\";" >> $runscript
  echo '  gROOT->ProcessLine(".L MyClass.C+");' >> $runscript
  echo '  gROOT->ProcessLine(".L Analys.C+");' >> $runscript
  echo "  gROOT->ProcessLine(Analys(inputFileName,outputFileName));" >> $runscript
  echo '  exit();' >> $runscript
  echo '}' >> $runscript

  jobscript=job$iFile.sh
  echo '#!/bin/bash' > $jobscript
  #echo 'export PATH=$PATH:/usr/local/bin/' >> $jobscript
  echo '. /usr/local/bin/thisroot.sh' >> $jobscript
  echo 'cd /home/bo/Desktop/omega' >> $jobscript
  echo "root -b run$iFile.C" >> $jobscript
  echo "rm run$iFile.C" >> $jobscript 
  echo "mv output$iFile.root mcrhout/" >> $jobscript
  
  if [[ ($iFile -ge $numberOfFilesToAnalyse) && ($numberOfFilesToAnalyse -gt 0) ]]; then
      break
  fi
  


  qsub -q batch -e /home/bo/Desktop/omega/log -o /home/bo/Desktop/omega/log $jobscript
  rm $jobscript	
  let iFile++
done < $FILELIST

COUNT=$(expr $iFile - $COUNT0)
#cd /home/bo/omega/mcrhout/
#hadd ../outputall3.root ./*.root
#echo "$COUNT"




