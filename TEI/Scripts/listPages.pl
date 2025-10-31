
my $first=1;
my $count;
print "<pages>\n";
while (<>) {
    if( /(Vol\d\d)\/(L\d\d\d\d)\/[pP]ages\:/) {
	print(" count='$count'\/>\n") unless
	    ($first eq 1);
	$count=0;
	$first=0;
	$id= $2;
	print "<pCount n='$1' text='$id' ";
    }
    else
    {  chop; $f1 = $_;
       $f2= $id . '-' . $1 . '.jpg';
#	print "convert $f1 $f2\n";
       $count++;
    }
   }
print "count='$count'\/>\n<\/pages>\n";
