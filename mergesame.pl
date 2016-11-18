######################################################
#
#   2016.11.15 quqin
#   合并同义的成语
#
######################################################

$infile="defexpand.txt";
$outfile=$infile.".m";

open IN,$infile;
open OUT,'>$outfile';

$idiom="";
$sameTag="";
$same="";

%hash_key=(); #悲痛欲绝-悲痛欲绝/痛哭流涕
%hash_pass=(); #和其他成语同的 pass

#step1:遍历得到pass dict
$idx=0;
while($line=<IN>){
    chomp $line;
    if($line=~/#(\S+)/){
        if(length $idiom>0){
            $hash_key{}
        }
        if(length $same>0){
            if(defined $hash_key{$same}){
                $hash_key{$same}.="/".$idiom;
            }else{
                $hash_key{$same}.=$$same."/".$idiom;
            }
        }else{
            
        }
        $idiom=$1;
    }elsif($line=~/^见$/ or $line=~/^同$/ ){
        $same=<IN>;
        chomp $same;
    }
}

close(IN,OUT);