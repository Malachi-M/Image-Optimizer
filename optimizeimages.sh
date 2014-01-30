# Options : --overwrite, --no-resize, --help
if [ "$1" == "--help" ] ; then
	echo
	echo "Usage: ./optimizeimages [options ...]"
	echo
	echo "Options:"
	echo -e "  --overwrite\tOverwrite original images"
	echo -e "  --no-resize\tDon't resize images"
	echo -e "  --help\tShows this help screen"
	exit
elif [ "$1" == "--overwrite" ] || [ "$2" == "--overwrite" ] ; then
	dir=""
	jpegdest=""
else
	dir="optimized/"
	jpegdest="--dest=optimized"
	mkdir optimized 2> /dev/null;
fi

maxsize="1000x600"

if [ "$1" == "--no-resize" ] || [ "$2" == "--no-resize" ] ; then
	for f in *;
	do
		if [ "${f: -4}" == ".jpg" ] || [ "${f: -5}" == ".jpeg" ] || [ "${f: -4}" == ".JPG" ] || [ "${f: -5}" == ".JPEG" ] ; then
			jpegoptim --strip-all $jpegdest "$f"
			convert "$f" -density 72 -units PixelsPerInch PJPEG:"$dir$f"
		elif [ "${f: -4}" == ".png" ] || [ "${f: -4}" == ".PNG" ] ; then
			pngout -y "$f" "$dir$f"
		fi
	done
else
	for f in *;
	do
		if [ "${f: -4}" == ".jpg" ] || [ "${f: -5}" == ".jpeg" ] || [ "${f: -4}" == ".JPG" ] || [ "${f: -5}" == ".JPEG" ] ; then
			convert "$f" -resize $maxsize\> -density 72 -units PixelsPerInch PJPEG:"$dir$f"
			jpegoptim --strip-all "$dir$f"
			convert "$f" PJPEG:"$dir$f" # Necessary because jpegoptim has a bug where if you optimize a PJPEG, it is converted to a normal JPEG
		elif [ "${f: -4}" == ".png" ] || [ "${f: -4}" == ".PNG" ] ; then
			convert "$f" -resize $maxsize\> -density 72 -units PixelsPerInch "$dir$f"
			pngout -y "$dir$f"
		fi
	done
fi
