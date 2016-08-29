######################################################
#
#   2016.08.29 quqin
#   得到template中所有词典slot的词典文件路径
#
######################################################

$rootdir="./app/search/audio/pattern/data/";

opendir(DIR, $rootdir|| die "can't open this $rootdir");
my @dirs = readdir(DIR);
closedir(DIR);

foreach $domain(@dirs){
    if(!($domain=~/\./)){
        print $domain."\n";
    }
}