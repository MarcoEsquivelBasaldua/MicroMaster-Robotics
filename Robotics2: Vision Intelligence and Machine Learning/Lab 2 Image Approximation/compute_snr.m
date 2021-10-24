function snr = compute_snr(I, Id)

    % Input:
    % I: the original image
    % Id: the approximated (noisy) image
    % Output:
    % snr: signal-to-noise ratio
    
    % Please follow the instructions in the comments to fill in the missing commands.    

    % 1) Compute the noise image (original image minus the approximation)

    % 2) Compute the Frobenius norm of the noise image
        
    % 3) Compute the Frobenius norm of the original image
    
    % 4) Compute SNR
    snr=-20*log10(norm(I-Id,'fro')/norm(I,'fro'));

end
