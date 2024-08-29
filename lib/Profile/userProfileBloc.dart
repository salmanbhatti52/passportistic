// import 'package:bloc/bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:scanguard/Profile/profilePage.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import '../Models/getProfileModels.dart';
// import '../auth/signUpPage.dart';
// import '../main.dart';

// // Events
// abstract class UserProfileEvent {}

// class UserProfileLoadEvent extends UserProfileEvent {}

// // States
// abstract class UserProfileState {}

// class UserProfileLoadingState extends UserProfileState {}

// class UserProfileLoadedState extends UserProfileState {
//   final GetProfileModels profileData;

//   UserProfileLoadedState(this.profileData);
// }

// class UserProfileErrorState extends UserProfileState {
//   final String errorMessage;

//   UserProfileErrorState(this.errorMessage);
// }

// class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
//   UserProfileBloc() : super(UserProfileLoadingState());

//   @override
//   Stream<UserProfileState> mapEventToState(UserProfileEvent event) async* {
//     if (event is UserProfileLoadEvent) {
//       yield UserProfileLoadingState();

//       try {
//         final GetProfileModels profileData = await _fetchUserProfile();
//         yield UserProfileLoadedState(profileData);
//       } catch (error) {
//         yield UserProfileErrorState(error.toString());
//       }
//     }
//   }

//   Future<GetProfileModels> _fetchUserProfile() async {
//     try {
//       String apiUrl = "$baseUrl/get_profile";
//       prefs = await SharedPreferences.getInstance();
//       userID = prefs?.getString('userID');

//       final response = await http.post(Uri.parse(apiUrl), headers: {
//         'Accept': 'application/json',
//       }, body: {
//         "passport_holder_id": "$userID"
//       });

//       if (response.statusCode == 200) {
//         final responseString = response.body;
//         final getProfileModels = getProfileModelsFromJson(responseString);
//         return getProfileModels;
//       } else {
//         throw Exception('Failed to load user profile');
//       }
//     } catch (error) {
//       rethrow;
//     }
//   }
  


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('User Profile'),
//       ),
//       body: BlocBuilder<UserProfileBloc, UserProfileState>(
//         builder: (context, state) {
//           if (state is UserProfileLoadingState) {
//             return const CircularProgressIndicator(); // Show loading indicator
//           } else if (state is UserProfileLoadedState) {
             // !Access the user profile data from state.profileData
//             final profileData = state.profileData;
//             return ProfilePage(profileData: profileData);
//           } else if (state is UserProfileErrorState) {
//             return Text('Error: ${state.errorMessage}'); // Show error message
//           } else {
//             return const Text('Unknown state'); // Handle other states as needed
//           }
//         },
//       ),
//     );
//   }
// }
