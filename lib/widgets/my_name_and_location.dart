// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:food_ordering_app/Cubit/location%20cubit/location_cubit.dart';
// // import 'package:food_ordering_app/Cubit/location%20cubit/location_states.dart';
// // import 'package:food_ordering_app/auth/profile_screen.dart';
// // import 'package:food_ordering_app/components/loading_dots.dart';

// // class MyNameAndLocation extends StatefulWidget {
// //   const MyNameAndLocation({
// //     Key? key,
// //     required this.profileImageUrl,
// //     required this.authService,
// //   }) : super(key: key);

// //   final String profileImageUrl;
// //   final authService;

// //   @override
// //   State<MyNameAndLocation> createState() => _MyNameAndLocationState();
// // }

// // class _MyNameAndLocationState extends State<MyNameAndLocation> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(horizontal: 16.0),
// //       child: Row(
// //         children: [
// //           Expanded(
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Padding(
// //                   padding: const EdgeInsets.only(top: 30, left: 8),
// //                   child: AnimatedDefaultTextStyle(
// //                     duration: const Duration(milliseconds: 300),
// //                     style: const TextStyle(
// //                       fontSize: 24,
// //                       color: Colors.black,
// //                       fontWeight: FontWeight.bold,
// //                     ),
// //                     child: Text(
// //                       'Hi, ${widget.authService?.userName ?? 'Loading...'} 👋',
// //                       maxLines: 1,
// //                       overflow: TextOverflow.ellipsis,
// //                       textAlign: TextAlign.start,
// //                     ),
// //                   ),
// //                 ),
// //                 BlocBuilder<LocationCubit, LocationState>(
// //                   builder: (context, state) {
// //                     if (state is LocationLoading) {
// //                       return Center(
// //                         child: Padding(
// //                           padding: const EdgeInsets.symmetric(vertical: 10),
// //                           child: LoadingDots(),
// //                         ),
// //                       );
// //                     } else if (state is LocationLoaded) {
// //                       return InkWell(
// //                         onTap: () {
// //                           context.read<LocationCubit>().getLocation();
// //                         },
// //                         onHover: (isHovered) {
// //                           setState(() {});
// //                         },
// //                         child: AnimatedContainer(
// //                           duration: const Duration(milliseconds: 300),
// //                           child: Row(
// //                             children: [
// //                               Icon(
// //                                 Icons.location_on,
// //                                 size: 35,
// //                                 color: Colors.orange,
// //                               ),
// //                               Text(
// //                                 state.address,
// //                                 maxLines: 1,
// //                                 overflow: TextOverflow.ellipsis,
// //                                 style: const TextStyle(
// //                                   fontSize: 18,
// //                                 ),
// //                               )
// //                             ],
// //                           ),
// //                         ),
// //                       );
// //                     } else if (state is LocationError) {
// //                       return const Padding(
// //                         padding: EdgeInsets.symmetric(vertical: 10),
// //                         child: Text('Error fetching location.',
// //                             style: TextStyle(color: Colors.red)),
// //                       );
// //                     } else {
// //                       return const Text('Unknown state');
// //                     }
// //                   },
// //                 ),
// //               ],
// //             ),
// //           ),
// //           InkWell(
// //             onTap: () {
// //               Navigator.push(
// //                 context,
// //                 MaterialPageRoute(
// //                   builder: (context) => const ProfileScreen(),
// //                 ),
// //               );
// //             },
// //             child: Hero(
// //               tag: 'profileImage',
// //               child: CircleAvatar(
// //                 radius: 30,
// //                 backgroundImage: widget.profileImageUrl.isNotEmpty
// //                     ? NetworkImage(widget.profileImageUrl)
// //                     : null,
// //                 child: widget.profileImageUrl.isEmpty
// //                     ? const Icon(
// //                         Icons.person,
// //                         size: 50,
// //                         color: Colors.orange,
// //                       )
// //                     : null,
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:food_ordering_app/Cubit/location%20cubit/location_cubit.dart';
// import 'package:food_ordering_app/Cubit/location%20cubit/location_states.dart';
// import 'package:food_ordering_app/auth/profile_screen.dart';
// import 'package:food_ordering_app/components/loading_dots.dart';
// import 'package:food_ordering_app/utils/my_map_screen.dart';

// class MyNameAndLocation extends StatefulWidget {
//   const MyNameAndLocation({
//     Key? key,
//     required this.profileImageUrl,
//     required this.authService,
//   }) : super(key: key);

//   final String profileImageUrl;
//   final authService;

//   @override
//   State<MyNameAndLocation> createState() => _MyNameAndLocationState();
// }

// class _MyNameAndLocationState extends State<MyNameAndLocation> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       child: Row(
//         children: [
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(top: 30),
//                   child: AnimatedDefaultTextStyle(
//                     duration: const Duration(milliseconds: 300),
//                     style: const TextStyle(
//                       fontSize: 24,
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     child: Text(
//                       'Hi, ${widget.authService?.userName ?? 'Loading...'} 👋',
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                       textAlign: TextAlign.start,
//                     ),
//                   ),
//                 ),
//                 _buildLocation(context),
//               ],
//             ),
//           ),
//           _buildProfileImage(context),
//         ],
//       ),
//     );
//   }

//   Widget _buildLocation(BuildContext context) {
//     return BlocBuilder<LocationCubit, LocationState>(
//       builder: (context, state) {
//         if (state is LocationLoading) {
//           return Center(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(vertical: 10),
//               child: LoadingDots(),
//             ),
//           );
//         } else if (state is LocationLoaded) {
//           return InkWell(
//             onTap: () {
//               context.read<LocationCubit>().getLocation();
//             },
//             child: AnimatedContainer(
//               duration: const Duration(milliseconds: 300),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   IconButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => MyMapScreen(
//                             latitude: state.latitude,
//                             longitude: state.longitude,
//                           ),
//                         ),
//                       );
//                     },
//                     icon: const Icon(
//                       Icons.location_on,
//                       size: 35,
//                       color: Colors.orange,
//                     ),
//                   ),
//                   Expanded(
//                     child: Text(
//                       state.address,
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                       style: const TextStyle(
//                         fontSize: 18,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         } else if (state is LocationError) {
//           return const Padding(
//             padding: EdgeInsets.symmetric(vertical: 10),
//             child: Text(
//               'Error fetching location.',
//               style: TextStyle(color: Colors.red),
//             ),
//           );
//         } else {
//           return const Text('Unknown state');
//         }
//       },
//     );
//   }

//   Widget _buildProfileImage(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => const ProfileScreen(),
//           ),
//         );
//       },
//       child: Hero(
//         tag: 'profileImage',
//         child: CircleAvatar(
//           radius: 30,
//           backgroundImage: widget.profileImageUrl.isNotEmpty
//               ? NetworkImage(widget.profileImageUrl)
//               : null,
//           child: widget.profileImageUrl.isEmpty
//               ? const Icon(
//                   Icons.person,
//                   size: 50,
//                   color: Colors.orange,
//                 )
//               : null,
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_app/Cubit/location%20cubit/location_cubit.dart';
import 'package:food_ordering_app/Cubit/location%20cubit/location_states.dart';
import 'package:food_ordering_app/auth/profile_screen.dart';
import 'package:food_ordering_app/components/loading_dots.dart';
import 'package:food_ordering_app/utils/my_map_screen.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 300),
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    child: Text(
                      'Hi, ${widget.authService?.userName ?? 'Loading...'} 👋',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
                _buildLocation(context),
              ],
            ),
          ),
          _buildProfileImage(context),
        ],
      ),
    );
  }

  Widget _buildLocation(BuildContext context) {
    return BlocBuilder<LocationCubit, LocationState>(
      builder: (context, state) {
        if (state is LocationLoading) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: LoadingDots(),
            ),
          );
        } else if (state is LocationLoaded) {
          return InkWell(
            onTap: () {
              context.read<LocationCubit>().getLocation();
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyMapScreen(
                            latitude: state.latitude,
                            longitude: state.longitude,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.location_on,
                      size: 35,
                      color: Colors.orange,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      state.address,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (state is LocationError) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Error fetching location.',
              style: TextStyle(color: Colors.red),
            ),
          );
        } else {
          return const Text('Unknown state');
        }
      },
    );
  }

  Widget _buildProfileImage(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ProfileScreen(),
          ),
        );
      },
      child: Hero(
        tag: 'profileImage',
        child: CircleAvatar(
          radius: 30,
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
    );
  }
}
