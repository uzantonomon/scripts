#!/bin/bash
#
# Small script to convert .tif scans to a large .pdf.
# Requires: libtiff-tools, ocrmypdf
# WIP

INPUT="$HOME/tiff/*.tif"
OUTPUT=~/tiff/output

mkdir -p $OUTPUT
for f in $INPUT
do
	echo "Processing $f file..."
	tiff2pdf -o "$f".pdf "$f"
	mv "$f".pdf $OUTPUT
done

cd $OUTPUT || exit
for file in ./*
do
	echo "OCRing $file file..."
	ocrmypdf "$file" "$file"_ocr.pdf
done

for file in ./*
do
	echo "merging pdfs..."
	pdfunite ./*.tif.pdf_ocr.pdf output_pdf.pdf
done
