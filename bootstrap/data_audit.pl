#!/usr/bin/perl
# data_audit.pl — data-segment overlap guard for the seed assembler.
#
# Hand-assigned data addresses across chunks WILL collide silently
# (later segment wins at instantiation; the loser reads foreign bytes —
# the 2026-06-09 diagnostic-corruption class: 12 cross-chunk overlaps,
# NUL-poisoned stderr, lying prefixes). build.sh refuses to assemble
# while any two segments overlap.
use strict; use warnings;
my @seg;
for my $f (glob("bootstrap/src/*.wat"), glob("bootstrap/src/*/*.wat")) {
  open my $h, '<', $f or die "$f: $!";
  while (<$h>) {
    next unless /\(data \(i32\.const (\d+)\) "(.*)"\)/;
    my ($a, $s) = ($1, $2);
    my $b = $s;
    $b =~ s/\\([0-9a-fA-F]{2})/chr(hex($1))/ge;   # \XX hex escapes
    $b =~ s/\\n/\n/g; $b =~ s/\\t/\t/g;
    $b =~ s/\\\\/\\/g; $b =~ s/\\"/"/g;
    push @seg, [$a, length($b), "$f:$."];
  }
  close $h;
}
@seg = sort { $a->[0] <=> $b->[0] } @seg;
my ($pe, $pwho) = (0, "");
my $bad = 0;
for my $s (@seg) {
  my ($a, $l, $who) = @$s;
  if ($a < $pe) {
    print STDERR "DATA OVERLAP: $who (\@$a, len $l) collides with $pwho (ends $pe)\n";
    $bad++;
  }
  if ($a + $l > $pe) { $pe = $a + $l; $pwho = $who; }
}
exit($bad ? 1 : 0);
