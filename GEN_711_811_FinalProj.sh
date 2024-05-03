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

mkdir classify_rep 

qiime feature-classifier classify-sklearn \
--i-classifier /tmp/silva138_AB_V4_classifier.qza \
--i-reads classify_rep/rep-seqs.qza \
--o-classification classify_rep/

(links to qiime2 -- https://view.qiime2.org/visualization/?src=4cfefed5-918f-4e16-bf8a-83807e68a7bc and https://view.qiime2.org/visualization/?src=e9a28fcb-f8a1-445f-98a0-f2b5510de04f)

silva138_AB_V4_classifier.qza

