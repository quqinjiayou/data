######################################################
#
#   2016.08.29 quqin
#   �õ�template�����дʵ�slot�Ĵʵ��ļ�·��
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