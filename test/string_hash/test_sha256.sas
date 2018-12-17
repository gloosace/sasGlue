
* https://passwordsgenerator.net/sha256-hash-generator/;

%macro test_sha256;
	
	%local s;

	%let s=%str(goodboy);
	%assertEqual(a=%upcase(3AB8FA69D3458631D1A2727253A277C0145F8554E2D82082FA2B5972E9A15576),b=%sha256(&s),msg=&s);

	%let s=%str( goodboy);
	%assertEqual(a=%upcase(F335A94CD9E6A6DAA61B8B4C607ACCEB476E3FEDC22768A0405A52AEAD940820),b=%sha256(&s),msg=&s);

	%let s=%str(汉字测试);
	%assertEqual(a=%upcase(23F3EA16BE3B43EF1569FA955698169DC28EBD18753C737888FC152B9F663988),b=%sha256(&s),msg=&s);

	%let s=%str(汉字，。测试);
	%assertEqual(a=%upcase(04719AEE06D95DA874FC02A914225DC132F0D8E33D4DDDC5D5CAB05E587E8D4E),b=%sha256(&s),msg=&s);

	%let s=%str("goodboy");
	%assertEqual(a=%upcase(D751ECE1859FA6F67B2C65ABD6DDF142584EB1D37310C3C230373F89B0A2B7C4),b=%sha256(&s),msg=&s);

	%let s=%str('goodboy');
	%assertEqual(a=%upcase(8EBA60228DA53B06E3DC104A14765CC9EFDD9E977D373D1AE7DD18CA127235C5),b=%sha256(&s),msg=&s);

	%let s=%str(%'goodboy%');
	%assertEqual(a=%upcase(8EBA60228DA53B06E3DC104A14765CC9EFDD9E977D373D1AE7DD18CA127235C5),b=%sha256(&s),msg=&s);

%mend;

%test_sha256;
