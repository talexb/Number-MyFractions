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

sub new {

    my ( $class, @args ) = @_;
    my $self;

    if ( @args == 2 ) {

        $self = { n => $args[0], d => $args[1] };
    }
    elsif ( @args == 1 ) {

        my ( $n, $d ) = ( $args[0] =~ '(\d+)/(\d+)' );
        $self = { n => $n, d => $d };
    } else {

        $self = { n => undef, d => undef };
	}

    bless $self, $class;
    return $self;
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

1; # End of Number::MyFraction
