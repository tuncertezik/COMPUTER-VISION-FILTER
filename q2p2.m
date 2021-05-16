clear all;
tic;
I=imread('Imgtex.tiff');
nf = 100; 
featureVec = imhist(I, nf); % with any arbitrary value of nf
%hist(featureVec,nf)
input_bits=16;
output_bits=7;
d=1;         % radius
theta=45;    % angle - 0,45,90,135
Haralick(I,input_bits,output_bits,d,theta)