#!/usr/bin/perl
package kbot;
use base qw(Bot::BasicBot);
use YAML;

my $bot = kbot->new(
		server => 'irc.saurik.com',
		channels => ['#spam'],
		nick => 'kbot');
our $config = YAML::LoadFile('kbot.yml');

sub reloadop{
	my $temp = YAML::LoadFile('kbot.yml');
	$config = $temp;
}#end of reloadop sub declaration

sub said{
	my($self,$message) =@_;
	if($message->{body} =~ '!reloadcfg'){
		reloadop();
	}#end of reload op
	elsif($message->{body} =~ '!oplist'){
		 our @oparray;
		 our $size;
		foreach(@{$config-> {OP}}){
		push(@oparray,$_);
		$size = @oparray;
		}
		$bot->say(channel => $message->{channel},
			  body => 'The Operators are:'."\n");
		for (;$x < $size;++$x){
		$bot->say(channel => $message->{channel},
			  body => $oparray[$x], address => $message->{who});
		}#end of for loop say op names
	}#end of !oplist
	elsif($message->{body} =~ '!addop'){
		open(FILE,'>>','kbot.yml');
		if(grep { $_ eq $message->{who} } @{ $config->{OP}}){
			my $string = $message->{body};
			$string =~ s/!addop//;
			print FILE '  -'.$string."\n";
			close(FILE);
		}#end of grep
	}#end of !addop
	elsif ($message->{body} =~ '!opme'){
		if(grep { $_ eq $message->{who} } @{ $config->{OP} }){
			$bot->mode("$message->{channel} +o $message->{who}");
		}#end of grep
		else{
			$bot->say(channel => $message->{channel},
				  body => 'You aren\'t in the Operators list.',
				  address => $message->{who}); #made it here /tmp
		}
	}#end of if !opme
	elsif($message->{body} =~ '!dopme'){
		if(grep { $_ eq $message->{who} } @{ $config->{OP}}){
		$bot->mode("$message->{channel} -o $message->{who}");
		}
		else{
			$bot->say(channel => $message->{channel},
				  body => 'You aren\'t an Operator.',
				  address => $message->{who});
		}#end of else
	}#end of if !dopme
	elsif($message->{body} =~ '!gtfo'){
		if(grep { $_ eq $message->{who} } @{ $config->{OP} }){
			$bot->shutdown($bot->quit_message());
		}
		else{
			$bot->say(channel => $message->{channel},
				  body => 'You aren\'t an Operator.',
				  address => $message->{who});
		}
	}#end of if !gtfo
	elsif($message->{body} =~ '!giveop'){
		if(grep { $_ eq $message->{who} } @{ $config->{OP} }){
			my $string;
			$string = $message->{body};
			$string =~ s/!giveop //;
			$bot->mode($message->{channel}.' +o '.$string);
		}
	}
	elsif($message->{body} =~ '!takeop'){
		if(grep { $_ eq $message->{who} } @{ $config->{OP}}){
			my $string;
			$string = $message->{body};
                        $string =~ s/!takeop //;
                        $bot->mode($message->{channel}.' -o '.$string);
		}
	}
	elsif($message->{body} =~ '!hop'){
		if(grep { $_ eq $message->{who} } @{ $config->{OP} }){
			my $string;
			$string = $message->{body};
			$string =~ s/!hop//;
			$bot->mode($message->{channel}.' +h '.$string);
		}
	}
	elsif($message->{body} =~ '!help'){
			$bot->say(
				channel => $message->{$channel}, 
	body => "!addop !dhop !hop !help !takeop !gtfo !dompe !opme !oplist" 
			);
	}
	elsif($message->{body} =~ '!dhop'){
		if(grep { $_ eq $message->{who} } @{ $config->{OP} }){
			my $string;
			$string = $message->{body};
			$string =~ s/!dhop//;
			$bot->mode($message->{channel}.' -h '.$string);
		}
	}

} #end of said
sub chanjoin {
	#my($self,$message) = @_;
	#my $s = @_;
	#my $x = 0;
	#for(;$x<$s;++$x){
	#print  "$x".@_[$x];
	#}
	#you can remove the return if you don't want it to print this everytime some one joins the channel
	#return 'Kbot Online!, ready to do thy bidding my master!';
}
sub help{ return '!addop,!opme,!dopme,!reloadcfg,!giveop,!takeop,!oplist,!gtfo';};
$bot->run();
