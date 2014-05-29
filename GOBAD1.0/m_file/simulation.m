function [simulated_data,total_data ] = simulation( no_of_galaxies,no_of_bins,data_in_bin,bin_start,bins_size )


% SIMULATION[no_of_galaxies,no_of_bins,data_in_bins,bin_start,bin_size]
% THis function helps to eliminate the selection effect of the galaxies by
% doing the simulaiton considering homogenity and isotropy of the universe.

prop=zeros(no_of_bins,1);
for i=1:no_of_bins
    prop(i)=ceil((data_in_bin(i)*no_of_galaxies/(sum(data_in_bin))));
   
end
k=1;

for i=1:no_of_bins
    ran_gal=rand(prop(i),1);
        for j=1:prop(i)
             A(k)=(bins_size*ran_gal(j,1))+bin_start+(i-1)*bins_size;
             k=k+1;
        end
end
total_data=sum(prop);
rand_pos=randperm(sum(prop)); 

LL=A(rand_pos(:));


simulated_data=LL;


end

