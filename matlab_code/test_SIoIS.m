close all;
clear all;

img = imread('image_mask.bmp');
if ~ismatrix(img)
    img = rgb2gray(img);
end

figure;imshow(img);title('img');

image = im2double(img) / 255.0;

res = SIoIS(image);
res = SIoIS(res);
res = SIoIS(res);

figure;imshow(res, []);title('res');