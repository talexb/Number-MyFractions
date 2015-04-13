#!/usr/bin/perl

use warnings;
use strict;

use Test::More;

use Number::MyFraction;

{
    #  Test basic addition 1

    my $half = Number::MyFraction->new( 1, 2 );
    ok( defined $half, 'Object created' );
    my $third = Number::MyFraction->new( 1, 3 );
    ok( defined $third, 'Object created' );

    my $total = $half + $third;
    is( 5, $total->num, 'Numerator value' );
    is( 6, $total->den, 'Denominator value' );

    is( '5/6', $total->val, 'Value' );

    #  Test basic addition 1a

    $half = Number::MyFraction->new( -1, 2 );
    ok( defined $half, 'Object created' );
    $third = Number::MyFraction->new( -1, 3 );
    ok( defined $third, 'Object created' );

    $total = $half + $third;
    is( -5, $total->num, 'Numerator value' );
    is( 6,  $total->den, 'Denominator value' );

    is( '-5/6', $total->val, 'Value' );

    #  Test basic addition 2

    my $small = Number::MyFraction->new(.3);
    ok( defined $small, 'Object created' );
    my $large = Number::MyFraction->new(.5);
    ok( defined $large, 'Object created' );

    $total = $small + $large;
    is( 4, $total->num, 'Numerator value' );
    is( 5, $total->den, 'Denominator value' );

    is( '4/5', $total->val,         'Value' );
    is( .8,    $total->decimal_val, 'Value' );

    done_testing;
}
