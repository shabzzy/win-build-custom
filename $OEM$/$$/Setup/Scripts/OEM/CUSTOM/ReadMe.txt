Edit the files as required, images with your preferred image editor.

Wallpaper.jpg cannot be more than 253kb maximum file size or Windows
Vista/7 will either display a solid color or a default picture. For
Windows 8.x/10 this restriction does not seem to be in effect but to
keep things compatible keep to the 253kb limit.

That is the size on disk, not file size itself Windows is very fussy.

Custom.theme, Custom.reg, OOBE.xml can be edited with notepad to 
edit the display text etc. Careful what you edit!

All image files apart from the Wallpaper.jpg are blank images within
this brand folder. They are the correct dpi/pixel sizes for the 
project/Windows to work with, you just need to replace with your own 
customized images within them making sure they are the SAME 
pixel/resolutions!

You can delete all but the Custom folder if you wish to save space.

You will then need to set the MRPConfig.ini option CustomTheme=Custom 
either manually or via the MRPCreator GUI program.

You can create a folder called Backgrounds within the CUSTOM folder and
place any images you wish to use for a slideshow. If you do create this
folder you can have BackGroundDefault.jpg (same restrictions as for the
Wallpaper.jpg - not greater than 253kb) or not create that file and MRP
will automatically create that file from the Wallpaper.jpg image. Any
other wallpaper 1,2,3... images must have a filename with NO spaces or 
things may not work as expected. They can be of any file size (try to 
keep below 2 mb per file or the desktop slideshow may 'stutter' due to 
extra processing needed). Also they can be any resolution (Horiz x Height pixels).  

For more information about image sizes etc please check the internet.
