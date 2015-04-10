#!/use/bin/perl

use warnings;
use strict;

#  Let's generate prime numbers!

{
    my %x;
	my $max = 200;
    for ( 2 .. $max ) { $x{$_} = 1; }
    for my $div ( 3 .. $max ) {
        print "Look at $div .. ";
        foreach my $cand ( sort { $a <=> $b } keys %x ) {
			if ( $cand * $cand > $div ) { print "(2) \n"; last; }
            print "Try $div % $cand .. ";
            if ( $div % $cand == 0 ) {
                print "delete $div .. (3)";
                delete $x{$div};
				last;
            }
        }
        print "\n";
    }
    print join( ' ', sort { $a <=> $b } keys %x ) . "\n";
}
