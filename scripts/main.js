function ViewMovie($source,$from){
  $object="file"+[$source];
  $index=document.getElementById($object).selectedIndex;
  $file="/motion/"+$source+"/"+$from+document.getElementById($object).options[$index].text;
  $object="movie"+$source;
  document.getElementById($object).src=$file;
}function OpenMovie($source,$from){
  $object="file"+[$source];
  $index=document.getElementById($object).selectedIndex;
  $file="/motion/"+$source+"/"+$from+document.getElementById($object).options[$index].text;
  window.open($file,"VideoMovie","height=640");
}