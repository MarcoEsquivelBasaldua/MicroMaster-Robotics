# Image Approximation

## Visualize 2D Fourier Transform
One of the advantages of computing the spectrum of a signal is that we can eliminate some of the fequencies to approximate and compress it (fewer Fourier coefficients are needed after setting some of them to zero). Here we select the frequencies with linear approximation, i.e., applying a low-pass filter to get rid of the high frequencies.<br />

The function *fft_vis* computes the Fourier transform of an image using the Matlab function **fft2**. For a meaningful visualization, we apply **fftshift** to the output of **fft2** so that the DC-component lies in the middle of the image. To superimpose the real and imagynary parts, we use the **abs** function to the trasnformation. Before displaying the output, it is useful to add 1 to the abs and take the **log**.

### Input format
- I: The input image

### Output format
- F: 2D Fourier transform in a form amenable to visualization


## Compression
A way to approximate an image is to apply a low-pass filter to the spectrum and keep only frequencies within the square $\Pi(M)= \{(m_1, m_2)| -\sqrt{M}/2\leq m_1, m_2\leq \sqrt{M}/2\}$, where $M$ is the number of coefficients to keep. This is called a linear approximation. The function *compress* applies $\Pi(M)$ to the spectrum image and return the result.

### Input format
- I: The input image.
- M_root: Square root of the number of coefficients we will keep.

### Output format
- Fcomp: The compressed version of the image.


## Decompression
To recover the approximation of the image from the compressed $M$ coefficients, we need to apply the inverse FFT, redo the shifting of the spectrum and finally take the real part of the transformation. We can notice how the quality of the image degrades as we decrese the coefficients we store with the function *decompress* .

### Input format
- F: The compressed version of the image.

### Output format
- Id: The approximated image.


## Signal-to-Noise Ratio
The quality of the approximation can be quantitatively measured by computing the Signal-to-Noise ratio (SNR) in decibels (dB):
$$
SNR(f,f_{approx}) = -20\ log_{10}\left(\fracc{||f-f_{approx}||}{||f||}\right)
$$
The norm is the Frobenius norm ($l2$ norm of the Matrix reshaped as a column vector). The function *compute_snr* computes the SNR of a given image and its approximation.

### Input format
- I: The original image.
- Id: The approximated (noisy) image.

### Output format
- snr: Signal-to-Noise Ratio


## Compression Ratio
The compression ratio is defined as $CR = \fracc{Uncompressed\ Size}{Compressed\ Size}$. Here we use the number of coefficients we need to store for each of the two images to approximate their size. So, if the original image has $r$ rows and $c$ columns while our approximation stores only $M$ coefficients, the ratio is defined as $CR = \fracc{rc}{M}$. This is done with the function *compute_cr*.

### Input format
- I: The original image.
- M: The number of coefficients for the compressed image.

### Output format
- cr: The compression ratio.
