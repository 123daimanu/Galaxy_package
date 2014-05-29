##########################################################################################################################################
###		Programmer: Hemanta Bhattarai												
###		Institute: Central Department of Physics, Tribhuvan University				
##		Graduate Student of Astrophysics											
##		Date:16 July 2013													
## 		System: Python 2.6 and Numpy package.									
##		Objective: To do the transformation of the coordinate in astrophysics by using NED calculator
##			via python using package urllib2 and numpy									
##		Acknowledgement: Prof. Binil Aryal, who firstly told about the concept.							 
##				 Saroj Dhakal, Saroj DC and Ishowr Poudel.								
##		Special Thanks:	Ramesh Pandey.(who introduced me with the term 'web scrapping' and this term helped me to search how it 
##				can be done and without this term I couldn't have done this coding.					
##########################################################################################################################################


import urllib
import urllib2
import numpy as num
a= input('What is your orginal coordinate system\n1.Equatorial\n2.Galactic\n3.Ecliptic\n4.Supergalactic\n\n***Enter the corresponding number.eg for Galactic please enter 2*********\n')
if a==1:
	in_csys='Equatorial'
elif a==2:
	in_csys='Galactic'
elif a==3:
	in_csys='Ecliptic'
elif a==4:
	in_csys='SuperGalactic'
else :
	print"Please enter the valid number and try again"
	exit()


b= input('In which  coordinate system do you want to convert\n1.Equatorial\n2.Galactic\n3.Ecliptic\n4.Supergalactic\n\n***Enter the corresponding number.eg for Galactic please enter 2*********\n')
if b==1:
        out_csys='Equatorial'
elif b==2:
        out_csys='Galactic'
elif b==3:
        out_csys='Ecliptic'
elif b==4:
        out_csys='SuperGalactic'
else :
        print"Please enter the valid number and try again"
        exit()
a_1=input('What is the equinox of the data\n1. 1950\n2.J2000')
if a_1==1:
	in_equinox='1950'
elif a_1==2:
	in_equinox='J2000'
else:
	print("Enter valid number and try again")
	exit()

b_1=input('What is the equinox of the output data\n1. 1950\n2.J2000')
if b_1==1:
        out_equinox='1950'
elif b_1==2:
        out_equinox='J2000'
else:
        print("Enter valid number and try again")
        exit()

c=raw_input("Enter the path of the .dat file where your orginal data with longitude, latitude and position angle in three different column is.eg /home/manu/Desktop/in.dat\n")

file1=num.loadtxt(c)
d=raw_input("Enter full path where you want to save the file. eg. /home/manu/Desktop/out.dat\n")

file2=open(d,'w')
size=num.shape(file1)
n=max(size)


for i in range(n):

	values={'in_csys':in_csys,'in_equinox':in_equinox,'obs_epoch':'1950.0','lon':str(file1[i][0])+'d','lat':str(file1[i][1])+'d','pa':str(file1[i][2]),'out_csys':out_csys,'out_equinox':out_equinox}
	data_entry=urllib.urlencode(values)
	url='http://ned.ipac.caltech.edu/cgi-bin/calc?'
	respond=urllib2.urlopen(url,data_entry)
	lines=respond.readlines()
	a=lines[18].split()
	print a
	file2.write('%f\t%f\t%f\n'%(float(a[0]),float(a[1]),float(a[2])))
		
file2.close()


