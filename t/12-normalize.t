#!/usr/bin/perl -T

use Test::More;

use Number::MyFraction;

{
    #  Test basic addition with normalization

    my $quarter1 = Number::MyFraction->new( 1, 4 );
    ok( defined $quarter1, 'Object created' );
    my $quarter2 = Number::MyFraction->new( 1, 4 );
    ok( defined $quarter2, 'Object created' );

    $total = $quarter1 + $quarter2;
    is( 1, $total->num, 'Numerator value' );
    is( 2, $total->den, 'Denominator value' );

    is( '1/2', $total->val, 'Value' );

    #  Test basic addition with normalization

    my $big_part = Number::MyFraction->new( 12, 25 );
    ok( defined $big_part, 'Object created' );
    my $small_part = Number::MyFraction->new( 1, 50 );
    ok( defined $small_part, 'Object created' );

    $total = $big_part + $small_part;
    is( 1, $total->num, 'Numerator value' );
    is( 2, $total->den, 'Denominator value' );

    is( '1/2', $total->val, 'Value' );

    #  Test a variety of ratios that all work out to 1/2

    for my $n (qw/2 3 5 7 11 13 17 19 23 29/) {

        for my $m (qw/31 37 41 43 47 53 59/) {

            my $nm = $n * $m;
            my $fraction = Number::MyFraction->new( $nm, $nm * 2 );
            ok( defined $fraction, 'Object created' );

            is( 1, $fraction->num, 'Numerator value' );
            is( 2, $fraction->den, 'Denominator value' );

            is( '1/2', $fraction->val, 'Value' );
        }
    }

    done_testing;
}
