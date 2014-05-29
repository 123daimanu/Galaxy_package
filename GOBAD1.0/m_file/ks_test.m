function [H] = ks_test(obs,theo )


edges=[-inf;sort([obs;theo]);inf]; % gives all the points where the $S{_{N_1}}$ and $S{_{N_2}}$ should be compared.
count1=histc(obs,edges);		   % gives the data points in histogram of obs where the bin starts and ends on the points of edges.
count2=histc(theo,edges);

sumcount1=cumsum(count1)./sum(count1); %calculates 1/N for each data point and increases by 1/N for each data points i.e $S{_{N_1}}$
sumcount2=cumsum(count2)./sum(count2);  %calculates 1/N for each data point and increases by 1/N for each data points i.e $S{_{N_2}}$

cdf1=sumcount1(1:end-1);	% makes distribution of $S_{N_{1}}$
cdf2=sumcount2(1:end-1);    % makes distribution of $S_{N_{2}}$

diffcdf=abs(cdf1-cdf2);		% calcultes |$S_{N_{1}}$ -$S_{N_{2}}$|
n1=length(obs);
n2=length(theo);

n=n1*n2/(n1+n2);
ks=max(diffcdf);			%takes maximum value of |$S_{N_{1}}$ -$S_{N_{2}}$| i.e D= max_{-/inf<x</inf}|$S_{N_{1}}$ -$S_{N_{2}}$|

lambda=max((sqrt(n)+0.12+0.11/sqrt(n))*ks,0); 
k=(1:101)';   % must have been infinite sum but the sum have been truncated after 101 values
p=2*sum((-k).^(k-1).*exp(-2*lambda*lambda*k.^2)); % calculation of probablity
p=min(max(p,0),1);
alpha=0.05;
H=(alpha>=p);
if H==0
    'Null hypothesis accepted'
else
   'Null hypothesis rejected'
end



end

