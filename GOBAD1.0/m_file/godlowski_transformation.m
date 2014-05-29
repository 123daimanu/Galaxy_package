function [ theta1,theta2,phi1,phi2 ] = godlowski_transformation( l,b,p,i )
%GODLOWSKI_TRANSFOMATION 
% this transformation converts 2-d data to 3-d information of the galaxy
% the input are Latitude, longitude, positional angle and inclination
% the output are theta1,theta2,phi1 and phi2

L=degrad(l);
B=degrad(b);           %converts all the angle in degrees to radian
P=degrad(p);
I=degrad(i);

% delta1 = asin(-cos(i).*sin(B)+ sin(i).*sin(P).*cos(B));	%polar angle
% delta2 = asin(-cos(i).*sin(B)- sin(i).*sin(P).*cos(B));	%polar angle
% 
% eta1 = asin ((-cos(i).*cos(B).*sin(L) + sin(i).*(-sin(P).*sin(B).*sin(L)- cos(P).*cos(L)))./cos(delta1));  %azimuthal angle
% eta2 = asin ((-cos(i).*cos(B).*sin(L) + sin(i).*(+sin(P).*sin(B).*sin(L)+ cos(P).*cos(L)))./cos(delta2));  %azimuthal angle



theta1_rad=asin(-cos(I).*sin(B)+sin(I).*sin(P).*cos(B));
phi1_rad=asin((-cos(I).*cos(B).*sin(L)+sin(I).*(-sin(P).*sin(B).*sin(L)-cos(P).*cos(L)))./cos(theta1_rad));


theta2_rad=asin(-cos(I).*sin(B)-sin(I).*sin(P).*cos(B));
phi2_rad=asin((-cos(I).*cos(B).*sin(L)+sin(I).*(sin(P).*sin(B).*sin(L)+cos(P).*cos(L)))./cos(theta2_rad));



theta1=raddeg(theta1_rad);
theta2=raddeg(theta2_rad);


phi1=raddeg(phi1_rad);
phi2=raddeg(phi2_rad);

end

