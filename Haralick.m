function F=Haralick(image,input_bits,output_bits,d,theta)
% Calculating the SGLD matrix
% getting the size of the input image
im_final=floor(double(image)/(2^output_bits));
[im_final_x im_final_y]=size(im_final);

% setting the size of the co-occurence matrices depending on the grey level depth
CO_size=2^input_bits/(2^output_bits);
SGLD=zeros(CO_size,CO_size);
switch theta
case {0}
for i=1:im_final_x
for j=1:(im_final_y-d)
SGLD(im_final(i,j)+1,im_final(i,j+d)+1)=SGLD(im_final(i,j)+1,im_final(i,j+d)+1)+1;
end
end
case {45}
for i=(1+d):im_final_x
for j=1:(im_final_y-d)
SGLD(im_final(i,j)+1,im_final(i-d,j+d)+1)=SGLD(im_final(i,j)+1,im_final(i-d,j+d)+1)+1;
end
end

case {90}
for i=(1+d):im_final_x
for j=1:im_final_y
SGLD(im_final(i,j)+1,im_final(i-d,j)+1)=SGLD(im_final(i,j)+1,im_final(i-d,j)+1)+1;
end
end

case {135}
for i=(1+d):im_final_x
for j=(1+d):im_final_y
SGLD(im_final(i,j)+1,im_final(i-d,j-d)+1)=SGLD(im_final(i,j)+1,im_final(i-d,j-d)+1)+1;
end
end
end
% make the SGLD matrix symmetric by adding it's transpose to it
SGLD=SGLD+SGLD';

% normalize the SGLD matrix to values between 0 and 1
SGLD=SGLD/sum(sum(SGLD));

% Calculating the texture features from the SGLD matrix
foo=SGLD;
% Entropy
entropy=sum(sum(-((full(spfun(@log2,foo))).*foo)));
%Inertia:
[i,j,v]=find(foo);
inertia=sum((((i-1)-(j-1)).*((i-1)-(j-1))).*v);
% Inverse differnece moment:
inverse_diff=sum((1./(1+(((i-1)-(j-1)).*((i-1)-(j-1))))).*v);
% Correlation:
[m,n]=size(foo);

px=sum(foo,2);
[i,j,v]=find(px);
mu_x=sum((i-1).*v);
sigma_x=sum((((i-1)-mu_x).^2).*v);
h_x=sum(sum(-((full(spfun(@log2,px))).*px)));
temp1=repmat(px,[1 m]);

py=sum(foo,1);
[i,j,v]=find(py);
mu_y=sum((j-1).*v);
sigma_y=sum((((j-1)-mu_y).^2).*v);
h_y=sum(sum(-((full(spfun(@log2,py))).*py)));
temp2=repmat(py,[n 1]);

[i,j,v]=find(foo);
correlation=(sum(((i-1)-mu_x).*((j-1)-mu_y).*v))/sqrt(sigma_x*sigma_y);

% Sum average, variance and entropy:
[i,j,v]=find(foo);
k=i+j-1;
pk_sum=zeros(max(k),1);
for l=min(k):max(k)
pk_sum(l)=sum(v(find(k==l)));
end

[i,j,v]=find(pk_sum);
sum_avg=sum((i-1).*v);

sum_var=sum((((i-1)-sum_avg).^2).*v);
sum_entropy=sum(-((full(spfun(@log2,pk_sum))).*pk_sum));
F=[entropy,correlation,inverse_diff,sum_avg,sum_var,sum_entropy];
