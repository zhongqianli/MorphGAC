function [ gI ] = gborders( image, alpha, sigma )
%GBORDERS g(I)
%   Stopping factors (function g(I) in the paper).

% gaussianblur_image = imgaussfilt(image, sigma);

% gaussian blur
gausFilter = fspecial('gaussian',[20 20],sigma);
gaussianblur_image = imfilter(image,gausFilter,'replicate');

% figure;imshow(gaussianblur_image);title('gaussianblur image');

% image gradient
hy = fspecial('sobel');
hx = hy';
Iy = imfilter(double(gaussianblur_image), hy, 'replicate');
Ix = imfilter(double(gaussianblur_image), hx, 'replicate');

% [Ix, Iy] = gradient(gaussianblur_image);

grad_gaussianblur_image = sqrt(Ix.^2 + Iy.^2);

% grad_gaussianblur_image = grad_gaussianblur_image > 0.1;
% figure;imshow(grad_gaussianblur_image);title('grad gaussianblur image');

gI = 1.0 ./ sqrt(1.0 + alpha.*grad_gaussianblur_image);

end

