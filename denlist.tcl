set today [clock seconds]
set timeslot {"8:50-10:20" "10:30-12:00" "13:00-14:30" "14:40-16:10" "16:20-17:50"}

proc generate {} {
  global date_from date_to
  .t delete 1.0 end
  set t [clock scan $date_from -format "%m/%d"]
  set n 0
  while 1 {
    set date1 [clock format $t -format "%m/%d"]
    set wod1 [clock format $t -format "(%a)"]
    foreach time [.f2.slot get 1.0 end] {
      .t insert end "$date1$wod1 $time\n"
    }
    incr n
    if {$date1 eq $date_to} break
    if {$n == 100} break
    set t [clock add $t 1 days]
  }
}

frame .f1
label .f1.l1 -text From: 
entry .f1.e1 -textvariable date_from 
label .f1.l2 -text To:
entry .f1.e2 -textvariable date_to
set date_from [clock format $today -format "%m/%d"]
set date_to [clock format [clock add $today 1 weeks] -format "%m/%d"]
button .f1.gen -text Generate -command generate
grid .f1.gen -row 0 -column 0 -columnspan 2
grid .f1.l1 -row 1 -column 0
grid .f1.e1 -row 1 -column 1
grid .f1.l2 -row 2 -column 0
grid .f1.e2 -row 2 -column 1
grid .f1 -row 0 -column 0 
frame .f2
label .f2.l1 -text "Time slots:"
text .f2.slot -width 15 -height 7
pack .f2.l1 .f2.slot -side left
grid .f2 -row 1 -column 0
foreach s $timeslot {
  .f2.slot insert end "$s\n"
}
text .t
grid .t -row 0 -column 1 -sticky news -rowspan 2
