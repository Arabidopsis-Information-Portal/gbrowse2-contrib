#!/bin/bash

## Set Path variables
AIP_HOME=/usr/local/projects/AIP
TAIR_DATA=DataProviders/TAIR
GBROWSE_DATA_ROOT=ftp.arabidopsis.org/Maps/gbrowse_data
CUSTOM_DATA=vkrishna/TAIR10_GFF3/genome_browser

/usr/local/packages/perl/bin/bp_seqfeature_load.pl \
    -d 'dbi:Pg:database=[DATABASE];host=[HOSTNAME]' -a 'DBI::Pg' \
    -u [USRENAME] -p [PASSWORD] -c -v \
    -T /usr/local/scratch/EUK/vkrishna/tmp \
    $AIP_HOME/vkrishna/TAIR10_fasta/TAIR10_genome.fas \
    $AIP_HOME/$CUSTOM_DATA/TAIR10_GFF3_genes_transposons.20131107_1826.gff3 \
    $AIP_HOME/$TAIR_DATA/$GBROWSE_DATA_ROOT/TAIR10/TAIR10_unconfirmed_exons.gff \
    $AIP_HOME/$TAIR_DATA/$GBROWSE_DATA_ROOT/TAIR10/Spliced_Junctions_clustered.gff \
    $AIP_HOME/$CUSTOM_DATA/tair9_Quesneville_Transposons_20090429.20131118_0936.gff \
    $AIP_HOME/$TAIR_DATA/$GBROWSE_DATA_ROOT/TAIR10/TAIR_GFF3_ssrs.gff \
    $AIP_HOME/$TAIR_DATA/$GBROWSE_DATA_ROOT/TAIR9/Assembly_GFF/TAIR9_GFF3_assemblies.gff \
    $AIP_HOME/$TAIR_DATA/$GBROWSE_DATA_ROOT/TAIR9/Assembly_GFF/tair9_Assembly_gaps.gff \
    $AIP_HOME/$TAIR_DATA/$GBROWSE_DATA_ROOT/TAIR9/Assembly_GFF/tair9_assembly_updates.gff \
    $AIP_HOME/$TAIR_DATA/$GBROWSE_DATA_ROOT/TAIR9/Variation_GFF/TAIR9_GFF3_tdnas.gff \
    $AIP_HOME/$TAIR_DATA/$GBROWSE_DATA_ROOT/TAIR9/Variation_GFF/TAIR9_GFF3_polymorphisms.gff \
    $AIP_HOME/$TAIR_DATA/$GBROWSE_DATA_ROOT/TAIR9/Variation_GFF/TAIR9_GFF3_markers.gff \
    $AIP_HOME/$CUSTOM_DATA/tair9_smallRNA_17_summary.fixed.gff \
    $AIP_HOME/$TAIR_DATA/$GBROWSE_DATA_ROOT/TAIR9/Expression_GFF/tair9_ATH1-121501.gff \
    $AIP_HOME/$CUSTOM_DATA/tair9_atproteometair7.20131118_0936.gff \
    $AIP_HOME/$CUSTOM_DATA/tair9_Briggs_atproteome7_20090401.20131118_0936.gff \
    > gbrowse2-load.log 2> gbrowse2-load.err
