#w2v����ļ� ��Ϊ���� �õ����ı��������ִ�

open IN,'word2exp.txt_out.filter';
open OUT,'>','vec_expanded.txt';

while($line=<IN>){
	chomp $line;
	if($line=~/#(\S+)/){
		print OUT $line."\n";
		print OUT $1."\n";
	}elsif($line=~/(\S+)\s+\S+/){
		print OUT $1."\n";
	}
}
close(IN,OUT);