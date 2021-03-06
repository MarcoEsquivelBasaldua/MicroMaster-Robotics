function cr = compute_cr(I,M)

    % Input:
    % I: the original image
    % M: the number of coefficients stored for the compressed image
    % Output:
    % cr: the compression ratio
    
    % Please follow the instructions in the comments to fill in the missing commands.
    
    % 1) Compute the number of coefficients stored for the original image
    S=size(I);
    rc=S(1)*S(2);
    
    % 2) Compute the compression ratio
    cr=rc/M;
    
end
