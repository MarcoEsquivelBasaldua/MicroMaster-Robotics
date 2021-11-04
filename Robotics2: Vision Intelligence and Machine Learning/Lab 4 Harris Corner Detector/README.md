# Harris Corner Detector

Image features such as Harris Corners can serve as a compact image representation useful for task such as image matching, computing image statistics, 3D model estimation and video tracking.


## Gaussian Smoothing
In this part a filter is applied to a grayscale image using a Gaussian filter by applying the function *gauss_blur*. 

### Input format
- img: The input image.
### Output format
- smooth: The smoothed image.


## Image Gradients
The previous solution is used to compute image gradients using the function *grad2d*.

### Input format
- img: The input image.
### Output format
- I_x: The image gradients in the x direction.
- I_y: The image gradients in the y direction.


## Autocorrelation and Corner score
Using the previous solutions, here we determine the corner score at each pixel location using eigenvalues of the autocorrelation matrix.


## Non-maximum Suppression
Non-maximum suppression and tresholding to isolate the image locations with the strongest corner scores.
