
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
Converted the generated feature table from .qza to .qzv file format so that it could be visualized using QIIME2. The output .qzv file displayed barplots summarizing data regarding the frequency per sample and frequency per feature. 

#### feature-table filter-samples
Generated a filtered feature table using the initial feature table and metadata as input data. (Fig. 2)

#### taxa barplot
Used the filtered feature data to generate a barplot as a means of visualizing increasing levels of taxonomy and their distrubution among samples. 

### Diversity Analysis and Phylogenetic Placement of ASVs

#### phylogeny align-to-tree-mafft-fasttree
Generated a rooted phylogenetic tree as a .qza file from aligned sequences using MAFFT for alignment and FastTree for tree inference. 

#### diversity core-metrics-phylogenetic
Used the filtered feature data, rooted phylogenetic tree, and metadata to compute diversity metrics and generate diversity analyses. The Emperor tool was used to visualize data as PCoA plots (including Bray Curtis dissimilarity, Jaccard dissimilarity, and weighted/unweighted UniFrac). 

#### feature-table relative-frequency
Generated a feature table containing relative abundance values based on calculations regarding the relative frequencies of features within each sample using raw abundance data. 

#### diversity pcoa-biplot
Generated a PCoA biplot of Unweighted UniFrac data (similarity metric). 

#### emperor biplot
Visualized the PCoA biplot using the Emperor visualization tool. (Fig. ??)

#### diversity alpha-group-significance
explain

#### diversity beta-group-significance
explain

## Findings  

<img width="1701" alt="Demux summarize quality score plot" src="https://github.com/mfoley02/gen_proj/assets/157628373/8b83bc9d-24a5-4b33-92c4-878296e7a6d6">

#### Figure 1: Demultiplexed sequences summary 

<img width="698" alt="Screenshot 2024-05-10 at 1 15 31 PM" src="https://github.com/mfoley02/gen_proj/assets/157628373/46c4a715-9ea3-402f-bb76-6c0455d760f8">

#### Figure 2: Filtered feature table (frequency per sample)

<img width="624" alt="Screenshot 2024-05-10 at 12 22 05 PM" src="https://github.com/mfoley02/gen_proj/assets/157628373/976a22a7-a9cd-464c-97d0-6fcc1b305086">

#### Figure 3: Phylogenetic Tree

<img width="1092" alt="Screenshot 2024-05-10 at 12 44 14 PM" src="https://github.com/mfoley02/gen_proj/assets/157628373/be5a2348-3919-4630-af0b-ba351d725c93">

#### Figure 4: Alpha Diversity Boxplot

