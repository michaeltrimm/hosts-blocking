<?php
ini_alter("max_execution_time",0);
$file = file_get_contents("hosts.txt");
$lines = explode("\n",$file);
$found = array();
foreach($lines as $line){
  if(!in_array($line,$found)){
    $parts = explode("#",$line);
    $found[] = trim($parts[0]);
  }
}
$boundary1 = sha1(md5(time()));
$boundary2 = sha1(sha1(time()));
shuffle($found);
$data = implode("\n",$found);
$output = <<<TXT
#$boundary1
$data
#$boundary2
TXT;
file_put_contents("../_hosts.txt", $output);