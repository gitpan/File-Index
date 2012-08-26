package File::Index;
use strict;
use warnings;

use Exporter ();
use Carp qw(croak);
use vars qw($VERSION @ISA @EXPORT);

$VERSION = "0.01";
@ISA = qw(Exporter);
@EXPORT = qw(indexf);

sub indexf {
  my $filehandle=shift;
  my $substring=shift;
  my $start=shift||0;
  my $bufferSize=shift||131072;
  my $offset=0;
  croak "BufferSize must not be less than substring length"
    if $bufferSize<length($substring);
  while ( seek($filehandle,$start+$offset,0) ) {
    my $buffer;
    if ( read($filehandle,$buffer,$bufferSize) >= length($substring) ) {
      if ( (my $n=index($buffer,$substring))>-1 ) { return($n+$offset+$start) }
      $offset+=($bufferSize-length($substring)+1)
    } else { return(-1) }
  }
  return(-1)
}

=head1 NAME

File::Index - an index function for files

=head1 SYNOPSIS

  use File::Index;
  open(FILE,$myfile);
  my $pos=indexf(*FILE,"Foo");
  print "Foo found at position: $pos\n" if $n > -1;

=head1 DESCRIPTION

This module provides an indexf function which operates on files in the
same way that the index function operates on strings. It can be used where
memory limitations prohibit the slurping of an entire file.

=over 4

=item C<indexf( *FH, $string, [$start], [$buffersize] )>

Starts at the position specified by '$start' (or at the beginning) of
the file associated with filehandle 'FH', and returns the absolute start
position of the string '$string'.
The buffer-size can be adjusted by specifying '$buffersize'.

=back

=head1 AUTHOR

Graham Jenkins, C<< <grahjenk at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-file-index at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=File-Index>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.



=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc File::Index


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=File-Index>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/File-Index>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/File-Index>

=item * Search CPAN

L<http://search.cpan.org/dist/File-Index/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2012 Graham Jenkins.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

1; # End of File::Index
