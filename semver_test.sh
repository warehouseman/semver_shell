#!/usr/bin/env sh

. ./semver.sh

status=0;
count=0
total=0;

False=1;
True=0;

Equal=0;
Greater=1;
Lesser=2;

red='\033[0;31m'
green='\033[0;32m'
nc='\033[0m' # No Color

doTest() {
    local TEST="$1"
    local EXPECTED="$2"
    local ACTUAL="$3"

    if [ "$EXPECTED" = "$ACTUAL" ]; then
        printf "  [${green}Passed${nc}] -- ${TEST} \n"
    else
        status=1
        count=$(( count+1 ))
        printf  "  [${red}FAILED${nc}] -- $TEST: Expected '${EXPECTED}' vs Actual: '${ACTUAL}'\n"
    fi
    total=$(( total+1 ))
}

semverTest() {
local A=R1.3.2
local B=R2.3.2
local C=R1.4.2
local D=R1.3.3
local E=R1.3.2a
local F=R1.3.2b
local G=R1.2.3
local H=1.2.3-a
local I=R2
local J=R2.0
local K=R2.0.0
local L=0.2.79
local M=0.2.79-1-gb78dc84
local N=
local O="x,y,z"


local MAJOR=0
local MINOR=0
local PATCH=0
local SPECIAL=""

local VERSION=""

echo "Parsing"
semverParseInto $A MAJOR MINOR PATCH SPECIAL
doTest "semverParseInto $A -> M m p s" "M:1 m:3 p:2 s:" "M:$MAJOR m:$MINOR p:$PATCH s:$SPECIAL"

semverParseInto $B MAJOR MINOR PATCH SPECIAL
doTest "semverParseInto $B -> M m p s" "M:2 m:3 p:2 s:" "M:$MAJOR m:$MINOR p:$PATCH s:$SPECIAL"

semverParseInto $E MAJOR MINOR PATCH SPECIAL
doTest "semverParseInto $E -> M m p s" "M:1 m:3 p:2 s:a" "M:$MAJOR m:$MINOR p:$PATCH s:$SPECIAL"

semverParseInto $H MAJOR MINOR PATCH SPECIAL
doTest "semverParseInto $H -> M m p s" "M:1 m:2 p:3 s:a" "M:$MAJOR m:$MINOR p:$PATCH s:$SPECIAL"

semverLE $A $A
doTest "semverLE $A $A => True " ${True} $?

semverGE $A $A
doTest "semverGE $A $A => True " ${True} $?


echo "Comparisons"
semverCmp $A $A
doTest "semverCmp $A $A => Equal " ${Equal} $?

semverCmp $A $B
doTest "semverCmp $A $B => Lesser " ${Lesser} $?

semverCmp $B $A
doTest "semverCmp $B $A => Greater " ${Greater} $?

semverCmp $I $K
doTest "semverCmp $I $K => Equal " ${Equal} $?

semverCmp $I $J
doTest "semverCmp $I $J => Equal " ${Equal} $?


echo "Equality comparisons"
semverEQ $A $A
doTest "semverEQ $A $A => True " ${True} $?

semverLT $A $A
doTest "semverLT $A $A => False " ${False} $?

semverGT $A $A
doTest "semverGT $A $A => False " ${False} $?


echo "Major number comparisons"
semverEQ $A $B
doTest "semverEQ $A $B => False " ${False} $?

semverLT $A $B
doTest "semverLT $A $B => True " ${True} $?

semverGT $A $B
doTest "semverGT $A $B => False " ${False} $?

semverLE $A $B
doTest "semverLE $A $B => True " ${True} $?

semverGE $A $B
doTest "semverGE $A $B => False " ${False} $?

semverEQ $B $A
doTest "semverEQ $B $A => False " ${False} $?

semverLT $B $A
doTest "semverLT $B $A => False " ${False} $?

semverGT $B $A
doTest "semverGT $B $A => True " ${True} $?

semverLE $B $A
doTest "semverLE $B $A => False " ${False} $?

semverGE $B $A
doTest "semverGE $B $A => True " ${True} $?


echo "Minor number comparisons"
semverEQ $A $C
doTest "semverEQ $A $C => False " ${False} $?

semverLT $A $C
doTest "semverLT $A $C => True " ${True} $?

semverGT $A $C
doTest "semverGT $A $C => False " ${False} $?

semverLE $A $C
doTest "semverLE $A $C => True " ${True} $?

semverGE $A $C
doTest "semverGE $A $C => False " ${False} $?

semverEQ $C $A
doTest "semverEQ $C $A => False " ${False} $?

semverLT $C $A
doTest "semverLT $C $A => False " ${False} $?

semverGT $C $A
doTest "semverGT $C $A => True " ${True} $?

semverLE $C $A
doTest "semverLE $C $A => False " ${False} $?

semverGE $C $A
doTest "semverGE $C $A => True " ${True} $?

echo "Patch number comparisons"
semverEQ $A $D
doTest "semverEQ $A $D => False " ${False} $?

semverLT $A $D
doTest "semverLT $A $D => True " ${True} $?

semverGT $A $D
doTest "semverGT $A $D => False " ${False} $?

semverLE $A $D
doTest "semverLE $A $D => True " ${True} $?

semverGE $A $D
doTest "semverGE $A $D => False " ${False} $?

semverEQ $D $A
doTest "semverEQ $D $A => False " ${False} $?

semverLT $D $A
doTest "semverLT $D $A => False " ${False} $?

semverGT $D $A
doTest "semverGT $D $A => True " ${True} $?


echo "Special section vs no special comparisons"
semverEQ $A $E
doTest "semverEQ $A $E => False " ${False} $?

semverLT $A $E
doTest "semverLT $A $E => True " ${True} $?

semverGT $A $E
doTest "semverGT $A $E => False " ${False} $?

semverLE $A $E
doTest "semverLE $A $E => True " ${True} $?

semverGE $A $E
doTest "semverGE $A $E => False " ${False} $?

echo "";
semverEQ $E $A
doTest "semverEQ $E $A => False " ${False} $?

semverLT $E $A
doTest "semverLT $E $A => False " ${False} $?

semverGT $E $A
doTest "semverGT $E $A => True " ${True} $?

semverLE $E $A
doTest "semverLE $E $A => False " ${False} $?

semverGE $E $A
doTest "semverGE $E $A => True " ${True} $?


echo "Special section vs special comparisons"
semverEQ $E $F
doTest "semverEQ $E $F => False " ${False} $?

semverLT $E $F
doTest "semverLT $E $F => True " ${True} $?

semverGT $E $F
doTest "semverGT $E $F => False " ${False} $?

semverLE $E $F
doTest "semverLE $E $F => True " ${True} $?

semverGE $E $F
doTest "semverGE $E $F => False " ${False} $?

echo "";
semverEQ $F $E
doTest "semverEQ $F $E => False " ${False} $?

semverLT $F $E
doTest "semverLT $F $E => False " ${False} $?

semverGT $F $E
doTest "semverGT $F $E => True " ${True} $?

semverLE $F $E
doTest "semverLE $F $E => False " ${False} $?

semverGE $F $E
doTest "semverGE $F $E => True " ${True} $?

echo "";
echo "";
semverEQ $A $F
doTest "semverEQ $A $F => False " ${False} $?

semverLT $A $F
doTest "semverLT $A $F => True " ${True} $?

semverGT $A $F
doTest "semverGT $A $F => False " ${False} $?

semverLE $A $F
doTest "semverLE $A $F => True " ${True} $?

semverGE $A $F
doTest "semverGE $A $F => False " ${False} $?

echo " ";
semverEQ $F $A
doTest "semverEQ $F $A => False " ${False} $?

semverLT $F $A
doTest "semverLT $F $A => False " ${False} $?

semverGT $F $A
doTest "semverGT $F $A => True " ${True} $?

semverLE $F $A
doTest "semverLE $F $A => False " ${False} $?

semverGE $F $A
doTest "semverGE $F $A => True " ${True} $?


echo " ";
echo " ";
semverEQ $L $M
doTest "semverEQ $L $M => False " ${False} $?

semverLT $L $M
doTest "semverLT $L $M => True " ${True} $?

semverGT $L $M
doTest "semverGT $L $M => False " ${False} $?

semverLE $L $M
doTest "semverLE $L $M => True " ${True} $?

semverGE $L $M
doTest "semverGE $L $M => False " ${False} $?

echo "";
semverEQ $M $L
doTest "semverEQ $M $L => False " ${False} $?

semverLT $M $L
doTest "semverLT $M $L => False " ${False} $?

semverGT $M $L
doTest "semverGT $M $L => True " ${True} $?

semverLE $M $L
doTest "semverLE $M $L => False " ${False} $?

semverGE $M $L
doTest "semverGE $M $L => True " ${True} $?



echo "Minor and patch number comparisons"
semverEQ $A $G
doTest "semverEQ $A $G => False " ${False} $?

semverLT $A $G
doTest "semverLT $A $G => False " ${False} $?

semverGT $A $G
doTest "semverGT $A $G => True " ${True} $?

semverLE $A $G
doTest "semverLE $A $G => False " ${False} $?

semverGE $A $G
doTest "semverGE $A $G => True " ${True} $?

semverEQ $G $A
doTest "semverEQ $G $A => False " ${False} $?

semverLT $G $A
doTest "semverLT $G $A => True " ${True} $?

semverGT $G $A
doTest "semverGT $G $A => False " ${False} $?


echo "Bumping major"
semverBumpMajor $A VERSION
doTest "semverBumpMajor $A" "2.0.0" $VERSION

semverBumpMajor $E VERSION
doTest "semverBumpMajor $E" "2.0.0" $VERSION


echo "Bumping minor"
semverBumpMinor $A VERSION
doTest "semverBumpMinor $A" "1.4.0" $VERSION

semverBumpMinor $E VERSION
doTest "semverBumpMinor $E" "1.4.0" $VERSION


echo "Bumping patch"
semverBumpPatch $A VERSION
doTest "semverBumpPatch $A" "1.3.3" $VERSION

semverBumpPatch $E VERSION
doTest "semverBumpPatch $E" "1.3.3" $VERSION


echo "Strip special"
semverStripSpecial $A VERSION
doTest "semverStripSpecial $A" "${A#R}" $VERSION

semverStripSpecial $E VERSION
doTest "semverStripSpecial $E" "${A#R}" $VERSION

echo "Input Validations"
semverGT $A $N
doTest "semverGT $A $N => True " ${True} $?

semverGT $A $O
doTest "semverGT $A $O => True " ${True} $?

# Test that CI fails red
# semverGT $A $A
# doTest "semverGT $A $A => True " ${True} $?

}

semverTest

[ ${count} -lt 1 ] && col=${green} || col=${red}
[ ${count} -eq 1 ] && msg="was 1 failure" || msg="were ${count} failures"

printf "\n${col}There %s in %s tests.${nc}\n" "${msg}" "${total}"

echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
exit $status
