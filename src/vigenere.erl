-module(vigenere).
-export([main/1]).
-import(string,[to_upper/1]).

main(["-e"|[Src|[Cipher]]]) -> io:format("~p~n",[encrypt(Src, Cipher)]);
main(["-d"|[Enc|[Cipher]]]) -> io:format("~p~n",[decrypt(Enc, Cipher)]);
main(_) -> printUsage().

printUsage() -> io:format("Usage: main -e <srouce string> <cipher> //Encrypt source string with the cipher by vigenere algorithm;~n"),
                io:format("       main -d <encrypted string> <cipher> //Decrypt encrypted string with the cipher by vigenere algorithm;~n").

encrypt(Src, Cipher) ->
	encrypt_internal(Src, Cipher, Cipher).

encrypt_internal([], _, _) -> [];
encrypt_internal(Src, [], Cipher) 				-> encrypt_internal(Src, Cipher, Cipher);
encrypt_internal([HS|TS],[HC|TC],Cipher) 		-> if
                          (((HS >= $A) and (HS =< $Z)) or ((HS >= $a) and (HS =< $z)))  -> [encryptChar(to_upper(HS),to_upper(HC))|encrypt_internal(TS, TC, Cipher)];
													true -> [$ |encrypt_internal(TS,[HC|TC], Cipher)]
												   end.

encryptChar(SC, CC) ->
	(((SC - $A) + (CC - $A)) rem 26) + $A.

decrypt(Enc, Cipher) ->
	decrypt_internal(Enc, Cipher, Cipher).

decrypt_internal([], _, _) -> [];
decrypt_internal(Enc, [], Cipher) 				-> decrypt_internal(Enc, Cipher, Cipher);
decrypt_internal([HE|TE],[HC|TC],Cipher) 		-> if
                          (((HE >= $A) and (HE =< $Z)) or ((HE >= $a) and (HE =< $z))) -> [decryptChar(to_upper(HE),to_upper(HC))|decrypt_internal(TE, TC, Cipher)];
													true -> [$ |decrypt_internal(TE,[HC|TC], Cipher)]
												   end.

decryptChar(EC, CC) ->
  (((EC + 26) - CC) rem 26) + $A.
		
