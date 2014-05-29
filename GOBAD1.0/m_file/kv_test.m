function [H] = kv_test(obs,theo )


edges=[-inf;sort([obs;theo]);inf];
count1=histc(obs,edges);
count2=histc(theo,edges);

sumcount1=cumsum(count1)./sum(count1);
sumcount2=cumsum(count2)./sum(count2);

cdf1=sumcount1(1:end-1);
cdf2=sumcount2(1:end-1);

diffcdf1=(cdf1-cdf2);
diffcdf2=(cdf2-cdf1);
n1=length(obs);
n2=length(obs);

n=n1*n2/(n1+n2);
d1=max(diffcdf1);
d2=max(diffcdf2);
ks=d1+d2;

lambda=max((sqrt(n)+0.155+0.24/sqrt(n))*ks,0);
k=(1:101)';
p=2*sum((4*k.^2.*lambda.^2-1).*exp(-2*lambda*lambda*k.^2));
p=min(max(p,0),1);
alpha=0.05;
H=(alpha>=p);
if H==0
    'Null hypothesis accepted'
else
   'Null hypothesis rejected'
end



end

