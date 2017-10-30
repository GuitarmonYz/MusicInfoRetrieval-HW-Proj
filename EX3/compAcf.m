function r = compAcf (inputVector, bIsNormalized)

    % set uninitialized input arguments
    if (nargin < 2)
        bIsNormalized = true;
    end
    
    % check input dimension
    [m,n] = size(inputVector);
    if ((m<=1 && n<=1) || (m>1 && n>1))
        error('illegal input vector');
    end

    % allocate memory for result
    r = zeros(2*length(inputVector)-1,1);
    len = length(inputVector);
    inputVector = [inputVector, zeros(1, len-1)];
    
    % compute acf
    % enter code here
    r = ifft(fft(inputVector) .* conj(fft(inputVector)));
    r = r(1:len);
    % normalize result
    if (bIsNormalized)
        r = r./max(r);
        % enter code here
    end
end