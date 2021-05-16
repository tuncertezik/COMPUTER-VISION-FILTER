clear all;
clc;

% Image
figure(1)
I=imread('Imgtex.tiff');
imagesc(I); colormap gray; title('Original image'); 

% Fourier transform
F = fft2(I);
% Grid of FFT coordinates
[rows, cols] = size(F);
[ux, uy] = meshgrid(([1:cols]-(fix(cols/2)+1))/(cols-mod(cols,2)), ...
    ([1:rows]-(fix(rows/2)+1))/(rows-mod(rows,2)));
% Convert to polar coordinates
th = atan2(uy,ux);
r = sqrt(ux.^2 + uy.^2);
% integrating over ring
sr=0.0;
rmax=max(max(r));
for i=1:rows
    for j=1:cols
        if (4*rmax/4<r(i,j)<4*rmax/4)
        sr=sr+abs(F(i,j));
        end
    end
end
sr
% integration over angle
sth=0.0;
thmax=max(max(th))
for i=1:rows
    for j=1:cols
        if (3*thmax/4<th(i,j)<4*thmax/4)
        sth=sth+abs(F(i,j));
        end
    end
end
sth