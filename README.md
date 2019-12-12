# word-long-division
This PowerShell script solves a puzzle in which the 10 digits are replaced with distinct letters. The user will provide the strings for the divisor, dividend, quotient, remainder, and the full set of letters. The script finds the mapping that satisfies the puzzle.

For the example (PuzzleExample.JPG), the user would be prompted for:
a. The full ten-letter string (any ordering of acefhkorst will suffice as input)
b. The dividend string (setoffs)
c. The divisor string (that)
d. The quotient string (taro)
e. The remainder string (ctf)

It will then iterate through each set of distinct possible values for the ten letters.
When the dividend minus the remainder equals the product of the divisor and the quotient, the script reports the corresponding digit values in the order of the input string in Part A above.
