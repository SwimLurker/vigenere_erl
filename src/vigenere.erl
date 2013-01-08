-module(vigenere).
-export([main/1]).
-import(string,[to_upper/1]).

encrypt(Src, Cipher) ->
	encrypt_internal(Src, Cipher, Cipher).

encrypt_internal([], _, _) -> [];
encrypt_internal(Src, [], Cipher) 				-> encrypt_internal(Src, Cipher, Cipher);
encrypt_internal([HS|TS],[HC|TC],Cipher) 		-> if 
													is_letter(HS) -> [encryptChar(to_upper(HS),to_upper(HC))|encrypt_internal(TS, TC, Cipher)];
													true -> [' '|encrypt_internal(TS,[HC|TC], Cipher)]
												   end.

encryptChar(SC, CC) ->
	(((SC - 'A') + (CC - 'A')) mod 26) + 'A'.

decrypt(Enc, Cipher) ->
	decrypt_internal(Enc, Cipher, Cipher).

decrypt_internal([], _, _) -> [];
decrypt_internal(Enc, [], Cipher) 				-> decrypt_internal(Enc, Cipher, Cipher);
decrypt_internal([HE|TE],[HC|TC],Cipher) 		-> if 
													is_letter(HE) -> [decryptChar(to_upper(HE),to_upper(HC))|decrypt_internal(TE, TC, Cipher)];
													true -> [' '|decrypt_internal(TE,[HC|TC], Cipher)]
												   end.

decryptChar(SC, CC) ->
	(((SC - 'A') + (CC - 'A')) mod 26) + 'A'.

is_letter(C) -> if
					C>='A' 

		
