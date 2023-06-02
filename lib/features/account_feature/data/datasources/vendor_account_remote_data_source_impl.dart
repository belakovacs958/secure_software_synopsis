import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import '../../../../core/error/exceptions.dart';
import '../../../../core/services/firebase_user_service.dart';
import '../../../../core/throw_server_exception.dart';
import '../../../../utils/collection_names.dart';
import '../../domain/entities/vendor_account_entity.dart';
import '../models/vendor_account_model.dart';
import 'vendor_account_remote_data_source.dart';

class VendorAccountRemoteDataSourceImpl implements AccountRemoteDataSource {
  VendorAccountRemoteDataSourceImpl({required this.client});

  final FirebaseAuth firebaseAuthInstance = FirebaseAuth.instance;
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection(USER_COLLECTION);
  final http.Client client;

  @override
  Future<AccountEntity> loginWithEmail(String email, String password) async {
    UserCredential? userCredential;
    AdminAccountModel? person;
    var uid;
    try {
      // Trigger the authentication flow

      final AppleAuthProvider appleProvider = AppleAuthProvider();

      // Once signed in, return the UserCredential
      userCredential =
          await FirebaseAuth.instance.signInWithProvider(appleProvider);
      print('uid: ' + userCredential.user!.uid.toString());
      // Once signed in, return the UserCredential
      if (userCredential.additionalUserInfo?.isNewUser == true) {
        uid = getFirebaseUserUid();

        await userCollection.doc(uid).set(

          {
            'username': 'Apple User',
            'email': 'user@apple.com',
            'uid': uid,
          },
        );

      }
    } on FirebaseException catch (exception) {
      print('error message : ' + exception.message!);
      throwException(exception);
    }
    try {
      if (userCredential?.user != null) {
        await userCollection
            .doc(getFirebaseUserUid())
            .get()
            .then((document) async {
          person = AdminAccountModel.fromJson(
              document.data() as Map<String, dynamic>);
        });

      }
    } on FirebaseException catch (e) {
      print('error message : ' + e.message!);
      throwException(e);
    }

    if (person != null) {
      return person!;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<AccountEntity> registerWithEmail(
      AccountEntity vendorAccountEntity, String password) async {
    UserCredential? userCredential;
    AdminAccountModel? person;
    try {
      userCredential =
          await firebaseAuthInstance.createUserWithEmailAndPassword(
        email: vendorAccountEntity.email,
        password: password,
      );

      await userCollection.add(
        {
          'username': vendorAccountEntity.adminDisplayName,
          'uid': getFirebaseUserUid(),
          'email': vendorAccountEntity.email,
        },
      );

      try {
        if (userCredential.user != null) {
          await userCollection
              .where('uid', isEqualTo: userCredential.user?.uid)
              .get()
              .then((document) async {
            person = AdminAccountModel.fromJson(
                document.docs.first.data() as Map<String, dynamic>);
          });
        }
      } on FirebaseException catch (e) {
        throwException(e);
      }
    } on FirebaseException catch (exception) {
      throwException(exception);
    }

    if (person != null) {
      return person!;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<void> sendEditVendorAccountDetails(
      AccountEntity vendorAccountEntity) async {
    print('delete datasource ran');
    var user = getFirebaseUser();
    try {
      await user.delete();
    } on FirebaseException catch (e) {
      throwException(e);
    }
  }

  @override
  Future<void> sendVendorLogout() async {
    await firebaseAuthInstance.signOut();


  }

  @override
  Future<AccountEntity> facebookLogin() async {
    UserCredential? userCredential;
    AdminAccountModel? person;
    var uid;
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      try {
        userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
      } on PlatformException catch (e) {
        print('exception: ' + e.message!);
      }

      // Once signed in, return the UserCredential
      if (userCredential?.additionalUserInfo?.isNewUser == true) {
        uid = getFirebaseUserUid();
        await userCollection.doc(uid).set(

          {
            'username': userCredential?.user?.displayName,
            'email': userCredential?.user?.email,
            'uid': uid,
          },
        );
      }
    } on FirebaseException catch (exception) {
      throwException(exception);
    }
    try {
      if (userCredential?.user != null) {
        await userCollection
            .doc(getFirebaseUserUid())
            .get()
            .then((document) async {
          person = AdminAccountModel.fromJson(
              document.data() as Map<String, dynamic>);
        });

      }
    } on FirebaseException catch (e) {
      throwException(e);
    }

    if (person != null) {
      return person!;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<AccountEntity> getUserInfo(String uid) async {
    AdminAccountModel? person;
    try {
      print('firebase user uid: ' + getFirebaseUserUid());
      await userCollection
          .doc(getFirebaseUserUid())
          .get()
          .then((document) async {
        print('doc data: ' + document.data().toString());
        person =
            AdminAccountModel.fromJson(document.data() as Map<String, dynamic>);
      });
    } on FirebaseException catch (e) {
      throwException(e);
    }
    if (person != null) {
      return person!;
    } else {
      throw ServerException();
    }
  }
}
