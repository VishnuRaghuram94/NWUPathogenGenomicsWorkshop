#!/bin/bash

echo -e "\033[34mThis will create a parent directory called NWU_2025_workshop_data in the current directory and download some example files (~4GB). This may take some time...\033[0m"

# Create directory tree
echo -e "\033[33mCreating directory tree\033[0m"
mkdir -p $(pwd)/NWU_2025_workshop_data/{databases/{AMRFinderPlus,kraken},test_datasets/{fastq_download,salmonella_assemblies,results}} || { echo -e '\033[31mCreating directory tree failed\033[0m' ; exit 1; }

# Download fastq reads from SRA using fasterq dump
echo -e "\033[33mDownloading sample fastq reads\033[0m"
fasterq-dump SRR32528508 -O $(pwd)/NWU_2025_workshop_data/test_datasets/fastq_download/ || { echo -e '\033[31mDownloading fastq reads failed\033[0m' ; exit 1; }

# Download salmonella assemblies for GCA_049744075.1
echo -e "\033[33mDownload and extract sample assembly and annotations\033[0m"
datasets download genome accession GCA_049744075.1 --filename GCA_049744075.1.zip --include cds,genome,protein,gbff,gff3 || { echo -e '\033[31mDownloading failed\033[0m' ; exit 1; }
unzip GCA_049744075.1.zip || { echo -e '\033[31mExtracting failed\033[0m' ; exit 1; }
mv $(pwd)/ncbi_dataset/data/GCA_049744075.1 $(pwd)/NWU_2025_workshop_data/test_datasets/
rm -r GCA_049744075.1.zip ncbi_dataset README.md md5sum.txt

# Download assemblies from one bioproject
ncbi-genome-download  -s genbank -A GCA_049745255.1,GCA_049744095.1,GCA_049744075.1,GCA_049744695.1,GCA_049744875.1 -F 'fasta' -o $(pwd)/NWU_2025_workshop_data/test_datasets/salmonella_assemblies --flat-output bacteria || { echo -e '\033[31mDownloading sample assemblies from bioproject failed\033[0m' ; exit 1; }
gunzip $(pwd)/NWU_2025_workshop_data/test_datasets/salmonella_assemblies/*

# Download mashtree
echo -e "\033[33mDownloading mashtree results\033[0m"
curl https://raw.githubusercontent.com/VishnuRaghuram94/NWUPathogenGenomicsWorkshop/refs/heads/main/results/PRJNA1230142_mashtree.dnd -o $(pwd)/NWU_2025_workshop_data/test_datasets/results/PRJNA1230142_mashtree.dnd -s || { echo -e '\033[31mDownloading mashtree results failed\033[0m' ; exit 1; }
 
# Download ANI table
echo -e "\033[33mDownloading ANI table\033[0m"
curl https://raw.githubusercontent.com/VishnuRaghuram94/NWUPathogenGenomicsWorkshop/refs/heads/main/results/PRJNA1230142_ANI.tsv  -o $(pwd)/NWU_2025_workshop_data/test_datasets/results/PRJNA1230142_ANI.tsv -s || { echo -e '\033[31mDownloading ANI table failed\033[0m' ; exit 1; }

# Download QUAST results summary
echo -e "\033[33mDownloading QUAST results\033[0m"
curl https://raw.githubusercontent.com/VishnuRaghuram94/NWUPathogenGenomicsWorkshop/refs/heads/main/results/PRJNA1230142_QUAST.tsv -o $(pwd)/NWU_2025_workshop_data/test_datasets/results/PRJNA1230142_QUAST.tsv -s || { echo -e '\033[31mDownloading QUAST results failed\033[0m' ; exit 1; }

# Download MultiQC results summary
echo -e "\033[33mDownloading MultiQC results\033[0m"
curl https://raw.githubusercontent.com/VishnuRaghuram94/NWUPathogenGenomicsWorkshop/refs/heads/main/results/PRJNA1230142_multiqc_report.html -o $(pwd)/NWU_2025_workshop_data/test_datasets/results/PRJNA1230142_multiqc_report.html -s || { echo -e '\033[31mDownloading MultiQC results failed\033[0m' ; exit 1; }

# Download AMRFinderPlus database
echo -e "\033[33mDownloading AMRFinderPlus database\033[0m"
wget -q -r ftp://ftp.ncbi.nlm.nih.gov/pathogen/Antimicrobial_resistance/AMRFinderPlus/database/latest/ || { echo -e '\033[31mDownloading AMRFinderPlus database failed\033[0m' ; exit 1; }

## Cleanup
mv ftp.ncbi.nlm.nih.gov/pathogen/Antimicrobial_resistance/AMRFinderPlus/database/latest/* $(pwd)/NWU_2025_workshop_data/databases/AMRFinderPlus/ 
rm -r $(pwd)/ftp.ncbi.nlm.nih.gov

# Download AMRFinderPlus results summary
echo -e "\033[33mDownloading AMRFinder results\033[0m"
curl https://raw.githubusercontent.com/VishnuRaghuram94/NWUPathogenGenomicsWorkshop/refs/heads/main/results/PRJNA1230142_amrfinderplus.tsv -o $(pwd)/NWU_2025_workshop_data/test_datasets/results/PRJNA1230142_amrfinderplus.tsv -s || { echo -e '\033[31mDownloading AMRFinder results failed\033[0m' ; exit 1; }

# Download MLST results
echo -e "\033[33mDownloading MLST results\033[0m"
curl https://raw.githubusercontent.com/VishnuRaghuram94/NWUPathogenGenomicsWorkshop/refs/heads/main/results/PRJNA1230142_mlst.tsv -o $(pwd)/NWU_2025_workshop_data/test_datasets/results/PRJNA1230142_mlst.tsv -s || { echo -e '\033[31mDownloading MLST results failed\033[0m' ; exit 1; }

# Download snippy core genome alignment
echo -e "\033[33mDownloading core genome alignment results\033[0m"
curl https://raw.githubusercontent.com/VishnuRaghuram94/NWUPathogenGenomicsWorkshop/refs/heads/main/results/PRJNA1230142_snippy_gubbins_snp-sites.aln -o $(pwd)/NWU_2025_workshop_data/test_datasets/results/PRJNA1230142_snippy_gubbins_snp-sites.aln -s || { echo -e '\033[31mDownloading core genome alignment failed\033[0m' ; exit 1; }

# Download SNP-dists
echo -e "\033[33mDownloading SNP distance matrix results\033[0m"
curl https://raw.githubusercontent.com/VishnuRaghuram94/NWUPathogenGenomicsWorkshop/refs/heads/main/results/PRJNA1230142_snpdists.tsv -o $(pwd)/NWU_2025_workshop_data/test_datasets/results/PRJNA1230142_snpdists.tsv -s || { echo -e '\033[31mDownloading SNP distance matrix failed\033[0m' ; exit 1; }

# Download IQ-tree
echo -e "\033[33mDownloading phylogeny\033[0m"
curl https://raw.githubusercontent.com/VishnuRaghuram94/NWUPathogenGenomicsWorkshop/refs/heads/main/results/PRJNA1230142_iqtree.nwk -o $(pwd)/NWU_2025_workshop_data/test_datasets/results/PRJNA1230142_iqtree.nwk -s || { echo -e '\033[31mDownloading phylogeny failed\033[0m' ; exit 1; }

# Download gene presence absence
echo -e "\033[33mDownloading gene presence/absence matrix \033[0m"
curl https://raw.githubusercontent.com/VishnuRaghuram94/NWUPathogenGenomicsWorkshop/refs/heads/main/results/PRJNA1230142_panaroo.Rtab -o $(pwd)/NWU_2025_workshop_data/test_datasets/results/PRJNA1230142_panaroo.Rtab -s || { echo -e '\033[31mDownloading phylogeny failed\033[0m' ; exit 1; }

echo -e "\033[33mDownloading gene presence/absence matrix (roary)\033[0m"
curl https://raw.githubusercontent.com/VishnuRaghuram94/NWUPathogenGenomicsWorkshop/refs/heads/main/results/PRJNA1230142_roary.csv -o $(pwd)/NWU_2025_workshop_data/test_datasets/results/PRJNA1230142_roary.csv -s || { echo -e '\033[31mDownloading phylogeny failed\033[0m' ; exit 1; }

echo -e "\033[34mSetup successful\!\033[0m"
