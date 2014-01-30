Image-Optimizer
===============

A quite simple bash script designed to resize PNGs and JPEGs, convert them to progressive JPEGs and losslessly compress them. Resizing is set by default to 1000x600 pixels (can be changed at line 20 in the script).

Usage
=====

The script will optimize all PNG and JPEG images in the current directory.

./optimizeimages [options ...]

Options are:

- `--overwrite` to overwrite the original images (without this, the optimized images are put in a folder called 'optimized', created in the currect directory)
- `--no-resize` to tell the script not to resize the images
- `--help` to display the help screen
