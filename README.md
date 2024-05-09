
# GEN 711/811 Final Project

## Background
The dataset we used came from a [study](https://www.scirp.org/journal/paperinformation?paperid=125865) that sequenced eDNA for cyanobacteria from water samples in various locations around Martha’s Vineyard. In the data set, samples are classified as either WLW (whole lake water- all cyanobacteria), <5 µm (small/picocyanobacteria), or BFC (bloom-forming cyanobacteria). Using this data set, our research goal was to take the raw FASTQ reads and utilize QIIME2 as a tool to assign taxonomy, analyze diversity, and generate plots to aid in the analysis of this metabarcoding data.

Final presentation **include link when done! 

[Code for the project](GEN_711_811_FinalProj.sh)

Group Members: Amanda Bozzi, Mike Desisto, Mike Foley

## Methods 

### Importing data

#### mkdir
A directory was made to store the files for this project. This was called “gen_proj”, and all of the provided cyano data was copied into this directory.

#### activate qiime2-2022.8
QIIME2 was activated on RON so that QIIME commands could be used. 

#### tools import
The FASTQ files provided in the cyano dataset were then imported into a single QIIME file with a .qza extension.

#### cutadapt trim-paired
The primer and adapters of each pair of sequences were removed. Primer sequences specific to the cyano dataset were provided and specified in this command. 

#### demux summarize
Provided information summarizing demultiplexed sequence data; this included sequence counts (whole dataset and per sample), frequency histograms, and quality plots. (Fig. 1)

### Denoising

#### dada2 denoise-single
Sequences were denoised using QIIME to address potential sequencing errors. Trunclenf and trunclenr values specific to the cyano dataset were provided and used during this denoising step. 

#### metadata tabulate
Generated an output table of statistics regarding filtered and denoised reads; this included information such as the number of reads per sample, denoised sequences, merged sequences, and non-chimeric sequences. 

#### feature-table tabulate-seqs
A feature table was generated as a .qzv file to display these results regarding all features and their respective sequences/lengths. Sequence length statistics (i.e. mean, range, standard deviation) were also generated. 

### Taxonomy Assignment and Classification

#### feature-classifier classify-sklearn
Used a provided classifier specific to the 16s coding region to assign taxonomic information (silva138_AB_V4_classifier.qza). 

#### feature-table summarize
Converted the generated feature table from .qza to .qzv file format so that it could be visualized using QIIME2. The output .qzv file displayed barplots summarizing data regarding the frequency per sample and frequency per feature. (Fig. 2)

#### feature-table filter-samples
Generated a filtered feature table using the initial feature table and metadata as input data. 

#### taxa barplot
Used the filtered feature data to generate a barplot as a means of visualizing taxonomy. Verified that sample identity was 100% bacteria.

### Diversity Analysis and Phylogenetic Placement of ASVs

#### phylogeny align-to-tree-mafft-fasttree
Generated a rooted phylogenetic tree as a .qza file from aligned sequences using MAFFT for alignment and FastTree for tree inference. 

#### diversity core-metrics-phylogenetic
Used the filtered feature data, rooted phylogenetic tree, and metadata to compute diversity metrics and generate diversity analyses. Used the Emperor tool to visualize data (including Bray Curtis dissimilarity, Jaccard dissimilarity, and weighted/unweighted UniFrac). 

#### feature-table relative-frequency
explain

#### diversity pcoa-biplot
explain

#### emperor biplot
explain

#### diversity alpha-group-significance
explain

#### diversity beta-group-significance
explain

## Findings  

Figure 1:

Figure 2:

Figure 3: 

