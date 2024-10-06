import 'package:image_picker/image_picker.dart';

abstract class ProfileState {
  const ProfileState();
}

// حالة التحميل
class ProfileLoadingState extends ProfileState {
  const ProfileLoadingState();
}

// حالة تحتوي على صورة البروفايل
class ProfileLoadedState extends ProfileState {
  final String? profileImageUrl;

  const ProfileLoadedState({this.profileImageUrl});
}

// حالة تحتوي على الصورة التي تم اختيارها
class ProfileImagePickedState extends ProfileState {
  final XFile image;

  const ProfileImagePickedState(this.image);
}

// حالة الخطأ
class ProfileErrorState extends ProfileState {
  final String message;

  const ProfileErrorState(this.message);
}
