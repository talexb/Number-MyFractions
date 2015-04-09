#!/usr/bin/perl -T

use Test::More;

use Number::MyFraction;

{
    #  Test basic addition

    my $half  = Number::MyFraction->new(1, 2);
	ok(defined $half, 'Object created');
    my $third = Number::MyFraction->new(1, 3);
	ok(defined $third, 'Object created');

	$total = $half + $third;
	is(5, $total->num, 'Numerator value');
	is(6, $total->den, 'Denominator value');

	is('5/6', $total->val, 'Value');

	done_testing;
}
