use Socket; 
use Sys::Hostname;

use HTTP::Request;
use LWP::UserAgent;
$ua=new LWP::UserAgent();
use Encode;

glob %corpus = (
	'综合' , 'http://202.112.195.246:8089/',
	'文学' , 'http://202.112.195.242:8088/',
	'报刊' , 'http://202.112.195.242:8092/',
	'微博', 'http://202.112.195.9:8095/',
	'科技' , 'http://202.112.195.242:8094/',
	'古汉语' , 'http://202.112.195.249:8091/',
	'内部' , 'http://202.112.195.242:717/');

my $host = hostname(); 
my @thisaddr; 
($name,$aliases,$type,$len,@thisaddr)=gethostbyname($host);
$ip=inet_ntoa($thisaddr[0]); 
	
sub get_exm{
	my($name, $input, $page, $pagenum, $window)=@_;
	$url = $corpus{$name}. 'exm?input='. $input. '&pageno='. $page. 
	'&pagenum='. $pagenum. '&window='. $window. '&ip='. $ip;

	$url_utf8=decode("utf8",$url);
	$url=encode("gbk",$url_utf8);
	$request=new HTTP::Request('GET',$url);
	$response=$ua->request($request);
	return $response->content;
}

sub get_num{
	my($name, $input)=@_;
	$content = get_exm($name, $input, 0, 20, 5);
	if($content=~/<Total>(\d+)<\/Total>.*/){
		$totalnum=$1;
	}else{
		print "no result or connect failed!";
	}
	return $totalnum; #return 总数;
}

sub get_instance{
	my($name, $input, $page, $pagenum, $window)=@_;
	$content = get_exm($name, $input, $page, $pagenum, $window);
 	%results=();
	$content =~ s/^\s+|\s+$//g; #删除字符串两端的空白
 	@answer_array=$content=~/<ID>(.+)/g;
   	for($i=0; $i<@answer_array; $i++){
 		if($answer_array[$i]=~/<T>(.+)<\/T>/){
			$results{$1}++;
		}
   	}
	@answer_array=();
 	return %results;  #return 哈希("序号" => "实例");
}

sub get_freq{
	my($name, $input, $page, $pagenum, $sort)=@_;
	$url = $corpus{$name}. 'freq?input='. $input. '&pageno='. $page. 
	'&pagenum='. $pagenum. '&sort='. $sort;
	$url_utf8=decode("utf8",$url);
	$url=encode("gbk",$url_utf8);
	
	$request=new HTTP::Request('GET',$url);
	$response=$ua->request($request);
	$content = $response->content;

	if($content=~/<\/Sort>(.*)/){
		$result=$1;
		#@result=$1=~/(\S+\s+\S+)/g;
	}print $result."\n";
	$result =~ s/^\s+|\s+$//g; #删除字符串两端的空白
	
 	@answer_array=split("\n",$result);
 	%results=();		 	
   	for($i=0; $i<@answer_array; $i++){
		@foo = split("\t", $answer_array[$i]);
		$word = $foo[0];
		$freq = $foo[1];
		$results{$word} = $freq;print $word." ".$freq."\n";
   	}
	return %results; #return 哈希("词" => "词频");
}