open OUT,'>','def_expand.txt';

#step1 加载近义词词典
%dicts=();
$k="";
@v_item=();

open IN,'word2exp.txt_out.filter';
while($line=<IN>){
	chomp $line;
	if($line=~/#(\S+)/){
		if(@v_item>0){
			my @item=@v_item;
			if(!(defined $dicts{$k})){
				$dicts{$k}=\@item;
			}else{
				print $line." aa\n";
			}
			@v_item=();
		}else{
			print $line."\n";
		}
		$k=$1;
	}elsif($line=~/(\S+)\s+/){
		push(@v_item,$1);
	}
}
close(IN);

#step2 加载成语释义分词结果
$org="";
$count=0;

%hash_expd=();
open IN,'idiom.dict_out';
while($line=<IN>){
	chomp $line;
	if($line=~/^#/){
	}elsif(length $line>0){
		my @need_exp=();
		@arr=$line=~/(\S+\/\S+)/g;
		$org=$line;
		for(my $i=0;$i<@arr;$i++){
			if($arr[$i]=~/(\S+)\/[^w]+/){
				$word=$1;
				if(length $word>2){
					push(@need_exp,$1);
				}
			}
		}
		if(@need_exp>0){
			my @expanded=();
			my %printed=();
			push(@expanded,$org);print $org."\n";
			$printed{$org}++;
			for(my $i=0;$i<@need_exp;$i++){#print OUT $i."\n";
				my @arrTmp=();
				for(my $j=0;$j<@expanded;$j++){
					my $k=$need_exp[$i];
					my @candis=@{$dicts{$k}};
					foreach my $one(@candis){
						my $tmp=$expanded[$j];#print OUT $tmp." org\n";
						$tmp=~s/ $k\// $one\//g;
						$tmp=~s/^$k\//$one\//g;#print OUT $tmp." rep key:$k $one\n";
						if(!(defined $printed{$tmp})){
							push(@arrTmp,$tmp);
						}
					}
				}
				@expanded=(@expanded,@arrTmp);
			}
			print OUT "#$org\n";
			shift(@expanded);
			foreach my $one(@expanded){
				print OUT $one."\n";
			}
			#$hash_expd{$org}=\@expanded;
			@need_exp=();
		}
	}
}
close(IN,OUT);

#step3 输出
#foreach $k(sort keys %hash_expd){
#	@items=@{$hash_expd{$k}};print OUT "#$k\n";
#	foreach $v(@items){
#		print OUT $v."\n";
#	}
#}