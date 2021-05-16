clear all;
clc;
im1=imread('TopImg0000.bmp');
figure(1)
imshow(im1)        % showing oroginal
thresholdValue = 10;  % treshold in 'brightness' of picture
binaryImage = im1 > thresholdValue; 
binaryImage = imfill(binaryImage, 'holes'); 
figure(2)
imshow(binaryImage)  % showing binary image 
labeledImage = bwlabel(binaryImage, 8);
Measurements = regionprops(labeledImage, im1, 'all');  % cutting the part of image
thisBoundingBox = Measurements(1).BoundingBox;  % getting list of pixels of part
subImage = imcrop(im1, thisBoundingBox);  % creating the part from that pixels
figure(3)
imshow(subImage);   % showing the segmanted part
% second part
im1=subImage;       % starting from segmented as initial image
mask = false(size(im1));  % trying to approximatley find area of label
mask(600:end-150,900:end-250) = true;
%  using graydiffweight function to cut the part with label
W = graydiffweight(im1, mask, 'GrayDifferenceCutoff', 25);
thresh = 0.01;
[BW, D] = imsegfmm(W, mask, thresh);  % cutting tha label
labeledImage = bwlabel(BW, 8);
Measurements = regionprops(labeledImage, im1, 'all');
thisBoundingBox = Measurements(1).BoundingBox;  
subImage = imcrop(im1, thisBoundingBox);  % croping the label
figure(4)  % showing the label
imshow(subImage);
