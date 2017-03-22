open IN,'idiom.dict_out';
open OUT,'>','def_terms.txt';

%printed=();
while($line=<IN>) {
	chomp $line;
	if($line=~/^#(.+)/){
	}elsif(length $line>0){
		if(!(defined $printed{$line})){
			$printed{$line}++;
			@arr=$line=~/(\S+)\/\S+/g;
			$line=join("",@arr);
			print OUT "$line\n";
		}
	}
}
close(IN,OUT);