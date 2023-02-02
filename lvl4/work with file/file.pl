#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

open(DATA, ">>file.txt");
my $text = <STDIN>;
print DATA $text;
close(DATA);

open(DATA, "<file.txt");
while(<DATA>)
{
    print $_;
}
close(DATA);