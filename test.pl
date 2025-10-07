#! /usr/bin/perl

use strict;
use warnings;

my %exists;

my $TYPES = "NETWORKING|PRINTER|COMPUTER|STORAGE|VIDEO|PHONE|KVM|POWER";

foreach my $file (@ARGV) {

    warn "Checking $file...\n" if @ARGV > 1;

    my ($fh, $line);

    open $fh, $file
        or die "Can't open '$file': $!\n";

    while (<$fh>) {
        $line++;
        chomp;
        next if (length == 0 || /^\s*\#/);
        die "l.$line: Found space after oid: $_\n" if /^[1-9](|[0-9.]+)( |\xc2\xa0)\t?/;
        die "l.$line: Bad oid: $_\n" unless /^([1-9](|[0-9.]+))\t/;

        # Check for duplicate entries
        die "l.$line: Found duplicated oid entry: $_\n" if $exists{$1};
        $exists{$1} = 1;

        die "l.$line: Found ending space: $_\n" if /( |\xc2\xa0)+$/;

        # 2 fields minimum
        die "l.$line: Not enough fields: $_\n" unless /^[1-9](|[0-9.]+)\t[^\t]+/;
        die "l.$line: Found space before manufacturer: $_\n" if /^[1-9](|[0-9.]+)\t( |\xc2\xa0)+[^\t]/;
        die "l.$line: Found space after manufacturer: $_\n" if /^[1-9](|[0-9.]+)\t[^\t]( |\xc2\xa0)+\t/;
        next if /^[1-9](|[0-9.]+)\t[^\t]+$/;

        # 3 fields
        die "l.$line: Bad type: $_\n" unless /^[1-9](|[0-9.]+)\t[^\t]+\t($TYPES)\t?/;
        next if /^[1-9](|[0-9.]+)+\t[^\t]+\t($TYPES)$/;
        die "l.$line: Found space before type: $_\n" if /^[1-9](|[0-9.]+)\t[^\t]\t( |\xc2\xa0)+($TYPES)/;
        die "l.$line: Found space after type: $_\n" if /^[1-9](|[0-9.]+)\t[^\t]\t($TYPES)( |\xc2\xa0)/;

        # 4 fields
        die "l.$line: Found space before model: $_\n" if /^[1-9](|[0-9.]+)\t[^\t]\t($TYPES)\t( |\xc2\xa0)+/;
        die "l.$line: Found space after model: $_\n" if /^[1-9](|[0-9.]+)\t[^\t]\t($TYPES)\t[^\t]+( |\xc2\xa0)+\t/;
        next if /^[1-9](|[0-9.]+)\t[^\t]+\t($TYPES)\t[^\t]+$/;

        # 5 fields (but accept empty model)
        next if /^[1-9](|[0-9.]+)\t[^\t]+\t($TYPES)\t[^\t]*\t[^\t]+$/;
        die "l.$line: Too much fields: $_\n";
    }
    close($fh);
}
