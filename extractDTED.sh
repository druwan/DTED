#!/bin/bash

# Extract files into extractedFiles directory, or change accordingly
# for file in tarFiles/*/*; do 
#		mkdir -p $PWD/extractedFiles && tar -xvf ${file} --include '*.dt2' --directory=$PWD/extractedFiles
# done

for country in $PWD/DEM/*; do
	# Check if country terrain is already extracted
	if [ $(find "$country" -mindepth 1 -maxdepth 1 -type -d ! -name "tarFiles" | wc -l) -eq 0 ]; then
		# Extract
		for tarFile in "$country"/tarFiles/*; do
			if [ -f "$tarFile" ]; then
				tar -xvf "$tarFile" -C "$country" --wildcards "*.dt2"
			fi
		done
	else
		echo -en "$country already extracted"
	fi
done

# Create the folder structure and mv the files
for filePath in $PWD/*/Copernicus_DSM_10_*/DEM/*.dt2; do
	# Extract filename and dirname
	# N57...
	dirname=$(basename "$filePath" | awk -F '_' '{split($6, a, "."); print a[1]}')
	# E001...
	filename=$(basename "$filePath" | awk -F '_' '{split($4, a, "."); print a[1]}')
	# Create Dir if not exist
	mkdir -p "$PWD/terrain/dted_copernicus/dted_copernicus2/dted/${dirname}"
	# Copy & rename the file
        cp "$filePath" $PWD/terrain/dted_copernicus/dted_copernicus2/dted/${dirname}/${filename}.dt2
done

# TODO: Create the tarFiles Folder struct. Sweden_ -> Remove "_", mv contents into tarFiles
