#!/bin/bash
#usage: ./runSuite.sh [suite-file] [program]
if [ $# -ne 2 ]; then
	echo usage: ./runSuite.sh [suite-file] [program] >&2
	exit 4
fi

for stem in $(cat $1); do
	if ! [ -f ${stem}.expect ] || ! [ -r ${stem}.expect ]; then
		echo ${stem}.expect does not exist or is not readable >&2
		exit 5
	fi

	TEMPFILE=$(mktemp)
	if [ -f ${stem}.args ] && [ -r ${stem}.args ] && [ -f ${stem}.in ] && [ -r ${stem}.in ]; then
		$2 $(cat ${stem}.args) < ${stem}.in > $TEMPFILE
		diff $TEMPFILE ${stem}.expect > /dev/null
		if [ $? -ne 0 ]; then
			echo Test failed: $stem
			echo Args:
			cat ${stem}.args
				echo Input:
				cat ${stem}.in
				echo Expected:
			cat ${stem}.expect
			echo Actual:
			cat $TEMPFILE
		fi
	elif [ -f ${stem}.args ] && [ -r ${stem}.args ]; then
		$2 $(cat ${stem}.args) > $TEMPFILE
		diff $TEMPFILE ${stem}.expect > /dev/null
		if [ $? -ne 0 ]; then
			echo Test failed: $stem
			echo Args:
			cat ${stem}.args
				echo Input:
				echo Expected:
			cat ${stem}.expect
			echo Actual:
			cat $TEMPFILE
		fi
	elif [ -f ${stem}.in ] && [ -r ${stem}.in ]; then
		$2 < ${stem}.in > $TEMPFILE
		diff $TEMPFILE ${stem}.expect > /dev/null
		if [ $? -ne 0 ]; then
			echo Test failed: $stem
			echo Args:
				echo Input:
				cat ${stem}.in
				echo Expected:
			cat ${stem}.expect
			echo Actual:
			cat $TEMPFILE
		fi
	else
		$2 > $TEMPFILE
		diff $TEMPFILE ${stem}.expect > /dev/null
		if [ $? -ne 0 ]; then
			echo Test failed: $stem
			echo Args:
				echo Input:
				echo Expected:
			cat ${stem}.expect
			echo Actual:
			cat $TEMPFILE
		fi
	fi
	rm $TEMPFILE
done
exit 0
