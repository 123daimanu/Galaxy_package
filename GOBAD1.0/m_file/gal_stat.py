import numpy as num

stat=num.loadtxt('stat.txt')
data=open('stat.tex','w')

data.write('''\color{blue}\underline{For Anisotropy}\color{black}:\n\nP($>\chi^2)<0.05$\n\nC/C($\sigma)>1$\n\n$\Delta_{11}/\sigma(\Delta_{11})>1$\n\nP($>\Delta_1)<0.15$\n\nK-S=1\n\nK-V=1\n\n$\chi^2_{new}<0.05$''')

data.write('''\n\n\n\n\color{blue}\underline{$\Theta$ distribution}\color{black}:\n\nP($>\chi^2$)=%g\n\nC/C($\sigma$)=%g\n\n$\Delta_{11}/\sigma(\Delta_{11})$=%g\n\nP($>\Delta_1)$=%g\n\nK-S=%g\n\nK-V=%g\n\n$\chi^2_{new}$=%g'''%(stat[0],stat[1],stat[2],stat[3],stat[4],stat[5],stat[6]))

data.write('''\n\n\n\n\color{blue}\underline{$\phi$ Distribution}\color{black}:\n\nP($>\chi^2$)=%g\n\nC/C($\sigma$)=%g\n\n$\Delta_{11}/\sigma(\Delta_{11})$=%g\n\nP($>\Delta_1)$=%g\n\nK-S=%g\n\nK-V=%g\n\n$\chi^2_{new}$=%g'''%(stat[7],stat[8],stat[9],stat[10],stat[11],stat[12],stat[13]))
