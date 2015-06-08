#!/usr/bin/perl

use warnings;
use strict;

use Test::More;

use Number::MyFraction;

{
    #  Test basic multiplication 1

    my $half = Number::MyFraction->new( 1, 2 );
    ok( defined $half, 'Object created' );
    my $third = Number::MyFraction->new( 1, 3 );
    ok( defined $third, 'Object created' );

    my $product = $half * $third;
    is( 1, $product->num, 'Numerator value' );
    is( 6, $product->den, 'Denominator value' );

    is( '1/6', $product->val, 'Value' );

    #  Test basic multiplication 1a

    $half = Number::MyFraction->new( -1, 2 );
    ok( defined $half, 'Object created' );
    $third = Number::MyFraction->new( -1, 3 );
    ok( defined $third, 'Object created' );

    $product = $half * $third;
    is( 1, $product->num, 'Numerator value' );
    is( 6,  $product->den, 'Denominator value' );

    is( '1/6', $product->val, 'Value' );

    #  Test basic multiplication 2

    my $small = Number::MyFraction->new(.3);
    ok( defined $small, 'Object created' );
    my $large = Number::MyFraction->new(.5);
    ok( defined $large, 'Object created' );

    $product = $small * $large;
    is( 3, $product->num, 'Numerator value' );
    is( 20, $product->den, 'Denominator value' );

    is( '3/20', $product->val,         'Value' );
    is( .15,    $product->decimal_val, 'Value' );

	#  Test multiplying a fraction by it's reciprocal -- we should get one.

    for my $i ( 5 .. 15 ) {

        for my $j ( 1, 11, 21, 31, 41, 51 ) {

            $small = Number::MyFraction->new( $j, $i );
            $large = Number::MyFraction->new( $i, $j );

            $product = $small * $large;
            is( 1, $product->num, 'Numerator value' );
            is( 1, $product->den, 'Denominator value' );

            is( '1/1', $product->val,         'Value' );
            is( 1,     $product->decimal_val, 'Value' );
        }
    }
    done_testing;
}
