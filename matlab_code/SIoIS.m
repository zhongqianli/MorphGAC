function [ res ] = SIoIS( u )
%SIoIS smoothing force
%   u: double mask

aux = IS(u);
res = SI(aux);

% aux = SI(u);
% res = IS(aux);

end
