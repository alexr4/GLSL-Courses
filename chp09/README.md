# Chapter 9: Easing

* During the Basic shaping function courses, we have learned how to created our own shaping functions and I shown you how to create a in out quad easing function.
* Here we will see how to use this function in order to ease your animation.
* When we animated a shape according a the time, we get a linear animation where there is no speed up or slow down during it. It can be great but sometime we want to have a more natural animation like with variation on its speed.
* For this example we will start with a simple rotating square and we will try to make it bounce during the time.
* The first thing we will do is to create a linear animation loop. The main goal here it to have a simple function which will oscillate from 0.0 to 1.0 during a specific time.
* For that we create a function taking one argument, which will be the max time of our desired animation.
* The first thing to do is to take the time given by the u_time variable and get its modulo by the max time. This will return a simple value which loop from 0.0 to the maxTime.
* The second part is to normalize this looping variable in order to get a value from 0.0 to 1.0
* We now have our simple function which return a looping value from 0.0 to 1.0 in a specific amount of time.
* We can now create another function where we will remap this looping value from 0.0 to 1.0 to 0.0, 1.0, 0.0 using the absolute function of this value multiply by 2 minus 1.0.
* So now our value does not only goes from 0.0 to one but we have a perfect loop where the value ping pong between 0.0 and 1.0.
* If we use our value as a scaling multiplier, we will get a bouncing square, but without any easing. Because the time is linear we notice that the square seems to stop and start again at each edge of the value.
* We will try to modulate this looping value by using our inoutquad function we wrote earlier.
* If we pass our new value to our size variable we will notice that square as now a nice speed up and slow down effect on its bounce. 
* You can try to implement differents easing effect with with the link I gave you earlier in order to find the perfect one for your animations
* I've also implemented and in out exponential function you can try to see the difference between two easing functions.
