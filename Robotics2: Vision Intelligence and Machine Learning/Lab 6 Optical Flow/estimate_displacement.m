[I1, I2, I3, I4] = test_images();
[I_x, I_y] = grad2d(I2);
I_t = I1-I2;

I_x = I_x(:,2:end-1);
I_y = I_y(:,2:end-1);
I_t = I_t(:,2:end-1);

d = estimate_displacement(I_x,I_y,I_t);

function d = estimate_displacement(Ix,Iy,It)
    %% INPUT:
    %% Ix, Iy, It: m x m matrices, gradient in the x, y and t directions
    %% Note: gradient in the t direction is the image difference
    %% OUTPUT:
    %% d: least squares solution
    
    b = [sum(sum(It.*Ix));sum(sum(It.*Iy))];
    % to help mitigate effects of degenerate solutions add eye(2)*eps to the 2x2 matrix A
    A = [sum(sum(Ix.^2)) sum(sum(Ix.*Iy));sum(sum(Ix.*Iy)) sum(sum(Iy.^2))] + eye(2).*eps;
    % use pinv(A)*b to compute the least squares solution
    d = pinv(A)*b;
end

function [I_x,I_y] = grad2d(img)
	%% compute image gradients in the x direction
	%% convolve the image with the derivative filter from the lecture
	%% using the conv2 function and the 'same' option
	dx_filter = [1/2 0 -1/2];
	I_x = conv2(img,dx_filter,'same');

	%% compute image gradients in the y direction
	%% convolve the image with the derivative filter from the lecture
	%% using the conv2 function and the 'same' option
	dy_filter = dx_filter';
	I_y = conv2(img,dy_filter,'same');
end

function smooth = gauss_blur(img)
    %% Since the Gaussian filter is separable in x and y we can perform Gaussian smoothing by
    %% convolving the input image with a 1D Gaussian filter in the x direction then  
    %% convolving the output of this operation with the same 1D Gaussian filter in the y direction.

    %% Gaussian filter of size 5
    %% the Gaussian function is defined f(x) = 1/(sqrt(2*pi)*sigma)*exp(-x.^2/(2*sigma))
    x = linspace(-2,2,5)';
    sigma = 1;
    gauss_filter = 1/(sqrt(2*pi)*sigma)*exp(-x.^2/(2*sigma^2)); 

    %% using the conv2 function and the 'same' option
    %% convolve the input image with the Gaussian filter in the x
    smooth_x = conv2(img,gauss_filter,'same');
    %% convolve smooth_x with the transpose of the Gaussian filter
    smooth = conv2(smooth_x,gauss_filter','same');
end

