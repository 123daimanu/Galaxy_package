function [ n,data_in_bin,binsize,bin_start,bin_end ] =histo_galactic( data,min_number )
%HISTOGALACTIC
%   This function determines the no of bins, data in each bin,size of bin,
%   bin start positon and bin end position


a=length(data);
i=a;
c=1;
while c~=0
    n=hist(data,i);
  
    c=0;
    for j=1:i
        if (n(j)<min_number)
           c=c+1;
			break;
         end
         
   end
    i=i-1;
end
n=i+1;
[data_in_bin,h]=hist(data,n);
binsize=h(2)-h(1);
bin_start=h(1)-binsize/2;
bin_end=h(length(h))+binsize/2;

end

