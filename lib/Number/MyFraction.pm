package Number::MyFraction;

use 5.006;
use strict;
use warnings;

=head1 NAME

Number::MyFraction - a class to represent fractions

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

This class represents fractions as objects that can be worked with in
mathematical calculations without losing any accuracy. This is similar
to the Number::Fraction module by Dave Cross.

Perhaps a little code snippet.

    use Number::MyFraction;

    my $half  = Number::MyFraction->new(1, 2);
    my $third = Number::MyFraction->new(1, 3);
	my $sum   = $half + $third;

	print $sum; # prints '5/6'
    ...

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 SUBROUTINES/METHODS

This boilerplate left in for now while I write some code.

=head2 function1

=cut

sub function1 {
}

=head2 function2

=cut

sub function2 {
}

=head1 AUTHOR

T. Alex Beamish, C<< <talexb at gmail.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-number-myfraction at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Number-MyFraction>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Number::MyFraction


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Number-MyFraction>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Number-MyFraction>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Number-MyFraction>

=item * Search CPAN

L<http://search.cpan.org/dist/Number-MyFraction/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2015 T. Alex Beamish.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

L<http://www.perlfoundation.org/artistic_license_2_0>

Any use, modification, and distribution of the Standard or Modified
Versions is governed by this Artistic License. By using, modifying or
distributing the Package, you accept this license. Do not use, modify,
or distribute the Package, if you do not accept this license.

If your Modified Version has been derived from a Modified Version made
by someone other than you, you are nevertheless required to ensure that
your Modified Version complies with the requirements of this license.

This license does not grant you the right to use any trademark, service
mark, tradename, or logo of the Copyright Holder.

This license includes the non-exclusive, worldwide, free-of-charge
patent license to make, have made, use, offer to sell, sell, import and
otherwise transfer the Package with respect to any patent claims
licensable by the Copyright Holder that are necessarily infringed by the
Package. If you institute patent litigation (including a cross-claim or
counterclaim) against any party alleging that the Package constitutes
direct or contributory patent infringement, then this Artistic License
to you shall terminate on the date that such litigation is filed.

Disclaimer of Warranty: THE PACKAGE IS PROVIDED BY THE COPYRIGHT HOLDER
AND CONTRIBUTORS "AS IS' AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES.
THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE, OR NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY
YOUR LOCAL LAW. UNLESS REQUIRED BY LAW, NO COPYRIGHT HOLDER OR
CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THE PACKAGE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


=cut

#  Create fraction object with a numerator and denominator.

my @primes = qw/2 3 5 7 11 13 17 19 23 29 31 37 41 43 47 53 59 61 67 71
73 79 83 89 97 101 103 107 109 113 127 131 137 139 149 151 157 163 167
173 179 181 191 193 197 199/;

sub new {

    my ( $class, @args ) = @_;
    my $self;

    if ( @args == 2 ) {

        $self = { n => $args[0], d => $args[1] };
    }
    elsif ( @args == 1 ) {

		if ( $args[0] =~ '([-+]?\d+)/([-+]?\d+)' ) {

          $self = { n => $1, d => $2 };

		} elsif ( $args[0] =~ /([-+]?\d*(\.(\d+))?)(%)?/ ) {

		  my ( $number, $dec_fract, $fract, $percent ) = 
		    ( $1, $2, $3, $4 );
          my ( $n, $d );

		  if ( defined $dec_fract ) {
		    $d = 10 ** length $fract;
		    $n = $number * $d;
		  } else {
		    $d = 1;
			$n = $number;
		  }
		  if ( defined $percent && $percent ) { $d *= 100; }

          $self = { n => $n, d => $d };
		}
	}

	#  If the previous cases didn't populate $self, just go with an
	#  undefined value for now. This is easier than adding a pile of
	#  else statements, all with the same default value.

	if ( !defined $self ) {

        $self = { n => undef, d => undef };
	}

    bless $self, $class;
	if ( defined $self->num && defined $self->den ) {

	    $self->_normalize;
	}
    return $self;
}

#  Normalize the fraction so that 12/200 -> 3/50, and so forth.

#  TODO: Check an internal flag that indicates that it has already been
#  normalized so we don't repeat work unnecessarily.

sub _normalize {

    my $self = shift;
    if ( $self->num == 1 && $self->den > 0 ) { return; }

    #  Get the signs sorted out. If both signs are negative, change them
    #  both to be positive; if only one is negative, make the numerator
    #  negative. During factorization, all numbers are positive; we'll
    #  correct the sign at the end.

    my $negative_num = 0;
    if ( $self->num < 0 ) { $self->{'n'} *= -1; $negative_num = 1; }
    my $negative_den = 0;
    if ( $self->den < 0 ) { $self->{'d'} *= -1; $negative_den = 1; }

    if ( $negative_num && $negative_den ) {

        $negative_num = 0;
        $negative_den = 0;

    }
    elsif ( $negative_num ^ $negative_den ) {

        $negative_num = 1;
        $negative_den = 0;
    }

    #  Get prime factors for num and den, and use that to calculate the
    #  Lowest Common Multiple.

    my $num_factors = _factor( $self->num );
    my $den_factors = _factor( $self->den );

	#  If both numbers have some factors, let's see if they have any in
	#  common.

    if ( keys %{$den_factors} && keys %{$num_factors} ) {

        my $lcm = 1;
        foreach my $p ( sort { $a <=> $b } keys %{$num_factors} ) {

            if ( exists $den_factors->{$p} ) {

				#  If there are common factors, find the smallest number
				#  that they have in common, and add it in to the LCM
				#  that we're keeping track of.

                my $count =
                  ( sort { $a <=> $b }
                      ( $num_factors->{$p}, $den_factors->{$p} ) )[0];
                $lcm *= $p**$count;
            }
        }

        if ( $lcm > 1 ) {

            #  Update the two values by dividing both by the LCM.

            $self->{'n'} = ( $self->num / $lcm );
            $self->{'d'} = ( $self->den / $lcm );
        }
    }

    #  Correct the sign, if necessary, by putting the negative in the
    #  numerator.

    if ($negative_num) { $self->{'n'} *= -1; }

	#  TODO: Mark that this fraction has been normalized so that it
	#  doesn't get done again.
}

#  Create a hash with the prime number factors of the input number.

sub _factor {

    my ($num) = @_;

    my %factors;
    for my $f (@primes) {

		if ( $f == $num ) { $factors{$f}++; last; }

        if ( $f > $num ) { last; }
        while ( $num % $f == 0 ) {

            $factors{$f}++;
            $num /= $f;
        }
    }
    return \%factors;
}

#  Return just the numerator or the denominator.

sub num { my $self = shift; return $self->{'n'}; }
sub den { my $self = shift; return $self->{'d'}; }

#  Figure out the value.

sub val {

    my $self = shift;
    if ( !defined $self->{'d'} || $self->{'d'} == 0 ) { return undef; }

    if ( defined $self->{'n'} ) {

        return join( '/', map { $self->{$_} } qw/n d/ );
    }
    else { return undef; }
}

#  Actually do the division and move the value into the real realm.

sub decimal_val {

    my $self = shift;
    if ( !defined $self->{'d'} || $self->{'d'} == 0 ) { return undef; }

    return ( $self->{'n'} / $self->{'d'} );
}

#  Add two fractions together.

sub add {

    my ( $num1, $num2 ) = @_;

    if ( defined $num1->den && defined $num2->den ) {

        my $total = Number::MyFraction->new(
            $num1->num * $num2->den + $num2->num * $num1->den,
            $num1->den * $num2->den );
	    return $total;
    }
}

#  Subtract two fractions.

sub subtract {

    my ( $num1, $num2 ) = @_;

    if ( defined $num1->den && defined $num2->den ) {

        my $total = Number::MyFraction->new(
            $num1->num * $num2->den - $num2->num * $num1->den,
            $num1->den * $num2->den );
	    return $total;
    }
}

use overload '+' => \&add, '-' => \&subtract;

1; # End of Number::MyFraction
