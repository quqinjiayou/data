######################################################
#
#   2016.11.15 quqin
#   �ϲ�ͬ��ĳ���
#
######################################################

$infile="defexpand.txt";
$outfile=$infile.".m";

open IN,$infile;
open OUT,'>$outfile';

$idiom="";
$sameTag="";
$same="";

%hash_key=(); #��ʹ����-��ʹ����/ʹ������
%hash_pass=(); #����������ͬ�� pass

#step1:�����õ�pass dict
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
    }elsif($line=~/^��$/ or $line=~/^ͬ$/ ){
        $same=<IN>;
        chomp $same;
    }
}

close(IN,OUT);