open IN,'idiom.dict_out';
open OUT,'>','word2exp.txt';

%words=();
while($line=<IN>) {
	chomp $line;
	if($line=~/^#/){
	}elsif(length $line>0){
		@arr=$line=~/(\S+\/\S+)/g;
		for($i=0;$i<@arr;$i++){
			if($arr[$i]=~/(\S+)\/[^w]+/){
				$word=$1;
				if(length $word>2){
					$words{$word}++;
				}
			}
		}
	}
}

#输出可用来扩展的词表
foreach $k(sort keys %words){
	print OUT $k."\n";
}
#print OUT "##\n";
close(IN,OUT);