#!/bin/bash

## Set Path variables
AIP_HOME=/usr/local/projects/AIP
TAIR_DATA=DataProviders/TAIR
TAIR10_RELEASE=ftp.arabidopsis.org/Genes/TAIR10_genome_release
TAIR9_RELEASE=ftp.arabidopsis.org/Genes/TAIR9_genome_release
TAIR10_gff3=$AIP_HOME/$TAIR_DATA/$TAIR10_RELEASE/TAIR10_gff3
TAIR9_gff3=$AIP_HOME/$TAIR_DATA/$TAIR9_RELEASE/TAIR9_gff3

## Custom data paths
TAIR10_custom_gff3=$AIP_HOME/$TAIR_DATA/custom_data/$TAIR10_RELEASE/TAIR10_gff3
TAIR9_custom_gff3=$AIP_HOME/$TAIR_DATA/custom_data/$TAIR9_RELEASE/TAIR9_gff3
WHOLE_CHRS=$AIP_HOME/$TAIR_DATA/custom_data/Sequences/whole_chromosomes

/usr/local/packages/perl/bin/bp_seqfeature_load.pl \
    -d 'dbi:Pg:database=[DATABASE];host=[HOSTNAME]' -a 'DBI::Pg' \
    -u [USERNAME] -p [PASSWORD] -c -v \
    -T /tmp \
    $WHOLE_CHRS/TAIR10_genome.fas \
    $TAIR10_custom_gff3/TAIR10_GFF3_genes_transposons.gff3 \
    $TAIR10_gff3/TAIR10_unconfirmed_exons.gff \
    $TAIR10_gff3/Spliced_Junctions_clustered.gff \
    $TAIR9_custom_gff3/tair9_Quesneville_Transposons_20090429.gff \
    $TAIR10_gff3/TAIR_GFF3_ssrs.gff \
    $TAIR9_gff3/Assembly_GFF/TAIR9_GFF3_assemblies.gff \
    $TAIR9_gff3/Assembly_GFF/tair9_Assembly_gaps.gff \
    $TAIR9_gff3/Assembly_GFF/tair9_assembly_updates.gff \
    $TAIR9_gff3/Variation_GFF/TAIR9_GFF3_tdnas.gff \
    $TAIR9_gff3/Variation_GFF/TAIR9_GFF3_polymorphisms.gff \
    $TAIR9_gff3/Variation_GFF/TAIR9_GFF3_markers.gff \
    $TAIR9_gff3/Expression_GFF/tair9_ATH1-121501.gff \
    $TAIR9_gff3/tair9_atproteometair7.gff \
    $TAIR9_gff3/tair9_Briggs_atproteome7_20090401.20131118_0936.gff \
    > gbrowse2-load.log 2> gbrowse2-load.err
