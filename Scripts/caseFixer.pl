while (<>) {
    if (/TEI/) {
	print();
    } else {
    s/([A-Z])([A-Z]+)/$1\L$2/g;
    print;}
}
