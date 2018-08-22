function [ res ] = IS( u )
%IS �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

P=cell(1, 4);
P{1} = [1 0 0; 0 1 0; 0 0 1];
P{2} = [0 1 0; 0 1 0; 0 1 0];
P{3} = [0 0 1; 0 1 0; 1 0 0];
P{4} = [0 0 0; 1 1 1; 0 0 0];

aux = cell(1,4);

for i = 1:4
    SE = strel('arbitrary',P{i});
    aux{i} = imdilate(u,SE);
end

res = ones(size(u), 'like', u);
for i = 1:4
    res = res .* aux{i};
end

end
