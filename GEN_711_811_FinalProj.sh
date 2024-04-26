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
