import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:scanguard/Models/coverDesignModels.dart';
import 'package:scanguard/Models/getProfileModels.dart';
import 'package:scanguard/auth/signUpPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum PassportFrontCoverState { initial, loading, loaded, error }

class PassportFrontCoverCubit extends Cubit<PassportFrontCoverState> {
  PassportFrontCoverCubit() : super(PassportFrontCoverState.initial);

  Future<void> loadFrontCover() async {
    emit(PassportFrontCoverState.loading);

    try {
      final prefs = await SharedPreferences.getInstance();
      final userID = prefs.getString('userID');
      final getProfileApiUrl = "$baseUrl/get_profile";
      final coverDesignApiUrl = "$baseUrl/get_cover_design";

      final getProfileResponse =
          await http.post(Uri.parse(getProfileApiUrl), headers: {
        'Accept': 'application/json',
      }, body: {
        "passport_holder_id": "$userID",
      });

      final getProfileResponseString = getProfileResponse.body;
      final getProfileStatus = getProfileResponse.statusCode;

      if (getProfileStatus == 200) {
        final getProfileModels =
            getProfileModelsFromJson(getProfileResponseString);

        await loadCoverDesign(userID, coverDesignApiUrl, getProfileModels);

        emit(PassportFrontCoverState.loaded);
      } else {
        emit(PassportFrontCoverState.error);
      }
    } catch (e) {
      print('Error loading front cover: $e');
      emit(PassportFrontCoverState.error);
    }
  }

  String? selectedOption;
  CoverDesignDataModel coverDesignDataModel = CoverDesignDataModel();

  Future<void> loadCoverDesign(
      String? userID, String apiUrl, GetProfileModels getProfileModels) async {
    final response = await http.post(Uri.parse(apiUrl), headers: {
      'Accept': 'application/json',
    }, body: {
      "passport_holder_id": "$userID",
    });

    final responseString = response.body;
    final statusCode = response.statusCode;

    if (statusCode == 200) {
      final coverDesignDataModel = coverDesignDataModelFromJson(responseString);

      if (coverDesignDataModel.data != null && getProfileModels.data != null) {
        for (int i = 0; i < coverDesignDataModel.data!.length; i++) {
          if (coverDesignDataModel.data![i].passportDesignId ==
              getProfileModels.data!.passportDesignId) {
            selectedOption = coverDesignDataModel.data![i].passportFrontCover;
          }
        }
      }
    }
  }
}
