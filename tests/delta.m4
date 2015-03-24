
test(<<missing delta arg>>, <<delta>>, ps, <<>>, <<
Missing argument, expected column expression
>>)

test(<<bad delta arg>>, <<delta x>>, ps, <<>>, <<
Bad column expression: x
>>)

test(<<delta>>, <<delta 1,4>>, <<
1 a b 6
3 c d 3
6 e f 1
>>, <<
1	0	a	b	6	0
3	2	c	d	3	-3
6	3	e	f	1	-2
>>, <<>>)

test(<<delta>>, <<delta 1,4>>, <<
1.0 a b 6.0
3.0 c d 3.0
6.0 e f 1.0
>>, <<
1.0	0	a	b	6.0	0
3.0	2.0	c	d	3.0	-3.0
6.0	3.0	e	f	1.0	-2.0
>>, <<>>)
