#!/usr/bin/perl

use warnings;
use strict;

use Test::More;

use Number::MyFraction;

{
    #  Test format #1

    my $half = Number::MyFraction->new(1, 2);
	ok(defined $half, 'Object created');
	ok(defined $half->num, 'Numerator value');
	ok(defined $half->den, 'Denominator value');

	is(1, $half->num, 'Numerator value');
	is(2, $half->den, 'Denominator value');

	is('1/2', $half->val, 'Value');

    #  Test format #2

    my $other_half = Number::MyFraction->new('1/2');
	ok(defined $other_half, 'Object created');
	ok(defined $half->num, 'Numerator value');
	ok(defined $half->den, 'Denominator value');

	is(1, $other_half->num, 'Numerator value');
	is(2, $other_half->den, 'Denominator value');

	is('1/2', $other_half->val, 'Value');

    #  Test format #2a

    $other_half = Number::MyFraction->new('-1/2');
	ok(defined $other_half, 'Object created');
	ok(defined $half->num, 'Numerator value');
	ok(defined $half->den, 'Denominator value');

	is(-1, $other_half->num, 'Numerator value');
	is(2, $other_half->den, 'Denominator value');

	is('-1/2', $other_half->val, 'Value');

    #  Test format #2b

    $other_half = Number::MyFraction->new('1/-2');
	ok(defined $other_half, 'Object created');
	ok(defined $half->num, 'Numerator value');
	ok(defined $half->den, 'Denominator value');

	is(-1, $other_half->num, 'Numerator value');
	is(2, $other_half->den, 'Denominator value');

	is('-1/2', $other_half->val, 'Value');

    #  Test format #2c

    $other_half = Number::MyFraction->new('-1/-2');
	ok(defined $other_half, 'Object created');
	ok(defined $half->num, 'Numerator value');
	ok(defined $half->den, 'Denominator value');

	is(1, $other_half->num, 'Numerator value');
	is(2, $other_half->den, 'Denominator value');

	is('1/2', $other_half->val, 'Value');

    #  Test format #3

    my $another_half = Number::MyFraction->new('.5');
	ok(defined $another_half, 'Object created');
	ok(defined $half->num, 'Numerator value');
	ok(defined $half->den, 'Denominator value');

	is(1, $another_half->num, 'Numerator value');
	is(2, $another_half->den, 'Denominator value');

	is('1/2', $another_half->val, 'Value');

    #  Test format #3a

    $another_half = Number::MyFraction->new('-.5');
	ok(defined $another_half, 'Object created');
	ok(defined $half->num, 'Numerator value');
	ok(defined $half->den, 'Denominator value');

	is(-1, $another_half->num, 'Numerator value');
	is(2, $another_half->den, 'Denominator value');

	is('-1/2', $another_half->val, 'Value');

    #  Test format #4

    $another_half = Number::MyFraction->new('50%');
	ok(defined $another_half, 'Object created');
	ok(defined $half->num, 'Numerator value');
	ok(defined $half->den, 'Denominator value');

	is(1, $another_half->num, 'Numerator value');
	is(2, $another_half->den, 'Denominator value');

	is('1/2', $another_half->val, 'Value');

    #  Test format #5

    my $whole_number = Number::MyFraction->new('5');
	ok(defined $whole_number, 'Object created');
	ok(defined $half->num, 'Numerator value');
	ok(defined $half->den, 'Denominator value');

	is(5, $whole_number->num, 'Numerator value');
	is(1, $whole_number->den, 'Denominator value');

	is('5/1', $whole_number->val, 'Value');

	#  Test undefined value

    my $no_value = Number::MyFraction->new();
	ok(defined $no_value, 'Object created');

	is(undef, $no_value->num, 'Numerator value');
	is(undef, $no_value->den, 'Denominator value');

	is(undef, $no_value->val, 'Value');

	#  Test undefined value (because denominator is zero)

    my $no_value2 = Number::MyFraction->new(1, 0);
	ok(defined $no_value2, 'Object created');

	is(1, $no_value2->num, 'Numerator value');
	is(0, $no_value2->den, 'Denominator value');

	is(undef, $no_value2->val, 'Value');

	done_testing;
}

