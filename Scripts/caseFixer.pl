while (<>) {
    if (/text/ .. /\/text>/) {
    s/([A-Z])([A-Z]+)/$1\L$2/g;
    }
    print;
}
