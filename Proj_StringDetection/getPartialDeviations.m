function [ partial_deviation_norm ] = getPartialDeviations(f0, fk, beta)
%% compute deviation of estimated partials with theoretical partials
% f0: numBlocks * 1
% fk: numberOfPartials * numBlocks
% beta: numBlocks * 1
% partial_deviation_norm: numberOfPartials * numBlocks
k = (1:size(fk,1))';
zero_indices = find(~f0);
partial_deviation_norm = zeros(size(fk,1), length(f0)-length(zero_indices));
j = 1;
for i = 1 : length(f0)
    if ~ismember(i, zero_indices)
        fk_theo = k .* sqrt((k.^2)*beta(j) + 1) * f0(i);
        partial_deviation_norm(:,j) = abs((fk_theo - fk(:,i))./fk(:,i));
        j = j+1;
    end
end
end

