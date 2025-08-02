# image-post-processing-shader-minecraft
Uses Minecraft 1.21.4 as a base to run the shaders.

I wanted to make this to learn to be able to practice writing GLSL, practice creating Minecraft shaders, and test out different post-processing filters/effects on a given image (the image I used can be found as `assets/minecraft/textures/effect/3.png`).

---

## Build/Usage Instructions

If you downloaded the resource pack from [releases](https://github.com/JKSquires/image-post-processing-shader-minecraft/releases), follow steps 2 to 6 under 'Resource Pack ZIP'.

There are a few ways to do "build" a Minecraft resource pack, and here are two:

### Resource Pack Directory

1. Copy all everything in the `src` directory into an empty directory in the `.minecraft/resourcepacks` directory (if you don't know where that is, [see this](https://minecraft.wiki/w/.minecraft))
2. In Minecraft 1.21.4, go to the Resource Packs menu in the Options menu.
3. Load the resource pack that has the same name as the directory you copied everything into.
4. Make sure the Graphics setting (under Video Settings in the Options menu) is set to *Fabulous!*.
5. Open a Minecraft world and the images should render on the screen.

### Resource Pack ZIP

1. Put everything in the `src` directory into a ZIP archive.
2. Move the ZIP archive into the the `.minecraft/resourcepacks` directory (if you don't know where that is, [see this](https://minecraft.wiki/w/.minecraft))
3. In Minecraft 1.21.4, go to the Resource Packs menu in the Options menu.
4. Load the resource pack that has the same name (including the file extension) as the ZIP archive you put everything into.
5. Make sure the Graphics setting (under Video Settings in the Options menu) is set to *Fabulous!*.
6. Open a Minecraft world and the images should render on the screen.
