#! /bin/bash

mdkir ~/gen_proj

cd ~/gen_proj

cp -R /tmp/gen711_project_data/eDNA-fqs/cyano .

conda activate qiime2-2022.8

qiime tools import \
   --type "SampleData[PairedEndSequencesWithQuality]"  \
   --input-format CasavaOneEightSingleLanePerSampleDirFmt \
   --input-path ~/gen_proj/cyano/fastqs \
   --output-path ~/gen_proj/cyano_raw_reads.qza

mkdir cutadapt_output

qiime cutadapt trim-paired \
    --i-demultiplexed-sequences ~/gen_proj/cyano_raw_reads.qza \
    --p-cores 4 \
    --p-front-f GTGYCAGCMGCCGCGGTAA \
    --p-front-r CCGYCAATTYMTTTRAGTTT \
    --p-discard-untrimmed \
    --p-match-adapter-wildcards \
    --verbose \
    --o-trimmed-sequences cutadapt_output/raw_reads_no_primers.qza

cd cutadapt_output

mkdir demux_summarize

qiime demux summarize \
--i-data raw_reads_no_primers.qza \
--o-visualization  demux_summarize/demux_summarize_output.qzv

mkdir denoise_output

qiime dada2 denoise-paired \
    --i-demultiplexed-seqs raw_reads_no_primers.qza  \
    --p-trunc-len-f 0 \
    --p-trunc-len-r 0 \
    --p-trim-left-f 0 \
    --p-trim-left-r 0 \
    --p-n-threads 4 \
    --o-denoising-stats denoise_output/denoising-stats.qza \
    --o-table denoise_output/feature_table.qza \
    --o-representative-sequences denoise_output/rep-seqs.qza

mkdir -p denoise_output/output_visualization

qiime metadata tabulate \
    --m-input-file denoise_output/denoising-stats.qza \
    --o-visualization denoise_output/output_visualization/denoising-stats.qzv

qiime feature-table tabulate-seqs \
        --i-data denoise_output/rep-seqs.qza \
        --o-visualization denoise_output/output_visualization/rep-seqs.qzv


qiime feature-classifier classify-sklearn \
--i-classifier /tmp/silva138_AB_V4_classifier.qza \
--i-reads /home/users/mjd1127/gen_proj/cutadapt_output/denoise_output/rep-seqs.qza \
--o-classification /home/users/mjd1127/gen_proj/cutadapt_output/denoise_output/classify_output.qza


qiime feature-classifier classify-sklearn \
  --i-classifier /tmp/gen711_project_data/eDNA-fqs/cyano/ref-database/classifier_16S_V4-V5.qza \
  --i-reads /home/users/mjd1127/gen_proj/cutadapt_output/denoise_output/rep-seqs.qza \
  --o-classification /home/users/mjd1127/gen_proj/cutadapt_output/denoise_output/taxonomy.qza

-----------------------------------------------------------------------------------------------------

### Barplot 
qiime taxa barplot \
     --i-table /home/users/mjd1127/gen_proj/cutadapt_output/denoise_output/feature_table.qza \
     --i-taxonomy /home/users/mjd1127/gen_proj/cutadapt_output/denoise_output/taxonomy.qza \
     --o-visualization /home/users/mjd1127/gen_proj/cutadapt_output/denoise_output/my-barplot.qzv


qiime feature-table filter-samples \
  --i-table /home/users/mjd1127/gen_proj/cutadapt_output/denoise_output/feature_table.qza \
  --m-metadata-file /tmp/gen711_project_data/eDNA-fqs/cyano/cyano-metadata_salinity.tsv \
  --o-filtered-table feature_table_filtered.qza

qiime taxa barplot \
     --i-table /home/users/mjd1127/gen_proj/cutadapt_output/denoise_output/feature_table.qza \
     --m-metadata-file /tmp/gen711_project_data/eDNA-fqs/cyano/cyano-metadata_salinity.tsv \
     --i-taxonomy /home/users/mjd1127/gen_proj/cutadapt_output/denoise_output/taxonomy.qza \
     --o-visualization filtered-barplot.qzv


 
