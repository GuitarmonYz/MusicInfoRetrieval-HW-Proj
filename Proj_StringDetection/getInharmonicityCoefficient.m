function beta_inharmonicity = getInharmonicityCoefficient( f0, fk )
%% Calculate the inharmonicity coefficient given f0 and fk
% f0: numBlocks*1 scalar in Hz
% fk: numberOfPartials*numBlocks partials of f0 in Hz
% beta_inharmonicity: numBlocks * 1
zero_indices = find(~f0);
beta_inharmonicity = zeros(length(f0), 1);
for i = 1:length(f0)
    if ~ismember(i, zero_indices)
        y = (fk(:,i)/f0(i)).^2;
        x = (1:size(fk,1))';
        beta_inharmonicity(i) = mean((y - x.^2)./(x.^4));
    end
end
beta_inharmonicity(zero_indices) = [];
end

