
# GEN 711/811 Final Project

## Background
The dataset we used came from a [study](https://www.scirp.org/journal/paperinformation?paperid=125865) that sequenced eDNA for cyanobacteria from water samples in various locations around Martha’s Vineyard. In the data set, samples are classified as either WLW (whole lake water- all cyanobacteria), <5 µm (small/picocyanobacteria), or BFC (bloom-forming cyanobacteria). Using this data set, our research goal was to take the raw FASTQ reads and utilize QIIME2 as a tool to assign taxonomy, analyze diversity, and generate plots to aid in the analysis of this metabarcoding data.

[Final presentation](https://universitysystemnh-my.sharepoint.com/:p:/g/personal/mwf1022_usnh_edu/EcGi8z1OCzlBg5PwxgUWs3ABKbTQw1V44n5HX9-MSvKuEw?e=TBOw8A)

[Code for the project](GEN_711_811_FinalProj.sh)

Group Members: Amanda Bozzi, Mike Desisto, Mike Foley

## Methods 
All code for this project was recorded in the .sh file in this repository

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

### Phylogenetic Tree

#### phylogeny align-to-tree-mafft-fasttree
Generated a rooted phylogenetic tree as a .qza file from aligned sequences using MAFFT for alignment and FastTree for tree inference. 

#### empress community-plot
Added metadata and taxonomic data to tree. Output was viewable file (.qzv). (Fig. 3)

### Diversity Analysis

#### diversity core-metrics-phylogenetic
Used the filtered feature data, rooted phylogenetic tree, and metadata to compute diversity metrics and generate diversity analyses. The Emperor tool was used to visualize data as PCoA plots (including Bray Curtis dissimilarity, Jaccard dissimilarity, and weighted/unweighted UniFrac). 

#### feature-table relative-frequency
Generated a feature table containing relative abundance values based on calculations regarding the relative frequencies of features within each sample using raw abundance data. 

#### diversity pcoa-biplot
Generated a PCoA biplot of Unweighted UniFrac data (similarity metric). 

#### emperor biplot
Visualized the PCoA biplot using the Emperor visualization tool. (Fig. 4)

#### diversity alpha-group-significance
Generated box and whisker plots showing different variables in the study (sample, collection site, lake, etc.) plotted against Shannon entropy as a metric of diversity. (Fig. 5)

#### diversity beta-group-significance
Generated boxplots showing the beta diversity of different sampling methods. (Fig. 6)

## Findings
All .qzv files produced during this project (except for two that exceeded 25mb) are located in a separate folder in this repository

<img width="1701" alt="Demux summarize quality score plot" src="https://github.com/mfoley02/gen_proj/assets/157628373/8b83bc9d-24a5-4b33-92c4-878296e7a6d6">

#### Figure 1: Demultiplexed sequences summary 
This figure displays the base quality scores of the raw reads once the tails and primers/adapters have been trimmed.  Overall, the reads are of a high quality reads with 11 lower quality reads, particularly towards the end of the sequences.  This is likely due to the generally worse quality of the ends of reverse pair end reads.

<img width="698" alt="Screenshot 2024-05-10 at 1 15 31 PM" src="https://github.com/mfoley02/gen_proj/assets/157628373/46c4a715-9ea3-402f-bb76-6c0455d760f8">

#### Figure 2: Filtered feature table (frequency per sample)
This figure organizes data regarding unique genetic features are identified using the silva138_AB_V4 classifier.  The features occurring multiple times each sample in the majority of samples are likely highly conserved/repetitive regions.  Species level taxonomic assignment will be more likely to come from features occurring in lower sample numbers and in lower frequencies.

<img width="624" alt="Screenshot 2024-05-10 at 12 22 05 PM" src="https://github.com/mfoley02/gen_proj/assets/157628373/976a22a7-a9cd-464c-97d0-6fcc1b305086">

#### Figure 3: Phylogenetic Tree
Phylogenetic tree sheared to just show cyanobacteria.  Inner bar graph desplays sample lake and outer bar graph displays sample method (picocyanobacteria, bloom forming, or whole water).  Two observations were that Lower Mill pond was the site of most bloom forming Nostocales class cyanobacteria, as well as a large chunk of Synechococcales class picocyanobacteria.

<img width="1245" alt="Screenshot 2024-05-10 at 1 49 25 PM" src="https://github.com/mfoley02/gen_proj/assets/157628373/699b148f-49d8-4bb1-a9e6-b47bf1858424">

#### Figure 4: PcoA Biplot of Unweighted Unifrac Data
PCA uses unsupervised machine learning to cluster the read samples based on data from the feature table and phylogenetic tree.  Coloring of each point on the PCoA is based on different sample sites. Lagoon Pond had the most distinct cyanobacterial profile cluster (bottom right of the figure), while many of the other sample sites shared similar profiles (top and bottom left of the figure). 

<img width="1092" alt="Screenshot 2024-05-10 at 12 44 14 PM" src="https://github.com/mfoley02/gen_proj/assets/157628373/be5a2348-3919-4630-af0b-ba351d725c93">

#### Figure 5: Alpha Diversity Boxplot
Alpha diversity measures the amont and range of cyanobacteria taxa found in the samples and is displayed as a box plot of each sample site. Seng Konkaton has the widest range of alpha diversity. James Pond and Tahoe Pier have the lowest.  The remaining don't have any usually significant difference in the number or range of organismal diversity.

<img width="601" alt="Screenshot 2024-05-10 at 8 23 33 PM" src="https://github.com/mfoley02/gen_proj/assets/157628373/9cd3e8e2-c544-4549-b6c8-0daa96541bdf">

#### Figure 6: Beta Diversity Boxplots
Beta diversity measures the vartiation between the number of unique cyanobacteria taxa shown between each sample method (picocyanobacteria, bloom forming, or whole water).  There appears to be no significant difference in the beta diversity of the different sampling methods.  However, BFC appears to have a tighter distribution when compared to itself over other sampling methods.

## Conclusions
QIIME2 is an extremely powerful tool to analyze eDNA sequencing data and makes it easier to understand the diversity of organisms in different environmental samples. QIIME 2 forums were helpful for troubleshooting commands and determining useful tools for our project. Most issues we ran into were  relatively simple to fix(bad file path, etc.). A few interesting takeaways were that Lower mill pond was the site of most bloom forming Nostocales class cyanobacteria, as well as a large chunk of Synechococcales class picocyanobacteria.  Additionally, PCA indicated that Lagoon Pond had the most distinct cyanobacterial profile cluster, while many of the other sample sites shared similar profiles.  Finally, alpha diversity box plots indicated that Seng Konkaton has the widest range of alpha diversity, while James Pond and Tahoe Pier have the lowest.

## Sources
<img width="1485" alt="Screenshot 2024-05-10 at 9 00 09 PM" src="https://github.com/mfoley02/gen_proj/assets/157628373/41edcafe-2ad7-475d-99bd-81f7cc5b7571">



