#!/usr/bin/perl -wT
# File:         resin.mon
# Author:       Ian@Zilbo.com
# Date:         Thu Sep 29
# Description: MemcacheD status monitor
# Lots of options.
# License: BSD  (see http://zilbo.com/LICENSE )
# $Id: check_memcached,v 1.1 2005/09/29 11:52:55 ianh Exp $

use strict;
# you will need to fix this!
use lib "/usr/lib64/nagios/plugins";
use Cache::Memcached;
use Getopt::Long;

sub print_help();
sub print_usage();

use vars qw($opt_V $opt_h $opt_H $opt_p $opt_k $opt_t
  $opt_w $opt_c
  $PROGNAME);

$PROGNAME = "check_memcached";
use utils qw(%ERRORS &print_revision &support &usage);
$ENV{'PATH'}='';
$ENV{'BASH_ENV'}='';
$ENV{'ENV'}='';

Getopt::Long::Configure('bundling');
GetOptions
    ("V"   => \$opt_V, "version"    => \$opt_V,
     "h"   => \$opt_h, "help"       => \$opt_h,
     "H=s" => \$opt_H, "hostname=s" => \$opt_H,
     "p=i" => \$opt_p, "port=i"     => \$opt_p,
     "k=s" => \$opt_k, "key=s"      => \$opt_k,
#    "t=i" => \$opt_t, "timeout=i" => \$opt_t,
    );

if ($opt_V) {
    print_revision($PROGNAME,'$Revision: 1.1 $');
    exit $ERRORS{'OK'};
}

if ($opt_h) {print_help(); exit $ERRORS{'OK'};}

($opt_H) || usage("Host name/address not specified\n");
my $host = $1 if ($opt_H =~ /([-.A-Za-z0-9]+)/);
($host) || usage("Invalid host: $opt_H\n");

($opt_p) || usage("port not specified\n");
my $port = $1 if ($opt_p =~ /([0-9]+)/);
($port) || usage("Invalid port: $opt_p\n");

($opt_k) || usage("key not specified\n");
my $key = $1 if ($opt_k =~ /([-.A-Za-z0-9]+)/);
($key) || usage("Invalid key : $opt_k\n");

my  $memd = new Cache::Memcached {
    'servers' => [ "$host:$port"  ],
    'debug' => 0,
    'compress_threshold' => 10_000,
};

unless ( $memd->set( $key , "Nagios Check key", 4*60 ) ) {
  print "unable to set memcached $key";
  exit $ERRORS{'CRITICAL'};
}

my $val = $memd->get( $key );
if ( defined($val) and $val eq "Nagios Check key" ) {
    exit $ERRORS{'OK'};
}
else {
  print "unable to get memcached $key/wrong value returned";
  exit $ERRORS{'CRITICAL'};
}
