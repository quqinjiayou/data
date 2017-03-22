#w2v输出文件 作为输入 得到纯文本，分词,本脚本用来挑选和原词条词性相同的扩展项

open IN,'vec_expanded.txt_out';
open OUT,'>','vec_expanded.txt.filter';

$pos="";
$org="";
$w="";
while($line=<IN>){
	chomp $line;
	if($line=~/#\S+/){
		if(length $org>0 and length $w>0){
			print OUT $org."\n".$w;
		}
		$w="";
		@arr=$line=~/(\S+)\/\S+/g;
		$line=join("",@arr);
		$org=$line;
		$line=<IN>;
		chomp $line;
		@arr=$line=~/\S+\/(\S+)/g;	
		$pos=join("",@arr);
	}else{
		@arr=$line=~/(\S+)\/\S+/g;
		$w1=join("",@arr);
		@arr=$line=~/\S+\/(\S+)/g;
		$p=join("",@arr);
		if($p eq $pos){
			$w.=$w1."\n";
		}
	}
}
close(IN,OUT);