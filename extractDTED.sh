#!/bin/bash

# Extract files into extractedFiles directory, or change accordingly
for file in tarFiles/*/*; do 
		mkdir -p extractedFiles && tar -xvf ${file} --include '*.dt2' --directory=extractedFiles
done

# Create the folder structure and mv the files
for filePath in ./extractedFiles/Copernicus_DSM_10_*/DEM/*.dt2; do
		# Extract filename and dirname
		# N57...
		dirname=$(basename "$filePath" | awk -F '_' '{split($4, a, "."); print a[1]}')
		# E001...
		filename=$(basename "$filePath" | awk -F '_' '{split($6, a, "."); print a[1]}')
		# Create Dir if not exist
		mkdir -p "./DTED/${dirname}"
		# Move & rename the file
		cp "$filePath" "./DTED/${dirname}/${filename}.dt2"
done

rm -rf extractedFiles
