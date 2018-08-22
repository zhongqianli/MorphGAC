function [ output ] = mgac( gI, u, smoothing, threshold, balloon )
%MGAC 此处显示有关此函数的摘要
%   此处显示详细说明

[derivative_gI_X, derivative_gI_Y] = gradient(gI);
theta = threshold;
v =  balloon;
threshold_mask_v = gI > (theta / abs(v));
% imshow(threshold_mask_v);

% % P = cell(2);
% % P{1,1} = [1 0 0; 0 1 0; 0 0 1];
% % P{1,2} = [0 1 0; 0 1 0; 0 1 0];
% % P{2,1} = [0 0 1; 0 1 0; 1 0 0];
% % P{2,2} = [0 0 0; 1 1 1; 0 0 0];
% 

res = u;

SE = strel('rectangle',[3 3]);
if v > 0
    aux = imdilate(u, SE);
elseif v < 0
    aux = imerode(u, SE);
end

if v ~= 0
    res(threshold_mask_v) = aux(threshold_mask_v);
%     res = aux;
end

% figure;imshow(res);title('res test');

% aux = zeros(size(res), 'like', res);
[derivative_res_X, derivative_res_Y] = gradient(res);
aux_X = derivative_gI_X .* derivative_res_X;
aux_Y = derivative_gI_Y .* derivative_res_Y;
aux = aux_X + aux_Y;
res(aux>0) = 1;
res(aux<0) = 0;

output = res;
end

