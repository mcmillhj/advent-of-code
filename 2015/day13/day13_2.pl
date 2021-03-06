#!/usr/bin/env perl

use strict;
use warnings;

use feature qw(say);

my %happiness;
while ( my $line = <DATA> ) {
   chomp($line);

   my ( $to, 
        $sign, 
        $amount, 
        $from
   ) = $line =~ m/^(\w+) would (\w+) (\d+) .*? to (\w+).$/;

   $amount = $sign eq 'gain' 
      ? 0+$amount 
      : 0-$amount;
   
   $happiness{$to}->{$from} = $amount;
}

my ($happiest) = compute_happiness(
   [ permutations(keys %happiness) ],
   [ sub { sort { $b <=> $a } @_ } ],
);
say $happiest;

sub compute_happiness {
   my ($perms, $funcs) = @_;

   my @happiness;
   foreach my $perm ( @$perms ) { 
      my $happiness = 0;
      my $p_len = @$perm;
      foreach my $i ( 0 .. $p_len - 1 ) {
         my ($a, $b) = (
            $i % $p_len, 
            ($i + 1) % $p_len,
         );
         
         $happiness += 
            $happiness{ $perm->[$a] }->{ $perm->[$b] }
         + $happiness{ $perm->[$b] }->{ $perm->[$a] };
      }

      push @happiness, $happiness;
   }

   return map { $_->(@happiness) } @$funcs;
}

sub permutations {
   my (@elements) = @_;

   return []
      unless @elements;
   return [ shift @elements ]
      if @elements == 1;

   my ($head, @tail) = @elements;
   my @perms;
   foreach my $p ( permutations(@tail) ) {
      my $p_len = $#{ $p };
      foreach my $i ( 0 .. @$p ) {
         push @perms, [ @$p[0..$i-1], $head, @$p[$i..$p_len] ];
      }
   }

   return @perms;
}


__DATA__
Alice would lose 2 happiness units by sitting next to Bob.
Alice would lose 62 happiness units by sitting next to Carol.
Alice would gain 65 happiness units by sitting next to David.
Alice would gain 21 happiness units by sitting next to Eric.
Alice would lose 81 happiness units by sitting next to Frank.
Alice would lose 4 happiness units by sitting next to George.
Alice would lose 80 happiness units by sitting next to Mallory.
Bob would gain 93 happiness units by sitting next to Alice.
Bob would gain 19 happiness units by sitting next to Carol.
Bob would gain 5 happiness units by sitting next to David.
Bob would gain 49 happiness units by sitting next to Eric.
Bob would gain 68 happiness units by sitting next to Frank.
Bob would gain 23 happiness units by sitting next to George.
Bob would gain 29 happiness units by sitting next to Mallory.
Carol would lose 54 happiness units by sitting next to Alice.
Carol would lose 70 happiness units by sitting next to Bob.
Carol would lose 37 happiness units by sitting next to David.
Carol would lose 46 happiness units by sitting next to Eric.
Carol would gain 33 happiness units by sitting next to Frank.
Carol would lose 35 happiness units by sitting next to George.
Carol would gain 10 happiness units by sitting next to Mallory.
David would gain 43 happiness units by sitting next to Alice.
David would lose 96 happiness units by sitting next to Bob.
David would lose 53 happiness units by sitting next to Carol.
David would lose 30 happiness units by sitting next to Eric.
David would lose 12 happiness units by sitting next to Frank.
David would gain 75 happiness units by sitting next to George.
David would lose 20 happiness units by sitting next to Mallory.
Eric would gain 8 happiness units by sitting next to Alice.
Eric would lose 89 happiness units by sitting next to Bob.
Eric would lose 69 happiness units by sitting next to Carol.
Eric would lose 34 happiness units by sitting next to David.
Eric would gain 95 happiness units by sitting next to Frank.
Eric would gain 34 happiness units by sitting next to George.
Eric would lose 99 happiness units by sitting next to Mallory.
Frank would lose 97 happiness units by sitting next to Alice.
Frank would gain 6 happiness units by sitting next to Bob.
Frank would lose 9 happiness units by sitting next to Carol.
Frank would gain 56 happiness units by sitting next to David.
Frank would lose 17 happiness units by sitting next to Eric.
Frank would gain 18 happiness units by sitting next to George.
Frank would lose 56 happiness units by sitting next to Mallory.
George would gain 45 happiness units by sitting next to Alice.
George would gain 76 happiness units by sitting next to Bob.
George would gain 63 happiness units by sitting next to Carol.
George would gain 54 happiness units by sitting next to David.
George would gain 54 happiness units by sitting next to Eric.
George would gain 30 happiness units by sitting next to Frank.
George would gain 7 happiness units by sitting next to Mallory.
Mallory would gain 31 happiness units by sitting next to Alice.
Mallory would lose 32 happiness units by sitting next to Bob.
Mallory would gain 95 happiness units by sitting next to Carol.
Mallory would gain 91 happiness units by sitting next to David.
Mallory would lose 66 happiness units by sitting next to Eric.
Mallory would lose 75 happiness units by sitting next to Frank.
Mallory would lose 99 happiness units by sitting next to George.
Mallory would gain 0 happiness units by sitting next to Hunter.
George would gain 0 happiness units by sitting next to Hunter.
Frank would gain 0 happiness units by sitting next to Hunter.
Eric would gain 0 happiness units by sitting next to Hunter.
David would gain 0 happiness units by sitting next to Hunter.
Carol would gain 0 happiness units by sitting next to Hunter.
Bob would gain 0 happiness units by sitting next to Hunter.
Alice would gain 0 happiness units by sitting next to Hunter.
Hunter would gain 0 happiness units by sitting next to Mallory.
Hunter would gain 0 happiness units by sitting next to George.
Hunter would gain 0 happiness units by sitting next to Frank.
Hunter would gain 0 happiness units by sitting next to Eric.
Hunter would gain 0 happiness units by sitting next to David.
Hunter would gain 0 happiness units by sitting next to Carol.
Hunter would gain 0 happiness units by sitting next to Bob.
Hunter would gain 0 happiness units by sitting next to Alice.
