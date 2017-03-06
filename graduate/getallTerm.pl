open IN,'defexpand.txt';
open OUT,'>','idiom.dict';
open OUT1,'>','synonym.dict';

$idiom;
$def;
%same=();
while ($line=<IN>) {
	chomp $line;
	if($line=~/^#(\S+)/){
		$idiom_tmp=$1;
		if(length $idiom>0){
			@arr=$idiom=~/([^\/]+)/g;
			for($i=0;$i<@arr;$i++){
				print OUT "#".$arr[$i]."\n".$def;
				if(@arr>1){
					$same{$idiom}++;
				}
			}
		}
		$idiom=$idiom_tmp;
		$def="";
	}else{
		$def.=$line."\n";
	}
}

#print synonym dict
foreach $k(sort keys %same){
	@arr=$k=~/([^\/]+)/g;
	for($i=0;$i<@arr;$i++){
		print OUT1 "#".$arr[$i]."\n";
		for($j=0;$j<@arr;$j++){
			if($i!=$j){
				print OUT1 $arr[$j]."\n";
			}
		}
	}
}
close(IN,OUT,OUT1);

