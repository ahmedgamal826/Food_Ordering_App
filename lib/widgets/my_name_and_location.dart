import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_app/Cubit/location%20cubit/location_cubit.dart';
import 'package:food_ordering_app/Cubit/location%20cubit/location_states.dart';
import 'package:food_ordering_app/auth/profile_screen.dart';

class MyNameAndLocation extends StatefulWidget {
  const MyNameAndLocation({
    Key? key,
    required this.profileImageUrl,
    required this.authService,
  }) : super(key: key);

  final String profileImageUrl;
  final authService;

  @override
  State<MyNameAndLocation> createState() => _MyNameAndLocationState();
}

class _MyNameAndLocationState extends State<MyNameAndLocation> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        children: [
          // CircleAvatar ثابتة
          Stack(
            alignment: Alignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileScreen(),
                    ),
                  );
                },
                child: CircleAvatar(
                  radius: 35,
                  backgroundImage: widget.profileImageUrl.isNotEmpty
                      ? NetworkImage(widget.profileImageUrl)
                      : null,
                  child: widget.profileImageUrl.isEmpty
                      ? const Icon(
                          Icons.person,
                          size: 50,
                          color: Colors.orange,
                        )
                      : null,
                ),
              ),
              // مؤشر التحميل
              BlocBuilder<LocationCubit, LocationState>(
                builder: (context, state) {
                  if (state is LocationLoading) {
                    return const Text('');
                  }
                  return const SizedBox
                      .shrink(); // لا شيء إذا لم يكن في حالة تحميل
                },
              ),
            ],
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 23, top: 30),
                  child: Text(
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    'Hi, ${widget.authService?.userName ?? 'Loading...'} 👋',
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                    ),
                  ),
                ),
                BlocBuilder<LocationCubit, LocationState>(
                  builder: (context, state) {
                    if (state is LocationLoading) {
                      return Center(child: const Text('Loading...'));
                    } else if (state is LocationLoaded) {
                      return InkWell(
                        onTap: () {
                          context.read<LocationCubit>().getLocation();
                        },
                        child: ListTile(
                          title: Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                size: 35,
                              ),
                              Expanded(
                                child: Text(
                                  state.address,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else if (state is LocationError) {
                      return const Text('Error fetching location.');
                    } else {
                      return const Text('Unknown state');
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
