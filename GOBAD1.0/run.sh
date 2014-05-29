#------------------------------------------------------------------------
#-------------data file name entered-----------------------------------
echo 'Mind that in .dat file columns should be of L,B ,P and i respectively'
echo 'enter the name of .dat file e.g if it is A1369.dat then enter A1369'
read filename

#--------------------------------------------------------------------------
dat='.dat'
slash='/'
final_file='data.dat'
file_name=${filename}${dat} 
folder=$PWD

#--------copy data file to data.dat and move to m_file folder--------------
cd gal_data
cp ${file_name} ${final_file}
mv ${final_file} ${folder}
cd ${folder}
mv ${final_file} m_file
#-----------------------------------------------------------------------------

cd galaxies

#--------------remove directory of file name and make one new------------------
rm -rf $filename
mkdir $filename
cd ${filename}
reqd_folder=$PWD
#------------------------------------------------------------------------------
cd ${folder}
cd m_file
START=$(date +%s)
octave main.m 

python gal_stat.py 
rm stat.txt
d=".pdf"
pdf_name=${filename}${d}
latex gal_stat.tex 
dvipdf gal_stat.dvi ${pdf_name} 
rm data.dat
rm *.dvi
rm stat.tex
rm *.aux
rm *.log
mv *.txt ${reqd_folder}
mv *.mat ${reqd_folder}
mv *.pdf ${reqd_folder}
mv *.eps ${reqd_folder}
cd ${reqd_folder}
evince ${pdf_name} &
clear
END=$(date +%s)
DIFF=$(( $END - $START ))
echo "It took $DIFF seconds"

