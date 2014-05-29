function [ first_coefficient,P_greater_delta_1 ]...
    = fourier_test( N_th,N_obs,angles )
%FOURIER_TEST
%This function take the theoretical and observed number of galaxies with 
%their resepective bin anlges and calulates different parameters in fourie
%er test.
angles=degrad(angles);

delta_11=sum((N_obs-N_th).*cos(2*angles))./sum(N_th.*(cos(2*angles).^2));

delta_21=sum((N_obs-N_th).*sin(2*angles))./sum(N_th.*(sin(2*angles).^2));

sigma_11=1/sqrt(sum(N_th.*(cos(2*angles)).^2));
sigma_21=1/sqrt(sum(N_th.*(sin(2*angles)).^2));
delta_1=sqrt(delta_11^2+delta_21^2);

P_greater_delta_1=exp(-1/4.0*sum(N_obs)*delta_1^2);
first_coefficient=abs(delta_11/sigma_11);

end

