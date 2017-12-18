<?php
function toMapping($input){
  $mapping = [];
  $lines = explode(PHP_EOL, $input);

  foreach($lines as $line){
    $str = preg_replace( '/\s*/m', '', $line );
    list($key, $values) = explode('<->', $str) ;
    $mapping[$key] = explode(',', $values);
  }
  
  return $mapping;
} 

function depsOf($value, $mapping, $results){
  if(!in_array($value, $results)){
    array_push($results, $value);
  }
  
  foreach($mapping[$value] as $dep){
    if(!in_array($dep, $results)){
      $results = depsOf($dep, $mapping, $results);
    }
  }  
  
  return $results;
}
?>
