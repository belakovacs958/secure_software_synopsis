import 'dart:convert';

import 'package:encrypt/encrypt.dart';

String decryptMessage(String message, String key) {
  final decrypter = Encrypter(AES(Key.fromUtf8(key), mode: AESMode.ecb));
  var decrypted = message;

  try {
    decrypted = decrypter.decrypt(Encrypted(base64.decode(message)),
        iv: IV.fromLength(16));
  } catch (e) {
    print(e); //String decodedString = utf8.decode(decrypted);
  }


  message = decrypted;

  return message;
}

String encryptMessage(String key, String message) {
  final encrypter = Encrypter(AES(Key.fromUtf8(key), mode: AESMode.ecb));

  final encrypted = encrypter.encrypt(message, iv: IV.fromLength(16));
  message = encrypted.base64;
  return message;
}
