import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:food_ordering_app/Cubit/profile%20cubit/profile_states.dart';
import 'package:image_picker/image_picker.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ImagePicker imagePicker = ImagePicker();

  ProfileCubit() : super(const ProfileLoadingState()) {
    loadProfileImage();
  }

  Future<void> loadProfileImage() async {
    emit(const ProfileLoadingState());

    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userDoc =
            FirebaseFirestore.instance.collection('user_app').doc(user.uid);
        final docSnapshot = await userDoc.get();
        final data = docSnapshot.data();

        if (data != null && data['profileImage'] != null) {
          emit(ProfileLoadedState(profileImageUrl: data['profileImage']));
        } else {
          emit(ProfileLoadedState()); // لا يوجد صورة
        }
      } else {
        emit(const ProfileErrorState('User not logged in'));
      }
    } catch (e) {
      emit(ProfileErrorState(e.toString()));
    }
  }

  Future<void> pickImage() async {
    try {
      final pickedFile =
          await imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        emit(ProfileImagePickedState(pickedFile));
        await uploadAndSaveImage();
      } else {
        emit(const ProfileErrorState("No image selected."));
      }
    } catch (e) {
      emit(ProfileErrorState(e.toString()));
    }
  }

  Future<void> uploadAndSaveImage() async {
    emit(const ProfileLoadingState());

    try {
      if (state is ProfileImagePickedState) {
        final image = (state as ProfileImagePickedState).image;
        final imageUrl = await uploadImage(image);
        if (imageUrl != null) {
          await saveImageUrlToFirestore(imageUrl);
          emit(ProfileLoadedState(profileImageUrl: imageUrl));
        } else {
          emit(const ProfileErrorState("Failed to upload image."));
        }
      }
    } catch (e) {
      emit(ProfileErrorState(e.toString()));
    }
  }

  Future<String?> uploadImage(XFile image) async {
    try {
      final storageRef = FirebaseStorage.instance.ref();
      final imageRef = storageRef.child('images/${image.name}');
      final uploadTask = imageRef.putFile(File(image.path));
      final snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      print("Error uploading image: $e");
      return null;
    }
  }

  Future<void> saveImageUrlToFirestore(String imageUrl) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userDoc =
            FirebaseFirestore.instance.collection('user_app').doc(user.uid);
        await userDoc.set({
          'profileImage': imageUrl,
        }, SetOptions(merge: true));
      }
    } catch (e) {
      print("Error saving image URL to Firestore: $e");
    }
  }
}
