
# GEN 711/811 Final Project

## Background
The dataset we used came from a study that sequenced eDNA for cyanobacteria from water samples in various locations around Martha’s Vineyard. In the data set, samples are classified as either WLW (whole lake water- all cyanobacteria), <5 µm (small/picocyanobacteria), or BFC (bloom-forming cyanobacteria). Using this data set, our research goal was to take the raw FASTQ reads and utilize QIIME2 as a tool to assign taxonomy, analyze diversity, and generate plots to aid in the analysis of this metabarcoding data.

Final presentation **include link when done! 

[Code for the project](GEN_711_811_FinalProj.sh)

Group Members: Amanda Bozzi, Michael Desisto, Michael Foley

## Methods 

### Importing data

#### mkdir
A directory was made to store the files for this project. This was called “gen_proj”, and all of the provided cyano data was copied into this directory.

#### activate qiime2-2022.8
QIIME2 was activated on RON so that QIIME commands could be used. 

#### tools import
The FASTQ files provided in the cyano dataset were then imported into a single QIIME file with a .qza extension

#### cutadapt
The primer and adapters of each pair of sequences were removed. Primers sequences specific to the cyano dataset were provided and specified in this command. 

### Denoising

#### dada2 denoise-single
Sequences were denoised using QIIME to address potential sequencing errors. Trunclenf and trunclenr values specific to the cyano dataset were provided and used during this denoising step. 

#### metadata tabulate
Generated an output table of statistics regarding filtered and denoised reads. 

#### feature-table tabulate-seqs
A feature table was generated as a .qzv file to display these results regarding all features and their respective sequences/lengths.

### Taxonomy Assignment and Classification

#### feature-classifier classify-sklearn
Used a provided classifier specific to the 16s coding region to assign taxonomic information (silva138_AB_V4_classifier.qza). 

## Conclusions  


