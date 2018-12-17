
%macro test_binStrToBase32;

	%local binStr;

	%lbreak(1 char);

	%let binStr=00000;
	%assertEqual(a=%str(0),b=%binStrToBase32(&binStr),msg=%quote(binStrToBase32(&binStr)));

	%let binStr=00001;
	%assertEqual(a=%str(1),b=%binStrToBase32(&binStr),msg=%quote(binStrToBase32(&binStr)));

	%let binStr=00010;
	%assertEqual(a=%str(2),b=%binStrToBase32(&binStr),msg=%quote(binStrToBase32(&binStr)));

	%let binStr=00011;
	%assertEqual(a=%str(3),b=%binStrToBase32(&binStr),msg=%quote(binStrToBase32(&binStr)));

	%let binStr=00100;
	%assertEqual(a=%str(4),b=%binStrToBase32(&binStr),msg=%quote(binStrToBase32(&binStr)));

	%let binStr=00101;
	%assertEqual(a=%str(5),b=%binStrToBase32(&binStr),msg=%quote(binStrToBase32(&binStr)));

	%let binStr=00110;
	%assertEqual(a=%str(6),b=%binStrToBase32(&binStr),msg=%quote(binStrToBase32(&binStr)));

	%let binStr=00111;
	%assertEqual(a=%str(7),b=%binStrToBase32(&binStr),msg=%quote(binStrToBase32(&binStr)));

	%let binStr=01000;
	%assertEqual(a=%str(8),b=%binStrToBase32(&binStr),msg=%quote(binStrToBase32(&binStr)));

	%let binStr=01001;
	%assertEqual(a=%str(9),b=%binStrToBase32(&binStr),msg=%quote(binStrToBase32(&binStr)));

	%let binStr=01010;
	%assertEqual(a=%str(A),b=%binStrToBase32(&binStr),msg=%quote(binStrToBase32(&binStr)));

	%let binStr=01011;
	%assertEqual(a=%str(B),b=%binStrToBase32(&binStr),msg=%quote(binStrToBase32(&binStr)));

	%let binStr=01100;
	%assertEqual(a=%str(C),b=%binStrToBase32(&binStr),msg=%quote(binStrToBase32(&binStr)));

	%let binStr=01101;
	%assertEqual(a=%str(D),b=%binStrToBase32(&binStr),msg=%quote(binStrToBase32(&binStr)));

	%let binStr=01110;
	%assertEqual(a=%str(E),b=%binStrToBase32(&binStr),msg=%quote(binStrToBase32(&binStr)));

	%let binStr=01111;
	%assertEqual(a=%str(F),b=%binStrToBase32(&binStr),msg=%quote(binStrToBase32(&binStr)));

	%let binStr=10000;
	%assertEqual(a=%str(G),b=%binStrToBase32(&binStr),msg=%quote(binStrToBase32(&binStr)));

	%let binStr=10001;
	%assertEqual(a=%str(H),b=%binStrToBase32(&binStr),msg=%quote(binStrToBase32(&binStr)));

	%let binStr=10010;
	%assertEqual(a=%str(J),b=%binStrToBase32(&binStr),msg=%quote(binStrToBase32(&binStr)));

	%let binStr=10011;
	%assertEqual(a=%str(K),b=%binStrToBase32(&binStr),msg=%quote(binStrToBase32(&binStr)));

	%let binStr=10100;
	%assertEqual(a=%str(L),b=%binStrToBase32(&binStr),msg=%quote(binStrToBase32(&binStr)));

	%let binStr=10101;
	%assertEqual(a=%str(N),b=%binStrToBase32(&binStr),msg=%quote(binStrToBase32(&binStr)));

	%let binStr=10110;
	%assertEqual(a=%str(P),b=%binStrToBase32(&binStr),msg=%quote(binStrToBase32(&binStr)));

	%let binStr=10111;
	%assertEqual(a=%str(Q),b=%binStrToBase32(&binStr),msg=%quote(binStrToBase32(&binStr)));

	%let binStr=11000;
	%assertEqual(a=%str(R),b=%binStrToBase32(&binStr),msg=%quote(binStrToBase32(&binStr)));

	%let binStr=11001;
	%assertEqual(a=%str(S),b=%binStrToBase32(&binStr),msg=%quote(binStrToBase32(&binStr)));

	%let binStr=11010;
	%assertEqual(a=%str(T),b=%binStrToBase32(&binStr),msg=%quote(binStrToBase32(&binStr)));

	%let binStr=11011;
	%assertEqual(a=%str(U),b=%binStrToBase32(&binStr),msg=%quote(binStrToBase32(&binStr)));

	%let binStr=11100;
	%assertEqual(a=%str(W),b=%binStrToBase32(&binStr),msg=%quote(binStrToBase32(&binStr)));

	%let binStr=11101;
	%assertEqual(a=%str(X),b=%binStrToBase32(&binStr),msg=%quote(binStrToBase32(&binStr)));

	%let binStr=11110;
	%assertEqual(a=%str(Y),b=%binStrToBase32(&binStr),msg=%quote(binStrToBase32(&binStr)));

	%let binStr=11111;
	%assertEqual(a=%str(Z),b=%binStrToBase32(&binStr),msg=%quote(binStrToBase32(&binStr)));


	%lbreak(multi chars);

	%let binStr=1111111110;
	%assertEqual(a=%str(ZY),b=%binStrToBase32(&binStr),msg=%quote(binStrToBase32(&binStr)));

	%let binStr=000001111011011;
	%assertEqual(a=%str(0YU),b=%binStrToBase32(&binStr),msg=%quote(binStrToBase32(&binStr)));

	%lbreak(padding test);

	%let binStr=01111111;
	%assertEqual(a=%str(FW),b=%binStrToBase32(&binStr),msg=%quote(binStrToBase32(&binStr)));

	%let binStr=10011111111101;
	%assertEqual(a=%str(KZT),b=%binStrToBase32(&binStr),msg=%quote(binStrToBase32(&binStr)));

	%let binStr=01111001111;
	%assertEqual(a=%str(F7G),b=%binStrToBase32(&binStr),msg=%quote(binStrToBase32(&binStr)));

	%let binStr=011110011110;
	%assertEqual(a=%str(F7G),b=%binStrToBase32(&binStr),msg=%quote(binStrToBase32(&binStr)));

	%let binStr=0111100111100;
	%assertEqual(a=%str(F7G),b=%binStrToBase32(&binStr),msg=%quote(binStrToBase32(&binStr)));

	%let binStr=01111001111000;
	%assertEqual(a=%str(F7G),b=%binStrToBase32(&binStr),msg=%quote(binStrToBase32(&binStr)));

%mend;

%test_binStrToBase32;
