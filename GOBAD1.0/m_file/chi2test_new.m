function [ prob ] = chi2test_new( obs,theo)
%[Prob]= CHI2TEST(OBS,THEO)
%  The above funciton return the probablity that the observed distribution
% is same as the theoretical distribution.

n=max(size(obs));
% to eliminate data where theoretical value and observed value is 0
for i=1:n
    if theo(i)==0 && obs(i)==0
        theo(i)=1;
        obs(i)=1;
    end
end
 chi2=sum((obs-theo).^2./(theo+obs));
 a=(n-1)/2;
 f=@(x)exp(-x).*x.^(a-1);
 p=1/gamma(a)*quad(f,0,chi2/2);
 prob=1-p;


end

