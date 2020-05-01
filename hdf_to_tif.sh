#!/bin/bash
#Set field separator to linefeeds rather than spaces
echo "#!/bin/bash" > batch.sh
chmod +x batch.sh

for FILE in *.hdf
do
  echo $FILE
  LAYERS=$(gdalinfo $FILE | grep SUBDATASET | grep NAME  | sed 's/[A-Z0-9\_]*=//g')
  for LAYER in $LAYERS
  do
    LAYER=$(echo $LAYER | sed 's/  //g')
    NEWFILE=$(echo $LAYER | \
    sed 's/HDF4_EOS:EOS_GRID:"lndsr.//g' | sed 's/.hdf":Grid:/_/g' | sed 's/  //g' | sed 's/"//g' | sed 's/ //g'| sed 's/:/./g').tif
    CMD="gdal_translate -of GTiff '${LAYER}' $NEWFILE"
    echo $CMD >> batch.sh
  done
done

exec ./batch.sh


LAYERS=$(gdalinfo $FILE | grep SUBDATASET | grep NAME  | sed 'HDF4_EOS\:EOS_GRID\:\"lndsr\.//g' | sed '\.hdf\"\:Grid\:/_/g')
