# Optical Flow

The perception of motion and the subsequent formation of an interpretation guides our lives. The ability to determine if an object is moving, judge its speed and direction, and react accordingly is fundamental to our survival. The apparent motion which guides our actions is called optical flow. Since optical flow is determined by time varying image intensities, it is not always consistent with the true motion of objects and surfaces called the motion field. motion estimation also plays a critical role in a variety of computer vision tasks. While applications such as object tracking, scene reconstruction and image aligment heve very different objectives, they all rely to some degree on low-level motion cues.


## Image Gradients
Function *grad2d*.
### Input format
- img: The input image.
### Output format
- I_x: The image gradients in the x direction.
- I_y: The image gradients in the y direction.

## Estimate Displacement
In this section, the displacement of a windowed region is estimated by computing the least squares solution over several pixels in the function *estimate_displacement*.
### Input format
- Ix, Iy, It: m x m matrices, gradient in the x, y and t directions
- Note: gradient in the t direction is the image difference
### Output format
- d: least squares solution

## Estimate Flow
Combining the previous solutions, estimation of the optical flow estimate over the entire image is performed with the function *estimate_flow*.
### Input format
- I1, I2: nxm sequential frames of a video
- wsize: (wsize*2 + 1)^2 is the size of the neighborhood used for displacement estimation
### Output format
- u,v: nxm flow estimates in the x and y directions respectively
