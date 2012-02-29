#!/usr/bin/perl -w
use strict;
use CGI q/:standard/;
use utf8;

my $moviepath='../../data/motion/';
my $scriptpath='scripts/';
my $from=param('from');
my @source=('cam1','cam2');

print header(-charset=>'utf8');
print start_html(-script=>&JScript);
print p('Select date');
&Form;
&Listing if $from;
print end_html;

#Form for settings date priod and source
sub Form(){
  print start_form(-method=>'post');
  print textfield(-name=>'from',
                  -size=>15);
  print submit('',"Set date");
  print end_form;
}

#Listing files
sub Listing(){
  foreach my $source(@source){
    my @list=<$moviepath/$source/$from*.*>;
    if(@list){
      print start_form(-name=>"$source");
      print p("Source: $source");
      print "<select id=\"file$source\">";
      my $swf='';
      foreach my $key(@list){
        $key=~s/$moviepath\/$source\/$from//;
        print "<option value=\"$key\">$key";
        $swf=$key;
      }
      print '</select>';
      print button('',"View","ViewMovie('$source','$from')");
      print button('',"Stop","StopMovie('$source')");
      print button('',"Open","OpenMovie('$source','$from')");
      print p;
      print "<object width=\"320\" height=\"240\">";
      print "<embed id=\"movie$source\" src=\"/motion/$source/null.swf\" width=\"320\" height=\"240\"></embed>";
      print '</object>';
      print end_form;
    }else{
      print p('Files not found');
    }
  }
}

sub JScript(){
  my $src=();
  my @tmpsrc=();
  open (SCRIPT,"<$scriptpath/main.js") || die "Can't loading scripts";
  @tmpsrc=<SCRIPT>;
  close SCRIPT;
  foreach my $key(@tmpsrc){
    $src=$src.$key;
  }
  return $src;
}