#############################################################
#
#   得到242内部bcc索引所有释义近义词扩展后是否在BCC中出现
#    原始串BCC_fre=0 pass;else 非0扩展项输出
#   输出 gbk
#
#############################################################


require 'webapi.pl';

open IN,"defexp";
open(OUT,">bcc_defexp_fre");
open(OUT1,">bcc_defexp_zero");

#get_num(语料库名称, 查询词, 页码数, 每页显示数量, 上下文长度)

$idx=0;
$values="";
$values="";
while($line=<IN>){
	chomp $line;
	if($idx%50==0){
		print "...... $idx ......\n";
	}
	$idx++;
	if($line=~/#/){
		print OUT "\n".$line."\n";
		print OUT1 "\n".$line."\n";
	}elsif(length $line>0){
		$total = get_num('内部',$line);
		if($total>0){
			print OUT $line."\t".$total."\n";
		}else{
			print OUT1 $line."\n";
		}
	}
}

close(IN,OUT,OUT1);