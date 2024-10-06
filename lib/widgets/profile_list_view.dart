import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_app/Cubit/profile%20cubit/profile_cubit.dart';
import 'package:food_ordering_app/Cubit/profile%20cubit/profile_states.dart';
import 'package:food_ordering_app/widgets/profile_buttons.dart';
import 'package:food_ordering_app/widgets/profile_name_and_email.dart';

class ProfileListView extends StatelessWidget {
  final authService;

  const ProfileListView({Key? key, required this.authService})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(),
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          final cubit = context.read<ProfileCubit>();

          return ListView(
            children: [
              const SizedBox(height: 20),
              Stack(
                children: [
                  SelectProfileImage(cubit, state),
                  Positioned(
                    top: 100,
                    bottom: 0,
                    right: 130,
                    child: IconButton(
                      icon: const Icon(
                        Icons.camera_alt,
                        color: Colors.orange,
                        size: 30,
                      ),
                      onPressed: cubit.pickImage,
                    ),
                  ),
                ],
              ),
              if (state is ProfileLoadingState) const SizedBox(height: 20),
              if (state is ProfileLoadingState)
                const Center(
                  child: CircularProgressIndicator(
                    color: Colors.orange,
                  ),
                ),
              if (state is ProfileErrorState)
                Center(
                  child: Text(
                    state.message,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              const SizedBox(
                height: 10,
              ),
              ProfileNameAndEmail(
                authService: authService,
              ),
              const SizedBox(
                height: 5,
              ),
              const ProfileButtons()
            ],
          );
        },
      ),
    );
  }

  InkWell SelectProfileImage(ProfileCubit cubit, ProfileState state) {
    return InkWell(
      onTap: cubit.pickImage,
      child: Center(
        child: CircleAvatar(
          radius: 70,
          backgroundImage: state is ProfileImagePickedState
              ? FileImage(File(state.image.path))
              : state is ProfileLoadedState && state.profileImageUrl != null
                  ? NetworkImage(state.profileImageUrl!)
                  : null,
          child: state is ProfileImagePickedState ||
                  (state is ProfileLoadedState && state.profileImageUrl != null)
              ? null
              : const Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.orange,
                ),
        ),
      ),
    );
  }
}
