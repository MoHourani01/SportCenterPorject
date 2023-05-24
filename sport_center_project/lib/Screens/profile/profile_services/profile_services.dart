import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart' as path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:sport_center_project/models/login_model.dart';



class ProfileService {
  final _firestore = FirebaseFirestore.instance;
  final String collectionName = 'users';
  int statusCode = 0;
  String msg = '';
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future getCurrentUser() async {
    return await _firebaseAuth.currentUser;
  }

  // Future<void> updateProfile(String uid, UserModel model) async {
  //   log('message');
  //   QuerySnapshot querySnapshot = await _firestore
  //       .collection(collectionName)
  //       .where('uid', isEqualTo: uid)
  //       .get();
  //   log('${querySnapshot.docs.length}');
  //   String documentId = querySnapshot.docs[0].id;
  //   await _firestore
  //       .collection(collectionName)
  //       .doc(documentId)
  //       .update(model.toMap())
  //       .whenComplete(() {
  //     log('post data updated successful');
  //     statusCode = 200;
  //     msg = 'post data updated successful';
  //   }).catchError((error) {
  //     handleAuthErrors(error);
  //     log('statusCode : $statusCode , error msg : $msg');
  //   });
  // }

  late Reference firebaseStorageRef;

  Future<String> fileUpload(File file,String valueName) async {
    String result = '';
    firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child('$valueName/${path.basename(file.path)}');
    await firebaseStorageRef.putFile(file).whenComplete(() async {
      await firebaseStorageRef.getDownloadURL().then((value) {
        result = value;
      });
    });
    return result;
  }

  void handleAuthErrors(ArgumentError error) {
    String errorCode = error.message;
    switch (errorCode) {
      case "ABORTED":
        {
          statusCode = 400;
          msg = "The operation was aborted";
        }
        break;
      case "ALREADY_EXISTS":
        {
          statusCode = 400;
          msg = "Some document that we attempted to create already exists.";
        }
        break;
      case "CANCELLED":
        {
          statusCode = 400;
          msg = "The operation was cancelled";
        }
        break;
      case "DATA_LOSS":
        {
          statusCode = 400;
          msg = "Unrecoverable data loss or corruption.";
        }
        break;
      case "PERMISSION_DENIED":
        {
          statusCode = 400;
          msg =
          "The caller does not have permission to execute the specified operation.";
        }
        break;
      default:
        {
          statusCode = 400;
          msg = error.message;
        }
        break;
    }
  }
  final userCollection = FirebaseFirestore.instance.collection('users');

  // UserModel? model;
  // Future getCurrentUserData() async{
  //   try {
  //     DocumentSnapshot ds = await userCollection.doc(model!.uId).get();
  //     String  firstname = ds.get('name');
  //     return [firstname];
  //   }catch(e){
  //     print(e.toString());
  //     return null;
  //   }
  // }
}
