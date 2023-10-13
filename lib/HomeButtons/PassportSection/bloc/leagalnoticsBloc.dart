import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:scanguard/Models/coverDesignModels.dart';
import 'package:scanguard/Models/getProfileModels.dart';
import 'package:scanguard/auth/signUpPage.dart';
// Import your coverDesignDataModel file
import 'package:shared_preferences/shared_preferences.dart';

enum PassportLegalNoticePageState { initial, loading, loaded, error }

class PassportLegalNoticePageCubit extends Cubit<PassportLegalNoticePageState> {
  PassportLegalNoticePageCubit() : super(PassportLegalNoticePageState.initial);

  Future<void> loadLegalNotice() async {
    emit(PassportLegalNoticePageState.loading);

    try {
      final prefs = await SharedPreferences.getInstance();
      final userID = prefs.getString('userID');
      final getProfileApiUrl = "$baseUrl/get_profile";
      final coverDesignApiUrl = "$baseUrl/get_cover_design";

      final getProfileResponse = await http.post(Uri.parse(getProfileApiUrl), headers: {
        'Accept': 'application/json',
      }, body: {
        "passport_holder_id": "$userID",
      });

      final getProfileResponseString = getProfileResponse.body;
      final getProfileStatus = getProfileResponse.statusCode;

      if (getProfileStatus == 200) {
        final getProfileModels = getProfileModelsFromJson(getProfileResponseString);

        await loadCoverDesign(userID, coverDesignApiUrl, getProfileModels);
        
        emit(PassportLegalNoticePageState.loaded);
      } else {
        emit(PassportLegalNoticePageState.error);
      }
    } catch (e) {
      print('Error loading legal notice: $e');
      emit(PassportLegalNoticePageState.error);
    }
  }

  String? legalnotice;

    String? selectedOption;
  CoverDesignDataModel coverDesignDataModel = CoverDesignDataModel();

  String selectedPassportCountry = "";

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
            selectedPassportCountry =
                coverDesignDataModel.data![i].passportCountry.toString();
            legalnotice = coverDesignDataModel.data![i].legalNotice;
          }
        }
      }
    }
  }
}
