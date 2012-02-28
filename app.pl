#!/usr/bin/perl -w
use strict;
use CGI q/:standard/;
use utf8;

my $path='../../htdocs/motion/';
my $from=param('from');
my @source=('cam1','cam2');

print header(-charset=>'utf8');
print start_html(-script=>&JScript);
print p('Select date and source');
&Form;
&Listing if $from;
print end_html;

#Form for settings date priod and source
sub Form(){
  print start_form(-method=>'get');
  print textfield(-name=>'from');
  print submit;
  print end_form;
}

#Listing files
sub Listing(){
  print p("Listing...");
  foreach my $source(@source){
    my @list=<$path/$source/$from*.*>;
    if(@list){
      print p("Source: $source");
      print '<select name=file>';
      my $swf='';
      foreach my $key(@list){
        $key=~s/$path\/$source\/$from//;
        print "<option value=\"$key\">$key";
        $swf=$key;
      }
      print '</select>';
      print button('',"View",'tellme()');
      print p;
      print "<object width=\"320\" height=\"240\">";
      print "<embed src=\"/motion/$source/$from$swf\" width=\"320\" height=\"240\">";
      print '</embed>';
      print '</object>';
    }else{
      print p('Files not found');
    }
  }
}

sub JScript(){
  my $src='function tellme(){alert(document.getElementsByTagName(\'moviecam1\').name)}';
  return $src;
}