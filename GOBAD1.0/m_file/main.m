%--------------------------------------------------------------------------------------------------------------
% 	Program: GOBAD1.0
% 	Programmer: Hemanta Bhattarai
% 	Institution:Central Department Of Physics
%	      		Kirtipur, Kathmandu
%			    Nepal
%-------------------------------------------------------------------------------------------------------------

clear all, clc, close all;

%------------------------------------------------------------------------------------------------------------------
                    '***************************Data loaded************************************'
%------------------------------------------------------------------------------------------------------------------
data=load('data.dat');   
%load data from the destination folder which in .dat format 
%having L,B,P and I in cosecutive columns                                                     
                        
%------------------------------------------------------------------------------------------------------------------                       
     		'*********************Coordinte transformation ************************'
%-----------------------------------------------------------------------------------------------------------------
l=data(:,1);
b=data(:,2);
p=data(:,3);
i=data(:,4);
save('gal_cod.mat','l','b','p','i')    %Save the transferred coordinate
%------------------------------------------------------------------------------------------------------------------

%-----------------------------------------------------------------------------------------------------------------
               '***********************Godlowski_Transformation *********************'
%-----------------------------------------------------------------------------------------------------------------



clear all, 
load gal_cod.mat
[theta1,theta2,phi1,phi2]=godlowski_transformation(l,b,p,i);  %Godlowski_trasnformation done

th=abs([theta1;theta2]');
ph=[phi1;phi2]';
size(th)
size(ph)
dx_theta=5:10:85;
dx_phi=-80:20:80;
n_theta_bins=max(size(dx_theta));
n_phi_bins=max(size(dx_phi));
figure(1);
clf()
hist(th,dx_theta);
title 'Histogram of theta '
xlabel 'theta'
ylabel '# of galaxies'
xlim([0,90])
print -deps 1_theta_histo.eps

figure(2);
clf()
hist(ph,dx_phi);
title 'Histogram of phi';
xlabel 'phi';
ylabel '# of galaxies'
xlim([-90,90])
print -deps 2_phi_histo.eps

save('godl_trans.mat','th','ph','n_theta_bins','n_phi_bins');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
'******************************Histogram:**********************************'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clear all; close all, 
load gal_cod.mat

%%%%%%%%%%%%%%%%%%%%%%%% HISTOGRAM FOR L %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
'Histogram for L'

[l_n,l_data_in_bin,l_binsize,l_bin_start,l_bin_end]=histo_galactic(l,2);
save ('hist_l.mat','l_n','l_data_in_bin','l_binsize','l_bin_start','l_bin_end')
figure(3);
clf()
hist(l,l_n);
xlabel 'l'
ylabel '# galaxies'
title 'Histogram of l'
print -deps 3_hist_l_data.eps

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%% HISTOGRAM FOR B %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
'Histogram for B'

[b_n,b_data_in_bin,b_binsize,b_bin_start,b_bin_end]=histo_galactic(b,2);
save ('hist_b.mat','b_n','b_data_in_bin','b_binsize','b_bin_start','b_bin_end')
figure(4);
clf()
hist(b,b_n);
xlabel 'b'
ylabel '# galaxies'
title 'Histogram of b'
print -deps 4_hist_b_data.eps

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%% HISTOGRAM FOR P %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
'Histogram for P'

[p_n,p_data_in_bin,p_binsize,p_bin_start,p_bin_end]=histo_galactic(p,2);
save ('hist_p.mat','p_n','p_data_in_bin','p_binsize','p_bin_start','p_bin_end')
figure(5);
clf()
hist(p,p_n);
xlabel 'p'
ylabel '# galaxies'
title 'Histogram of p'
print -deps 5_hist_p_data.eps

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% HISTOGRAM OF I %%%%%%%%%%%%%%%%%%%%%%%%%%%%
'Histogram for I'

[i_n,i_data_in_bin,i_binsize,i_bin_start,i_bin_end]=histo_galactic(i,2);
save ('hist_i.mat','i_n','i_data_in_bin','i_binsize','i_bin_start','i_bin_end')
figure(6);
clf()
hist(i,i_n);
xlabel 'i'
ylabel '# galaxies'
title 'Histogram of i'
print -deps 6_hist_i_data.eps


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
'**********************VIRTUAL GALAXIES SIMULAITON********************'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
'*******************Virtual galaxies simulated for L***********************'
clear all; close all; 
load hist_l.mat
[sim_l,total_data_l]=simulation(10^5,l_n,l_data_in_bin,l_bin_start,l_binsize);
save ('virtual_l.mat','sim_l','total_data_l');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
'*******************Virtual galaxies simulated for B**********************'
clear all,close all;
load hist_b.mat
[sim_b,total_data_b]=simulation(10^5,b_n,b_data_in_bin,b_bin_start,b_binsize);
save ('virtual_b.mat','sim_b','total_data_b');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
'**********************Virtual galaxies simulated for P********************'
clear all,close all;
load hist_p.mat
[sim_p,total_data_p]=simulation(10^5,p_n,p_data_in_bin,p_bin_start,p_binsize);
save ('virtual_p.mat','sim_p','total_data_p');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
'*************************Virtual galaxies simulated for i*****************'
clear all,close all;
load hist_i.mat
[sim_i,total_data_i]=simulation(10^5,i_n,i_data_in_bin,i_bin_start,i_binsize);
save ('virtual_i.mat','sim_i','total_data_i');




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
'***********Godlowski_Transfomation for virtual galaxies ***************'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all,close all;

load virtual_b
load virtual_p
load virtual_l
load virtual_i

min_dim=min([total_data_l,total_data_b,total_data_p,total_data_i]);

[theta_1,theta_2,phi_1,phi_2]=godlowski_transformation(sim_l(1:min_dim),sim_b(1:min_dim)...
,sim_p(1:min_dim),sim_i(1:min_dim));

theta=abs(transpose([theta_1,theta_2]'));
phi=transpose([phi_1,phi_2]');

save('virtual_theta_phi.mat','theta','phi');




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
'**************************** COMPARING THE SIMULATED VRS REAL DATA ******************'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all,close all

load godl_trans.mat;
load virtual_theta_phi.mat;
dx_theta=5:10:85;
dx_phi=-80:20:80;

theta_data=th;

phi_data=ph;
size(theta_data)
size(phi_data)
[n_data_bins_theta,data_bin_cent_theta]=hist(theta_data,dx_theta);
[n_data_bins_phi,data_bin_cent_phi]=hist(phi_data,dx_phi);

[n_simul_bins_theta,simul_bin_cent_theta]=hist(abs(theta),dx_theta);
[n_simul_bins_phi,simul_bin_cent_phi]=hist(phi,dx_phi);


n_simul_bins_phi=n_simul_bins_phi;
n_simul_bins_theta=n_simul_bins_theta/2;
n_data_bins_phi=n_data_bins_phi;
n_data_bins_theta=n_data_bins_theta/2;


n_simul_bins_phi_norm=n_simul_bins_phi*(sum(n_data_bins_phi)/sum(n_simul_bins_phi));
n_simul_bins_theta_norm=n_simul_bins_theta*(sum(n_data_bins_theta)/sum(n_simul_bins_theta));

dx_theta_l=(linspace(0,90,100));
dx_phi_l=(linspace(-90,90,200));


theta_simul=spline(data_bin_cent_theta,n_simul_bins_theta_norm,dx_theta_l);
phi_simul=spline(data_bin_cent_phi,n_simul_bins_phi_norm,dx_phi_l);

save('theta.mat')

figure(10);
plot(data_bin_cent_theta,n_data_bins_theta,'oy',data_bin_cent_theta,n_simul_bins_theta_norm,...
'sb',dx_theta_l,theta_simul,'r--');
for i=1:n_theta_bins
    hold on,   
    errorbar(data_bin_cent_theta(i),n_data_bins_theta(i),sqrt(n_data_bins_theta(i)))
end
xlim [0:90];
xlabel 'theta';
ylabel '#';
title 'sim vrs real theta';


print -deps 9_sim_vrs_real_theta.eps;

figure(11);
plot(data_bin_cent_phi,n_data_bins_phi,'oy',data_bin_cent_phi,n_simul_bins_phi_norm,...
'sb',dx_phi_l,phi_simul,'r--');

for i=1:n_phi_bins
    hold on,   
    errorbar(data_bin_cent_phi(i),n_data_bins_phi(i),sqrt(n_data_bins_phi(i)))
end
xlim [-90:90];
xlabel 'phi';
ylabel '#';
title 'sim vrs real phi';
print -deps 10_sim_vrs_real_phi.eps;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[ fourier_coeff_theta,theta_P_greater_delta_1 ]=...
    fourier_test(n_simul_bins_theta_norm,n_data_bins_theta,data_bin_cent_theta);
[ fourier_coeff_phi,phi_P_greater_delta_1 ]=...
    fourier_test(n_simul_bins_phi_norm,n_data_bins_phi,data_bin_cent_phi);

chi_theta=chi2test(n_data_bins_theta,n_simul_bins_theta_norm);
chi_phi=chi2test(n_data_bins_phi,n_simul_bins_phi_norm);
auto_corr_theta=auto_correlation(n_data_bins_theta,n_simul_bins_theta_norm);
auto_corr_phi=auto_correlation(n_data_bins_phi,n_simul_bins_phi_norm);
H_ks_theta=ks_test(th',abs(theta'));
H_ks_phi=ks_test(ph',phi');
H_kv_theta=kv_test(th',abs(theta'));
H_kv_phi=kv_test(ph',phi');
chi_theta_new=chi2test_new(n_data_bins_theta,n_simul_bins_theta_norm);
chi_phi_new=chi2test_new(n_data_bins_phi,n_simul_bins_phi_norm);
stat=[chi_theta,auto_corr_theta,fourier_coeff_theta,theta_P_greater_delta_1,H_ks_theta,H_kv_theta,chi_theta_new...
,chi_phi,auto_corr_phi,fourier_coeff_phi,phi_P_greater_delta_1,H_ks_phi,H_kv_phi,chi_phi_new];

save('stat.mat','stat')
%----------------------------------------------------------------
load stat.mat
l=length(stat);
fstat=fopen('stat.txt','w');
for i=1:l
	fprintf(fstat,'%f\n',stat(i));
end
fclose(fstat);


%----------------------------------------------------------------
l=length(data_bin_cent_phi);
phi_data=fopen('phi.txt','w');
fprintf(phi_data,'%s\t%s\t%s\t%s\n','bin_cent','n_obs_phi','n_simul_phi','error');
for j=1:l
	fprintf(phi_data,'%f\t%f\t%f\t%f\n',data_bin_cent_phi(j),n_data_bins_phi(j),n_simul_bins_phi_norm(j),sqrt(n_data_bins_phi(j)));
end
fclose(phi_data);
%--------------------------------------------------------------------

%----------------------------------------------------------------
l=length(data_bin_cent_theta);
theta_data=fopen('theta.txt','w');
fprintf(theta_data,'%s\t%s\t%s\t%s\n','bin_cent','n_obs_theta','n_simul_theta','error');
for j=1:l
	fprintf(theta_data,'%f\t%f\t%f\t%f\n',data_bin_cent_theta(j),n_data_bins_theta(j),n_simul_bins_theta_norm(j),sqrt(n_data_bins_theta(j)));
end
fclose(phi_data);
%--------------------------------------------------------------------

