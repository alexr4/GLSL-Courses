# Chapter 12 : Adding randomness

* Randomn is one of the many tools of the creative coder in order to bring variation and chaos into its creation. But how can we have randomness in a world governe by mathematical operation.
* Programmation has no random and each language and framework respond to that by providing a pseudo-random algorithm which can return a pseudo-random number.
* In GLSL we do not have any of this algorithm has a built-in function. We need to create our own. Luckily it's not that hard.


# Generate a pseudo random number
* We start with a simple function with two arguments : a value x and an multiplier inc
* Let's make this function return us the fractional part of sin(x) * inc
* By using our function we see the more we increase the inc value, the more our result seems to be random. The wave of the sin is so small, it's seems to return a random value. This the base of our random function.
* Let's rewrite it with as follow. The new increment value is some quite a base value used in many GLSL program. You can retreive it on many shader. So let's keep that as a convention to our random function.
* Our function seems to work for a one dimension value but how can we get a 2 dimension random value. We will simply update our function as follow
* Notice that we now use a 2d vector as an input. In order to get a single value for our sin we will take the doit product of this vector by another constant vector which is large enough to get ride of the repetition into our result

# Using randomn
* Now we can use our new random function in order to add randomness into our Pattern
* Let's start with woemthing simple, by creating a grid of 10*10 cells.
* We can use the index vector to pass into our random function in order to get a random value which can be used as a grey value
* Another more complexe example is to generate a random speed for each row on a simple rectangulare pattern. This will give us a sensation of speed and motion.
* The last one use the random value on the cezll index in order to define if it's filled with a square, an ellipse or a void.
* Try to tweak the examples and make your own one by creating a simple pattern and use a random value an its movement, size or shape
