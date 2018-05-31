#!/Users/wilkox/perl5/perlbrew/perls/perl-5.26.1/bin/perl

use Modern::Perl 2016;
use Path::Tiny;
use String::ShellQuote qw( shell_quote );
use autodie;
$|++;

my $path = shift;
open(IN, "<", $path);
my $cornell_dir = "/Users/wilkox/tmp";
mkdir $cornell_dir unless -d $cornell_dir;
open(CORNELL, ">", "$cornell_dir/cornell.tsv");

my $note;
my $title;
my @questions;
while (readline IN) {

  # Catch title
  if ($. == 1) {
    chomp;
    $title = $_;

    # Remove leading date
    $title =~ s/^\d{4}-\d{2}-\d{2}\s//;
    next;
  }

  # Catch tags
  if ($. == 2) {
    chomp;
    next unless /@/;
    s/@//g;
    my @tags = split /\s+/, $_;
    say CORNELL "tags: @tags";
    next;
  }

  # Ignore blank lines
  next if $_ eq "";

  # Lines beginning with an question mark become questions
  if (/^\?/) {

    # Remove leading question mark and any whitespace
    $_ =~ s/^\?\s?//;
    chomp;

    push @questions, $_;
    next;
  }

  # Other lines get added to the note
  $note .= $_;
}

# Convert note markdown to HTML
path("/tmp/note_markdown")->spew($note);
my $htmldir = "/Users/wilkox/stage_3_htmls/";
mkdir $htmldir if ! -d $htmldir;
my $htmlpath = $htmldir . path($path)->basename(".md") . ".html";
my $pandoc = "pandoc -s -M title=" . shell_quote($title) . " /tmp/note_markdown -o ". shell_quote($htmlpath);
system($pandoc);
my $include = "<embed src='$htmlpath' style='width:500px; height: 300px;'>";

# Write each question to file
say CORNELL "$_\t$include" for @questions;

close IN;
close CORNELL;
