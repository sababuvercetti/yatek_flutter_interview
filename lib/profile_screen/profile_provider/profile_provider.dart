import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yatek_interview/profile_screen/profile_provider/profile_state.dart';

final profileProvider =
    StateNotifierProvider<ProfileProvider, ProfileState>((_) {
  return ProfileProvider();
});

class ProfileProvider extends StateNotifier<ProfileState> {
  ProfileProvider() : super(ProfileState.initial());

  void updateProfile() async {
    state = ProfileState.loading();
    try {
      var image = await ImagePicker().pickImage(source: ImageSource.gallery);
      UploadTask task = FirebaseStorage.instance
          .ref(DateTime.now().toString())
          .putFile(File(image!.path));
      var url = await (await task.whenComplete(() => print('Upload complete')))
          .ref
          .getDownloadURL();

      final FirebaseAuth _auth = FirebaseAuth.instance;
      final User user = _auth.currentUser!;
      final String uid = user.uid;
      final FirebaseFirestore _firestore = FirebaseFirestore.instance;
      final DocumentReference ref = _firestore.collection('Profiles').doc(uid);
      final Map<String, dynamic> data = {
        'email': user.email,
        'image': url,
        'timestamp': DateTime.now(),
      };
      state = ProfileState.success();
    } on Exception catch (e) {
      state = ProfileState.error(e.toString());
    }
  }
}
