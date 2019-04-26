#!/usr/bin/perl
use strict;
use warnings;
use experimental 'smartmatch';
use Switch;
use feature "switch";
use IO::Handle;

print ("\n..............\t\t\tWelcome to Perl Stubs\t\t\t..............\n\n");
print ("\n..............\tFollow the conventions to obatin the best results\t..............\n\n\n");

my $translated;
my $result;
my $return_value;

Initializer();

sub Initializer {
	my $extracter;
	my @output;
	my @input;
	my @final_output;
	my $line;
	my $n = "0"; 
	my $source = "<Desired file path>";
	open (DATA, "<", $source) or die "Could not find the file $!";
	foreach $line (<DATA>)  {   
    	chomp $line;
    	$extracter = $line; 
    	$n++; 
	print "$n ---> \t$line\n"; 
    	@input = split(" ",$extracter);
    	push (@output , Input(@input));
    
	}
	close DATA;
	@final_output = qw(PERL STUBS FOR GIVEN INPUT);
	print ("\n@final_output\n@output\n");
}



sub Input {
	
	if ($_[0] =~ /[[:alpha:]]/ ) {
		my @output_operation = Operation(@_);
		return @output_operation;
	} else {
		my $output_operation = "Something is wrong in input : @_";
		return $output_operation;
	}
}

sub Operation {
	my $result;
	my @operation_output;
	my $check;
	my @control_stmts = qw(if ifelse elseif switch);
	my @control_loops = qw(for foreach while dowhile);
	foreach my $Each_Element_Input (@_) {
	    if ($Each_Element_Input =~ /[[:alpha:]]/) {
	        if ($Each_Element_Input ~~ @control_loops) {
	        	$check = CheckForSymbols($_[2]);
	        	if ($check ne "0") {
	        		$result = Control_Loops(@_);
	        	} elsif ($Each_Element_Input eq "foreach") {
	        		$result = Control_Loops(@_);
	        	} else {
	        		$result = "\nSymbol Not identified\n";
	        	}
	            push(@operation_output,"$result");
	            last;
	        } elsif ($Each_Element_Input ~~ @control_stmts) {
	        	$check = CheckForSymbols($_[2]);
	        	if ($check ne "0") {
	        		$result = Control_Statements(@_);
	        	} else {
	        		$result = "\nSymbol Not identified\n";
	        	}
	            push(@operation_output,"$result");
	            last;
	        } else {
	        	$Each_Element_Input = CheckWhetherStringOrNumber($Each_Element_Input);
	            push(@operation_output,"$Each_Element_Input");
	        }
	    } else {
	    	if ($Each_Element_Input eq ";") {
	    		push(@operation_output,"$Each_Element_Input\n\n");
	    	} else  {
	    		push(@operation_output,"$Each_Element_Input");	
	    	}
	        
	    }
	}
    return @operation_output;
}

sub Control_Loops {
	my @input = @_;

	switch ( $input[0] ) {

	    case 'for' { $result = FOR($input[1], $input[2], $input[3]) }
	    case 'foreach' { $result = FOREACH($input[1], $input[3]) }
	    case 'while' { $result = WHILE($input[1], $input[2], $input[3]) }
	    case 'dowhile' { $result = DOWHILE($input[1], $input[2], $input[3]) }

	    else { print "Wrong syntax given | Give Syntax in the following format: 
	           Name_Of_Loop Loop_Variable Times_Loop_Should_Run/Variable Array_Variable_(In case of ForEach Loop)" }
	}
	return $result;
}

sub Control_Statements {
	my @input = @_;

	switch ( $input[0] ) {

	    case 'if' { $result = IF($input[1], $input[2], $input[3]) }
	    case 'ifelse' { $result = IFELSE($input[1], $input[2], $input[3]) }
	    case 'elseif' { $result = IFELSEIFELSE($input[1], $input[2], $input[3], $input[4], $input[5], $input[6]) }
	   	case 'switch' { $result = SWITCH($input[1]) }

	    else { print "Wrong syntax given | Give Syntax in the following format:
	           Name_Of_Stmt Stmt_Variable Condition_Symbol Variable/Numeric Second_Variable_(In case of ElseIf Loop) Condition_Symbol_(In case of ElseIf Loop) Variable/Numeric)" }

	}
	return $result;
}

sub CheckWhetherStringOrNumber {
     if ($_[0] =~ /[[:alpha:]]/ ) {
        $return_value = "\$$_[0]" ; 
     } else {
        $return_value = $_[0];
     }
     return $return_value;
} 

sub CheckForSymbols {
	if ($_[0] =~ /[^[:alnum:]]/ ) {
		$return_value = $_[0];
	} else {
		$return_value = "0";
	}
	return $return_value;
}

sub SWITCH {
	
	if ($_[0] =~ /[[:alpha:]]/ ) {
		($translated = qq{
	    switch (\$$_[0]) {
	       case " " {}
	       case " " {}
	       .
	       .
	       .
	       else {}
	   }
    }) =~ s/^ {8}//mg;
	} else {
		$translated = "Given variable is a Number/Symbol | Give variable as Alphanumeric character";
	}
   	return $translated;
}

sub FOR {
    $_[0] = CheckWhetherStringOrNumber ($_[0]);
    $_[2] = CheckWhetherStringOrNumber ($_[2]);

   ($translated = qq{
   for ($_[0] = 0 ; $_[0] $_[1] $_[2] ; $_[0] = $_[0] + 1 ) {
       
   }
   }) =~ s/^ {8}//mg;
   return $translated;
}

sub FOREACH {
   ($translated = qq{
   foreach \$$_[0] ( \@$_[1] ) {
       
   }
   }) =~ s/^ {8}//mg;
   return $translated;
}

sub WHILE {
    $_[0] = CheckWhetherStringOrNumber ($_[0]);
    $_[2] = CheckWhetherStringOrNumber ($_[2]);
    ($translated = qq{
   while ($_[0] $_[1] $_[2]) {
    
    
   } continue {
    $_[0] = $_[0] + 1;
   }
   }) =~ s/^ {8}//mg;
   return $translated;
}

sub DOWHILE {
    $_[0] = CheckWhetherStringOrNumber ($_[0]);
    $_[2] = CheckWhetherStringOrNumber ($_[2]);
    ($translated = qq{
    do {

    $_[0] = $_[0] + 1;
    }
    while ($_[0] $_[1] $_[2]) ;
    }) =~ s/^ {8}//mg;
    return $translated;
}


sub IF {
    $_[0] = CheckWhetherStringOrNumber ($_[0]);
    $_[2] = CheckWhetherStringOrNumber ($_[2]);
    ($translated = qq{
    if ($_[0] $_[1] $_[2]) {
    
    } 
    }) =~ s/^ {8}//mg;
    return $translated;
}

sub IFELSE {
	$_[0] = CheckWhetherStringOrNumber ($_[0]);
    $_[2] = CheckWhetherStringOrNumber ($_[2]);
    ($translated = qq{
    if ($_[0] $_[1] $_[2]) {
    
    
   } else {

   }
    }) =~ s/^ {8}//mg;
    return $translated;
}

sub IFELSEIFELSE {
	$_[0] = CheckWhetherStringOrNumber ($_[0]);
    $_[2] = CheckWhetherStringOrNumber ($_[2]);
    $_[3] = CheckWhetherStringOrNumber ($_[3]);
    $_[5] = CheckWhetherStringOrNumber ($_[5]);
    ($translated = qq{
    if ($_[0] $_[1] $_[2]) {
    
    
   } elsif ($_[3] $_[4] $_[5]){

   } else {

   }
    }) =~ s/^ {8}//mg;
    return $translated;
}

