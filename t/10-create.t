#!/usr/bin/perl -T

use Test::More;

use Number::MyFraction;

{
    #  Test format #1

    my $half = Number::MyFraction->new(1, 2);
	ok(defined $half, 'Object created');

	is(1, $half->num, 'Numerator value');
	is(2, $half->den, 'Denominator value');

	is('1/2', $half->val, 'Value');

    #  Test format #2

    my $other_half = Number::MyFraction->new('1/2');
	ok(defined $other_half, 'Object created');

	is(1, $other_half->num, 'Numerator value');
	is(2, $other_half->den, 'Denominator value');

	is('1/2', $other_half->val, 'Value');

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

