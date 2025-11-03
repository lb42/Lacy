
my $first=1;
my $count;
print "<pages>\n";
while (<>) {
    if( /(Vol\d\d)\/(L\d\d\d\d)\/[pP]ages\:/) {
	print(" count='$count'\/>\n$cmdStr") unless
	    ($first eq 1);
	$count=0;
	$first=0;
	$cmdStr="";
	$vol=$1;
	$id= $2;	
	print "<pCount n='$1' text='$id' ";
    }
    else
    {  chop; $f1 = $_; $fno =0;
       if ($f1 =~ /(\d\d\d)\.tif/) {
	   $fno=$1;
       $f2= $id . '-' . $fno . '.jpg';
       $cmdStr .= "<cmd>convert $f1 $f2<\/cmd>\n";
       }
       $count++;
    }
   }
print "count='$count'\/>\n<\/pages>\n$cmdStr";
