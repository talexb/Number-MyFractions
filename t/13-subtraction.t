#!/usr/bin/perl

use warnings;
use strict;

use Test::More;

use Number::MyFraction;

{
    #  Test basic subtraction

    my $half  = Number::MyFraction->new(1, 2);
	ok(defined $half, 'Object created');
    my $third = Number::MyFraction->new(1, 3);
	ok(defined $third, 'Object created');

	my $total = $half - $third;
	is(1, $total->num, 'Numerator value');
	is(6, $total->den, 'Denominator value');

	is('1/6', $total->val, 'Value');

    #  Test basic subtraction with a negative result

	$total = $third - $half;
	is(-1, $total->num, 'Numerator value');
	is(6, $total->den, 'Denominator value');

	is('-1/6', $total->val, 'Value');

	done_testing;
}
