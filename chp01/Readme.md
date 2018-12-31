# Chapter 1:  What is a shader and how it works

* A shader is a program; which run on your GPU; and is dedicated to image computation
* Originally used for lighting and shading an 3D scene it's now use in large amount of field such as vfx, post-processing or evene unrelated graphics function
* Witout talking about it's history we can say that shader are widely used in a lot of programs and run on differents plateform such a webGL (obviously), mobile devices, game engine, various framework such as OpenFramework or processing.
* There is two mainly used shader languages : HLSL and GLSL. THere we will use GLSL, which stand for penGL Shading Language and which is a standard for webGL.

## Why shaders are fast
* Shader are made for graphics computation on your GPU, they are dedicated to that and really fast bu why.
* The key is the GPU and the parallel processing.
* If you have ever use any creative library in order to draw something on screen you may have experience this :
* * You want to draw a nice pattern maybe something think a nice reaction diffusion system which give you goosebump when you see this coral like shapes
* * You find a great tutorial online, and even a great paper discribing the algorithm
* * In order to create this pattern you need to run the algorithm on each pixel of your canvas so you set a simple for loop in order to run your algorithm for each one
* * With a small size, it's great... but you like to think big so you setup your canvas with a larger size and then
* * It's really slow...
* The main reason is the CPU where you run your program. It's design to take a task one by one, so it need to finish the computation on one pixel to go to other...and when you have a lot of pixel... it may take a while
* That where GPU comes handy.
* GPU are design to make parallel tasking. Instead of having one core doing all the task (like the CPU), the GPU many core. Even better we can think of it as a device with one core per pixel.
* It's not the proper definition but it give you an idea of its speed if you can have each pixel doing their computation. This is parallel Processing.

# What is fragment shader
* Because of its architecture for parallel processing, sahders follow a specific fixed pipeline.
* You start with a program on CPU side. This program will handle the data (position of object, time, size...)
* You bind your shaders to this program in order to have your CPU communicate with your GPU
* I will not cover the basic fundation of OpenGL but basically you can imagine the pipeline as a way to the GPU to transform mathematical position of shape as an image as view by a camera.
* You can program at differents stage in this pipeline. Here we will focus only on the last part, which is the fragment shader.
* This shader handle the way each fragment (you can think of it as pixel) behave. So yes we basically manipulate pixels

# Presentation
https://en.wikipedia.org/wiki/Shader

https://www.khronos.org/opengl/wiki/Rendering_Pipeline_Overview

https://paper.dropbox.com/doc/What-is-a-Shader-and-how-it-works--AUz~PAwUuRZXQMG~uLXCQMD8AQ-dMGswqA4zGAgcblaqLAqV
