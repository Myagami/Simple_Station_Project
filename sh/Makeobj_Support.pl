#!/usr/bin/env perl
use strict;
use warnings;
use Linux::Inotify2;
use AnyEvent; 
#messege

print "--------------------------\n" ;
print "Makeobj Support Tools\n" ;
print "--------------------------\n" ;

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
	print "------------\n" ;
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
	    print "Full Build\n" ;
	    make_run("./") ;
	    print "Icon_png[${mask}]:${p_name}\n";
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

    if($fn =~ /.*png$/){#pngならdatに変える
	$fn = png_to_dat($fn) ;
    }

    system("makeobj_54 pak ../pak/ ${fn}") ;
    system("makeobj_54 pak /home/hayate/simutrans/addons/pak.nippon.test/ ${fn}") ;
    #print "paking:".$fn."\n" ;

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
