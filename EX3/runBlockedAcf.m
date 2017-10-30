function rb = runBlockedAcf(x, blockSize, hopSize)
    
    % check input dimension
    [m,n] = size(x);
    if ((m<=1 && n<=1) || (m>1 && n>1))
        error('illegal input vector');
    end
    
    % set uninitialized input arguments
    if (nargin < 2)
        blockSize = 2048;
    end
    if (nargin < 3)
        hopSize   = 1024;
    end
  
    % block audio signal
    xb = blockAudio(x, blockSize, hopSize);
   
    % allocate memory for result
    rb = zeros(size(xb));     
     
    % compute ACF
    for (k = 1:size(xb,1))
        rb(k,:) = compAcf(xb(k,:), true);
    end
end