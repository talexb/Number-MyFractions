#!/usr/bin/perl -T

use Test::More;

use Number::MyFraction;

{
    #  Test basic subtraction

    my $half  = Number::MyFraction->new(1, 2);
	ok(defined $half, 'Object created');
    my $third = Number::MyFraction->new(1, 3);
	ok(defined $third, 'Object created');

	$total = $half - $third;
	is(1, $total->num, 'Numerator value');
	is(6, $total->den, 'Denominator value');

	is('1/6', $total->val, 'Value');

    #  Test basic subtraction with a negative result

    my $half  = Number::MyFraction->new(1, 2);
	ok(defined $half, 'Object created');
    my $third = Number::MyFraction->new(1, 3);
	ok(defined $third, 'Object created');

	$total = $third - $half;
	is(-1, $total->num, 'Numerator value');
	is(6, $total->den, 'Denominator value');

	is('-1/6', $total->val, 'Value');

	done_testing;
}
