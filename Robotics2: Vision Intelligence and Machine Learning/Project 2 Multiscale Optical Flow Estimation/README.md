# Multiscale Optical Flow Estimation
In this project, the optical flow solution in lab 6 to a multiscale approach. A multiscale approach allows motions of various magnitudes to be estimated with the same kernel size.

## Image Wrap
The function *wrap_image* wraps an image according to the optical flow estimate.
### Input format
- I: image to be warped
- u,v: x and y displacement
### Output format
- warp: image I deformed by u,v


## Estimate Flow
Incorporation of the image wraping function in a pyramid (multiscale) optical flow estimation function.
