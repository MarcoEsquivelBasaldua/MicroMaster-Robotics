# Laplacian Blending

The Laplacian pyramid algorithm for blending is used on the iconic example from the paper of Burt and Anderson. Below, you can look the two images we want to blend.<br />
![apple](apple.png)  ![orange](orange.png)<br />

If we crop the left part of an image and the right part of the other and attempt to merge them we will get a mediocre result:<br />
![img1](img1.png)<br />
This implementation applies a multi-scale blending based on Laplacian pyramids, that will give more realistic outputs, like the one below:<br />
![img2](img2.png)

## Reduce and Expand Operations
The basic building blocks used by the Gaussian and Laplacian pyramid are the *reduce* and *expand* operations.<br />
For the *reduce* function a filter to the image is applied with a Gaussian kernel of size $5\times 5$ and then the image is subsampled by a factor of 2.

### Input format
- I: The input image.

### Output format
- g: The image after Gaussian blurring and subsampling

For the *expand* function an image that has twice the size of the original image is created and every second row and column of this new image is filled with the rows and columns of the original image, then a filter with the same Gaussian kernel is applied to the new image.

### Input format
- I: The input image.

### Output format
- g: The image after the expand operation

