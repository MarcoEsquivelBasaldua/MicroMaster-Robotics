# Homography Estimation

When you take a panoramic image with your camera, you end up with a sequence of images of the same scene taken from different perspective. Each image has slightly difference appareances but in many cases it is possible to transform them so they can be combined into a single image or panarama. In this lab, an  automatic homography estimation between two images is implemented.


## Homography Computation
In this section the homography between two images when correspondances are known is computed using the function *compute_homography*.

### Input format
- p1: Correspondances locations of image 1
- p2: Correspondances locations of image 2
### Output format
- H: Output homography


## Correspondance Estimation
Estimate correspondances between two sets of Harris Corners using Nearest Neighbor and the ratio test using the function *match_features*.
### Input format
- f1,f2: [ number of points x number of features ]
### Output format
- match, match_fwd, match_bkwd: [ indices in f1, corresponding indices in f2 ]


## RANSAC
RANSAC is used to find the best homography estimate drom the estimated correspondances
### Input format
- p1: Correspondances locations of image 1
- p2: Correspondances locations of image 2
### Output format
- best_H: Best output homography
