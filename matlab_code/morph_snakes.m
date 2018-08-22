close all;
clear all;

img = imread('image.bmp');
if ~ismatrix(img)
    img = rgb2gray(img);
end

% imshow(img);title('img');

image = im2double(img) / 255.0;

% median filter
image = medfilt2(image, [13 13]);
% figure;imshow(image*255);title('median blur image');

% g(I)
alpha = 20000.0;
sigma = 4.0;

% first step
gI = gborders(image, alpha, sigma);

% gI = (gI > 0.35);

% figure;imshow(gI);title('gI');

% MorphGAC
mask = imread('image_mask.bmp');
if ~ismatrix(mask)
    mask = rgb2gray(mask);
end

result_dir = 'result/';

initial_contour = edge(mask, 'sobel');
initial_contour = ~initial_contour;
% figure(2);imshow(double(img) .* double(initial_contour) / 255);
% pause(1);


u = im2double(mask);

result = edge(mask, 'sobel');
result = ~result;
output_result = im2uint8(double(img).*double(result)/ 255);
imwrite(output_result ,'result/0.jpg');

smoothing = 1;
threshold = 0.4;
balloon = 1;
num_iters = 80;



for i = 1:num_iters
    % second step
    res = mgac(gI, u, smoothing, threshold, balloon);
    
    % third step
    res = im2uint8(res);
%     res = SIoIS(res);
    
    u = im2double(res);
    
%     figure(1);imshow(u);
    
    result = edge(res, 'sobel');
    result = ~result;
    figure(2);imshow(double(img).*double(result)/ 255);
    
    filename = [result_dir int2str(i) '.jpg' ];
    output_result = im2uint8(double(img).*double(result)/ 255);
    imwrite(output_result ,filename);
end

imwrite(u, 'result.jpg');

pause(1);

% third step
res = SIoIS(u);
% figure(3);imshow(res);

figure;imshow(res);

result = edge(res, 'sobel');
result = ~result;
figure(2);imshow(double(img).*double(result)/ 255);

output_result = im2uint8(double(img).*double(result)/ 255);
imwrite(output_result ,[result_dir int2str(num_iters+1) '.png']);

% pause(10)
% 
% close all;

