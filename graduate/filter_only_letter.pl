open IN,'word2exp.txt_out';
open OUT,'>','word2exp.txt_out.filter';

while($line=<IN>) {
	chomp $line;
	if($line=~/[a-zA-Z\-\+]+ /){
		print $line."\n";
	}else{
		print OUT $line."\n";
	}
}
print OUT "##\n";
close(IN,OUT);