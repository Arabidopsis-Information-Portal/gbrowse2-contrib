#!/bin/bash

## source araport.env
source /usr/local/projects/AIP/DataProviders/TAIR/araport.env

## set up some custom env vars
WHOLE_CHRS=$AIP_HOME/$TAIR_DATA/custom_data/$CHRS_FASTA

/usr/local/packages/perl/bin/bp_seqfeature_load.pl \
    -d 'dbi:Pg:database=[DATABASE];host=[HOSTNAME]' -a 'DBI::Pg' \
    -u [USERNAME] -p [PASSWORD] -c -v \
    -T /tmp \
    $WHOLE_CHRS/TAIR10_Chr.all.fasta \
    $TAIR10_CUSTOM_GFF3/TAIR10_GFF3_genes_transposons.gff3 \
    $TAIR10_GFF3/TAIR10_unconfirmed_exons.gff \
    $TAIR10_GFF3/Spliced_Junctions_clustered.gff \
    $TAIR9_CUSTOM_GFF3/tair9_Quesneville_Transposons_20090429.gff \
    $TAIR10_GFF3/TAIR_GFF3_ssrs.gff \
    $TAIR9_GFF3/Assembly_GFF/TAIR9_GFF3_assemblies.gff \
    $TAIR9_GFF3/Assembly_GFF/tair9_Assembly_gaps.gff \
    $TAIR9_GFF3/Assembly_GFF/tair9_assembly_updates.gff \
    $TAIR9_GFF3/Variation_GFF/TAIR9_GFF3_tdnas.gff \
    $TAIR9_GFF3/Variation_GFF/TAIR9_GFF3_polymorphisms.gff \
    $TAIR9_GFF3/Variation_GFF/TAIR9_GFF3_markers.gff \
    $TAIR9_GFF3/Expression_GFF/tair9_ATH1-121501.gff \
    $TAIR9_GFF3/tair9_atproteometair7.gff \
    $TAIR9_GFF3/tair9_Briggs_atproteome7_20090401.20131118_0936.gff \
    > gbrowse2-load.log 2> gbrowse2-load.err
