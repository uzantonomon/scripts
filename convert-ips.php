<?php 
$infile = 'portugal.csv';
$outfile = 'portugal.ips';

$fp = fopen($outfile,'w');
$handle = fopen($infile, "r");
if ($handle)
{
    while (($line = fgets($handle)) !== false) {
        $line = trim($line);
        $a = explode(',',$line);
        $from = str_replace('"','',$a[0]);
        $to = str_replace('"','',$a[1]);
        for($i=$from;$i<=$to;$i++)
        {
          $ip = long2ip($i);
          fwrite($fp,$ip."\n");
          if(++$j % 10000==0)
                echo ".";
        }
    }
    fclose($handle);
}
fclose($fp);
