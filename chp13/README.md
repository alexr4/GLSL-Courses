# Chapter 13: Adding randomness : noise

* Chaos is quite great but nature is not only made by random and sometime you just want some random values which are smoothed from one to the other. This kind of random is called Noise.
* We can see a lot of noise shape in nature such as marble texture, zebra pattern, cloud or water...
* The first noise algorithm has been bring to us by Ken Perlin in 1980 when he was working on the VFX for the movie Tron.
* The main idea is to get the smooth value between two neighboring random value
* We start by scaling the st.x value by an increment in order to have a greater range.
* Then we define two value, the fractional part of x and its integer value;
* We can now generate the two neighboring random value, one from x and one from x+1
* At last we interpolate between the two value with the fractionnal part of x.

## 2D noise
* This example is juste a simple way to implement a noise function but you will find more complexe one only.
* Let's try with the simple 2D noise function from Morgan McGuire. We will not convert how it's work but basically the idea is to interpolate between the random value of the four corners of a square
* You can now try to get a noise value from a 2D vector. You notice the nice smooth pattern.
* Of course the more you increment the range of the 2D vector used as the noise argument the more chaos you will get.
* Like the random you can try this function with your pattern as grey value, size or shape.
* In the grey example you will notice how the cell seems to be less random compare to its neighbors
* In the Grid80 you notice the nice organic hole into the pattern provide by the noise function
* You can even try to use a noise per cell in order to generate a nice flow field lookalike rotating pattern
