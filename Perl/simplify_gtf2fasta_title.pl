#!/usr/bin/perl -w
use POSIX qw(strftime);
use Getopt::Std;
use File::Basename;

###############################################################################
#Get the parameter and provide the usage.
###############################################################################
my %opts;
getopts( 'i:o:d:', \%opts );
&usage unless ( exists $opts{i} && exists $opts{o} );
my $start_time=time;
print strftime("Start time is %Y-%m-%d %H:%M:%S\n", localtime(time));

###############################################################################
#Main text.
###############################################################################
open INPUT,"<$opts{i}";
#>0 TCONS_00000001 C158876433. 1-162
#CTCGCTTAGGGCCAGCCATGTCGATGAGAGAACCCTACAAATTTGTTACTGTTTAGTAGC
#TCTCCATATGGAAGTAAGAAACAACTAAAGCTTTATACTACCTCTGTTTCTAAATGTAAG
#ACGTTTTGGCAATTCAAAAATTGAACTACCAAAACACATCTT
open OUTPUT,">$opts{o}";
#>TCONS_00000001 C158876433. 1-162
#GAATTCCAAAGCCAAAGATTGCATCAGTTCTGCTGCTATTTCCTCCTATCATTCTTTCTG
while (<INPUT>) {
	if (/>/) {
		my @tmp=split/\s+/;
		print OUTPUT ">$tmp[1]\n";
	}else{
		print OUTPUT $_;
	}
	
}

close INPUT;
close OUTPUT;

###############################################################################
#Record the program running time!
###############################################################################
my $duration_time=time-$start_time;
print strftime("End time is %Y-%m-%d %H:%M:%S\n", localtime(time));
print "This compute totally consumed $duration_time s\.\n";

###############################################################################
#Scripts usage and about.
###############################################################################
sub usage {
    die(
        qq/
Usage:    simplify_genome_title.pl -i inpute_file -o output_file
Function: simplify maize genome title information, only use chr standard short for,such as Mt, Pt, vor zma v2
Command:  -i inpute file name (Must)
          -o output file name (Must)
          -d database file name
Author:   Liu Yong-Xin, woodcorpse\@163.com, QQ:42789409
Version:  v1.1
Update:   2012-05-10
Notes:    
\n/
    )
}