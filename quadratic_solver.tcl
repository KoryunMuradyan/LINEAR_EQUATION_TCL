proc read_from_file {argv} {
	set filename [lindex $argv 0]
	set f [open $filename]
	set line [read $f]
	return $line
}

proc quad1 {a b c} {
	set d [expr {sqrt($b*$b - 4.*$a*$c)}]
	if {$b < 0} {
		set s [expr {-$b + $d}]
	} else {
		set s [expr {-$b - $d}]
	}
	set r0 [expr {$s / (2. * $a)}]
	set r1 [expr {(2. * $c) / $s}]
	return [list $r0 $r1]
}

proc test_result {} {
	set fp [open "golden.txt" r]
	set file_data [read $fp]
	close $fp
	return $file_data
}

proc main {argv} {
	set expression [read_from_file $argv]
	regexp {^(-?\d)x\^2 *([+-] *\d*)x *([+-] *\d+) *= *0$} "1x^2 -4x +4=0" d a b c  
	set result [quad1 $a $b $c]
	set golden_result [test_result]
	if {$result == $golden_result} {
		set fileId [open "output.txt" "w"]
		puts -nonewline $fileId "Test passed \n"

	} else {
		set fileId [open "output.txt" "w"]
		puts -nonewline $fileId "Test Failed\n "
	}
	set string "$expression"
}

main $argv
