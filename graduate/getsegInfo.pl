open IN,'idiom.dict_out';
open OUT,'>','idiom_seg.dict';

while($line=<IN>) {
	chomp $line;
	if($line=~/^#/){
		@arr=$line=~/(\S+)\/\S+/g;
		$line=join("",@arr);
		print OUT "$line\n";
	}elsif(length $line>0){
		@arr=$line=~/(\S+\/\S+)/g;
		$line="";
		for($i=0;$i<@arr;$i++){
			if($arr[$i]=~/(\S+)\/[^w]+/){
				$line.=$1."_";
			}
		}
		chop $line;
		print OUT "$line\n";
	}
}
close(IN,OUT);