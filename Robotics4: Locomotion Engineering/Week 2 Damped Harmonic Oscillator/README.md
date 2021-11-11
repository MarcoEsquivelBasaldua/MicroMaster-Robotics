# Damped Harmonic Oscillator

## The Damped Harmonic Oscillator
The damped harmonic oscillator is one of the basic building block of more complicated systems, especially within the context of legged robotics. The script *dampedHarmonicOscillator.m* simulates this system.

## A different Spring Law
Until now we have assumed that springs are linear; that their force is proportional to the displacement from their rest length. Since we have the opportunity to use a numeric solver, we simulate a stiffening spring; a spring that increases its force proportional to some higher order power of the displacement of the rest length, in this case, the cube of that displacement. Use the sript *dampedNonlinearOscillator.m* to run this oscillator.

## The Duffing Oscillator
Lets look at a famous example of a forced damped harmonic oscillator: The Diffing Oscillator, expressed by:
$$
	\ddot{x} + \delta \dot{x} + \alpha x + \beta x^3 = \gamma cos(\omega t)
$$

This equation bears a lot of resemblance to the DHO we have looked at thus far, except that there is a forcing term which can be seen as a control input on the right hand side, and a non-linearity on the left hand side.<br />

The Duffing oscillator exhibits some interesting behaviors -whe tuned correctly we see the appearance of subharmonics and period-doubling bifurcation-. This oscillator can be simulated with the *duffing.m* script.
