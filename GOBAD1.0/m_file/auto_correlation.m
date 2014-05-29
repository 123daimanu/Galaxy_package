function [ c_coefficient ] = auto_correlation( obs,theo )
% [CORRELATION_COEFFICIENT]=AUTO_CORRELATION(OBSERVED_NUMBER,THEORETICAL_NUMBER)
%  This funciton calculates the autocorrelation coefficient when observed
% and theoretical number of data  in each bin is passed to the function


n=max(size(obs));
c=0;
for i=1:n-1
    
    if obs(i)<=5 || theo(i)<=5 ||obs(i+1)<=5 || theo(i+1)<=5
        d=0;
    else
        d=(obs(i)-theo(i))*(obs(i+1)-theo(i+1))/sqrt(theo(i)*theo(i+1));
    end
    c=c+d;
end
sigma_c=sqrt(n);
c_coefficient=c/sigma_c;
    

end

