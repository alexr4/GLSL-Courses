# Chapter 11: Deforming the grid

* As we saw earlier, creating a grid of shape, a pattern is quite easy.
* We have also seen how to use the index of the cell in order to create variation for each cell
* We will now add more complexity to our pattern by deforming the based space coordinates before creating our grid.

## Deforming the grid
* A nice animation effect is the sin wave effect. In order to do that on our pattern the key is to deform the space coordinate before creating the grid.
* A sin wave is define by two main parameter : an amplitude, which is the size of the wave, and a frequency, which is the number of wave repetition. We will start by creating this two parameter as variable
* The second part is to create the wave effect along the x axis. For that we will simple compute the wave by taking the sin of the st.x multiply by PI multiply by our frequency
* We can now add the multiplication of this result by our amplitude to st.y to get a nice wave effet
* You can add more variation to your pattern by adding complexity to the wave computation or by applying various matrix operation to the space coordinate. For example a simple rotation and an offset on each row.
