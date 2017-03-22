open IN,'idiom.dict_out';
open OUT,'>','def_seg.txt';

#%printed=();
$idiom="";
while($line=<IN>) {
	chomp $line;
	if($line=~/^#(.+)/){
		@arr=$1=~/(\S+)\/\S+/g;
		$idiom=join("",@arr);
	}elsif(length $line>0){
		print OUT "$line $idiom/i\n";
	}
}
close(IN,OUT);