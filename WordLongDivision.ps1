#Word Long Division v 1.0
#This program takes the inputs of a particular kind of word puzzle
#and solves it. The puzzle type it solves is based on a
#Word Arithmetic puzzle from Penny Dell Puzzles.

#query the user for the full set of letters, the dividend, the divisor, the quotient, and the remainder strings
$fullSet = Read-Host -Prompt 'Input the ten-letter string'
$divd= Read-Host -Prompt 'Input the dividend string'
$divr= Read-Host -Prompt 'Input the divisor string'
$quot= Read-Host -Prompt 'Input the quotient string'
$rema= Read-Host -Prompt 'Input the remainder string'

#instantiate an array to hold the index of each iteration of the main algorithm
[int[]] $compIndex=-1,-1,-1,-1,-1,-1,-1,-1,-1,-1;

#instantiate values for the quotient, the remainder, the divisor, and the dividend
$divdv=0;
$divrv=0;
$quotv=0;
$remav=0;

#Build indices for divd divr quot rema
#start by calculating the position of $divd[0] on $fullset
$divdIndex=@(1..$divd.Length);
for ($x=0; $x -lt $divd.Length; $x++) {
  #then, for each from 1 to n-1 members of divd, append the index value to the index
  $divdIndex[$x]=($fullSet | Select-String $divd[$x]).Matches.Index;
}

#repeat for the other 3 strings
$divrIndex=@(1..$divr.length);
for ($x=0; $x -lt $divr.length; $x++) {
  $divrIndex[$x]=($fullSet | Select-String $divr[$x]).Matches.Index;
}

$quotIndex=@(1..$quot.length);
for ($x=0; $x -lt $quot.length; $x++) {
  $quotIndex[$x]=($fullSet | Select-String $quot[$x]).Matches.Index;
}

$remaIndex=@(1..$rema.length);
for ($x=0; $x -lt $rema.length; $x++) {
  $remaIndex[$x]=($fullSet | Select-String $rema[$x]).Matches.Index;
}

# start the loop for the first variable going 0 to 9
#double letter variables are for indexing and do not correspond to letters in the input
for ($aa=0; $aa -lt 10; $aa++) {
  #Use write-progress to tell the user the approximate percentage completed

  $percaa=10*$aa;
  Write-Progress -Activity Updating -Status 'Progress->' -PercentComplete $percaa -CurrentOperation AALoop;

  # do the same for the second variable, but continue if bb is equal to aa

  for ($bb=0; $bb -lt 10; $bb++) {
    #Use write-progress to give inner loop information as well
    $percbb=10*$bb;
    Write-Progress -Id 1 -Activity Updating -Status 'Progress' -PercentComplete $percbb -CurrentOperation BBLoop
    if ($bb -eq $aa) {
      continue;
    } else {
      
      #etc

      for ($cc=0; $cc -lt 10; $cc++) {
        if (($cc -eq $bb) -OR ($cc -eq $aa)) {
          continue;
        } else {
          
          for ($dd=0; $dd -lt 10; $dd++) {
            if (($dd -eq $cc) -OR ($dd -eq $bb) -OR ($dd -eq $aa)) {
              continue;
            } else {
          
              for ($ee=0; $ee -lt 10; $ee++) {
                if (($ee -eq $dd) -OR ($ee -eq $cc) -OR ($ee -eq $bb) -OR ($ee -eq $aa)) {
                  continue;
                } else {

                  for ($ff=0; $ff -lt 10; $ff++) {
                    if (($ff -eq $ee) -OR ($ff -eq $dd) -OR ($ff -eq $cc) -OR ($ff -eq $bb) -OR ($ff -eq $aa)) {
                      continue;
                    } else {
                    
                      for ($gg=0; $gg -lt 10; $gg++) {
                        if (($gg -eq $ff) -OR ($gg -eq $ee) -OR ($gg -eq $dd) -OR ($gg -eq $cc) -OR ($gg -eq $bb) -OR ($gg -eq $aa)) {
                          continue;
                        } else {

                          for ($hh=0; $hh -lt 10; $hh++) {
                            if (($hh -eq $gg) -OR ($hh -eq $ff) -OR ($hh -eq $ee) -OR ($hh -eq $dd) -OR ($hh -eq $cc) -OR ($hh -eq $bb) -OR ($hh -eq $aa)) {
                              continue;
                            } else {

                              for ($ii=0; $ii -lt 10; $ii++) {
                                if (($ii -eq $hh) -OR ($ii -eq $gg) -OR ($ii -eq $ff) -OR ($ii -eq $ee) -OR ($ii -eq $dd) -OR ($ii -eq $cc) -OR ($ii -eq $bb) -OR ($ii -eq $aa)) {
                                  continue;
                                } else {

                                  for ($jj=0; $jj -lt 10; $jj++) {
                                    if (($jj -eq $ii) -OR ($jj -eq $hh) -OR ($jj -eq $gg) -OR ($jj -eq $ff) -OR ($jj -eq $ee) -OR ($jj -eq $dd) -OR ($jj -eq $cc) -OR ($jj -eq $bb) -OR ($jj -eq $aa)) {
                                      continue;
                                    } else {
                                      
                                      # find the index of this iteration
                                      $compIndex = $aa,$bb,$cc,$dd,$ee,$ff,$gg,$hh,$ii,$jj;
                                      
                                      # then compute the value of the quotient as follows:
                                      # summing over i>N-1, take the products of compIndex[quotIndex[i]] and multiply by 10^i
                                      $quotv=0;
                                      for ($x=($quot.Length)-1; $x -ge 0; $x--) {
                                        $quotv=$quotv+($compIndex[$quotIndex[$x]])*[math]::Pow(10,$quot.Length-($x+1));
                                      }

                                      #repeat for the remainder, the divisor, and the dividend
                                      $remav=0;
                                      for ($x=($rema.Length)-1; $x -ge 0; $x--) {
                                        $remav=$remav+($compIndex[$remaIndex[$x]])*[math]::Pow(10,$rema.Length-($x+1));
                                      }
                                      
                                      $divrv=0;
                                      for ($x=($divr.Length)-1; $x -ge 0; $x--) {
                                        $divrv=$divrv+($compIndex[$divrIndex[$x]])*[math]::Pow(10,$divr.Length-($x+1));
                                      }
                                      
                                      $divdv=0;
                                      for ($x=($divd.Length)-1; $x -ge 0; $x--) {
                                        $divdv=$divdv+($compIndex[$divdIndex[$x]])*[math]::Pow(10,$divd.Length-($x+1));
                                      }
                                      
                                      #if the solution is valid, the quotient times the divisor should equal the dividend minus the remainder
                                      $product = $divrv * $quotv;                                     

                                      # compare and report the values

                                      if ($product -eq ($divdv-$remav)) {
                                        Write-Output ($fullSet + "= " + $compIndex);
                                      }
                                    } #end jjelse
                                  } #end forjj
                                } #end iielse
                              } #end forii
                            } #end hhelse
                          } #end forhh
                        } #end ggelse
                      } #end forgg
                    } #end ffelse
                  } #end forff
                } #end eeelse
              } # end foree
            } #end ddlse
          } # end fordd
        } # end ccelse
      } # end forcc
    } # end bbelse
  } # end forbb
} #end foraa
                              
            
