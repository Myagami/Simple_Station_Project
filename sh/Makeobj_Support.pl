#!/usr/bin/env perl
use strict;
use warnings;
use Linux::Inotify2;
use AnyEvent; 
use File::Copy ;
#messege

print "+---------------------+\n" ;
print "|Makeobj Support Tools|\n" ;
print "+---------------------+\n" ;

#Start
my $watch_dir = "./" ;
my $inotify = Linux::Inotify2->new or die $!;
#dat
$inotify->watch(
    $watch_dir,
    IN_MODIFY | IN_CREATE ,
    sub {
        my $e    = shift;
        my $d_name = $e->name;
	my $mask = $e->mask ;
	if(!($d_name =~ /.*tmp.*|.*#.*/i)){#テンポラリファイルは無視する
	    my $res = exist_file($d_name) ;
	    if($res ==1){
		#print $res."\n" ;
		make_run($d_name)
	    }else{
		print "Can't Running Makeobj\n" ;
	    }
	}
    }
);
#png
$inotify->watch(
    $watch_dir."png/",
    IN_MODIFY | IN_CREATE ,
    #IN_ATTRIB,
    sub {
        my $e    = shift;
        my $p_name = $e->name;
	my $mask = $e->mask ;
	
        #アイコンファイルか否か
	if(!($p_name =~ /.*icon.*/i )){#ソース
	    my $res = exist_file($p_name) ;
	    if($res ==1){
		#print $res."\n" ;
		make_run($p_name) ;
	    }else{
		print "Can't Running Makeobj\n" ;
	    }
	}else{#アイコン
	    print "Update Icon File\n Next edit fire dat or source_png\n" ;
	}
	print "------------\n" ;
    }
);
 
my $cv = AnyEvent->condvar;
my $inotify_w = AnyEvent->io(
    fh   => $inotify->fileno,
    poll => 'r',
    cb   => sub { $inotify->poll }
);
$cv->recv;

#---------------------------------------------

sub exist_file{#ファイル確認
    my $fn = shift @_ ;
    
    if($fn =~ /.*dat/i){#ファイルチェック
	#dat
	my $p_name = png_to_dat($fn) ;
	#$p_name =~ s/dat/png/g ;
	
	if(-f "png/".$p_name){#ファイル存在確認
	    print "png:".$p_name."\n"  ;
	    print "makeobj running start.\n" ;
	    return 1 ;
	}else{
	    print "png:".$p_name."\n" ;
	    print "Can't makeobj running!!\n" ;
	    return 0 ;
	} 
    }else{
	#png
	my $d_name = png_to_dat($fn) ;
	if(-f $d_name){#ファイル存在確認
	    return 1 ;
	}else{
	    return 0 ;
	}
    }
}

sub make_run{#makeobj
    my $fn = shift @_ ;
    print "Update or Create:".$fn."\n" ;
    if($fn =~ /.*png$/){#pngならdatに変える
	$fn = png_to_dat($fn) ;
    }
    open my $fh_r, "makeobj_54 pak ../pak/ ${fn} 2>&1|";
    print "-"x15 ;
    print "\n" ;
    my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime(time);  
    printf("Run:%04d/%02d/%02d %02d:%02d:%02d \n", $year + 1900, $mon + 1, $mday,$hour,$min,$sec);  
    
    my $f_path = 0 ;#ファイルパス
    my $f_name = 0 ;#ファイルネーム
    my $f_cp = 0 ;#作業フラグ
    
    #データ解析
    while(my $buff = <$fh_r>){
	chomp($buff) ;
	$f_cp = 1 ;
	if($buff =~ /Makeobj version (.*) for Simutrans (.*) and higher/){#バージョン
	    print "Makeobj Version:".$1."\n" ;
	    print "Support Main:".$2."\n" ;
	}elsif($buff =~ /writing invidual files to (.*)/){#書き込み先
	    print "Write File path:".$1."\n" ;
	    $f_path = $1 ;
	}elsif($buff =~ /   writing file (.*)/){
	    $f_name = $1 ;
	    print "Write File to:".$f_name."\n" ;
	    pak_data_copy($f_name,$f_path) ;
	}elsif($buff =~ /writing file (.*)/){
	    $f_name = $1 ;
	    print "Write File to:".$f_name."\n" ;
	    pak_data_copy($f_name,$f_path) ;
	}elsif($buff =~ /WARNING: (.*)$/){#危険
	    print "Warning:".$1."\n" ;
	}elsif($buff =~ /reading file (.*)$/){#危険
	    print "Read From:".$1."\n" ;
	}elsif($buff =~ /packing (.*)$/){#packing
	    print "Packd Data:".$1."\n" ;
	}elsif($buff =~ /Error:: (.*)$/){#危険
	    print "Error:".$1."-\n" ;
	    $f_cp = 0 ;
	}elsif($buff =~ /ERROR IN CLASS (.*): cannot open (.*)/){#危険
	    print "ErrorClass:${1} - Can't open ${2}\n" ;
	    $f_cp = 0 ;
	}
    }
}

sub pak_data_copy{#(f_name,f_path)
    my $f_name = shift @_ ;
    my $f_name_w = $f_name ;
    my $f_path = shift @_ ;
    $f_name_w =~ s/$f_path//g ; 
    my $f_name_r = copy($f_name,"/home/hayate/simutrans/addons/pak.nippon.test/".$f_name_w) ;
    if($f_name_r == 1){
	print "Create pak:".$f_name_w."\n" ;
	print "Copy成功.\n" ;
    }else{
	print "Copy失敗.\n" ;
    }
}

sub png_to_dat{#pngをdatに / datをpngに変換
    my $fn = shift ;
    if($fn =~ /.*png$/g){#png
	$fn =~ s/png/dat/g ;
    }else{#dat
	$fn =~ s/dat/png/g ;
    }
    return $fn ;
}
