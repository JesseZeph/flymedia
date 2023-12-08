import 'package:flutter/cupertino.dart';
import 'package:flymedia_app/models/profile/profile_model.dart';
import 'package:flymedia_app/services/helpers/profile_helper.dart';

class ProfileProvider extends ChangeNotifier with ProfileHelper {
  bool _isFetchingProfile = false;
  bool get isFetchingProfile => _isFetchingProfile;
  ProfileModel? _userProfile;
  ProfileModel? get userProfile => _userProfile;

  getProfile(String userId) async {
    _isFetchingProfile = !_isFetchingProfile;
    _userProfile = await getUserProfile(userId);
    _isFetchingProfile = !_isFetchingProfile;
    notifyListeners();
  }

  Future<List<dynamic>> updateUserProfile(
      String userId, ProfileModel details, hasFile, isUpdate) async {
    print("======> request body : \n ${details.toJson()} \n ========>");

    _isFetchingProfile = !_isFetchingProfile;
    notifyListeners();
    var resp = await updateProfile(userId, details.toMap(), hasFile,
        isPutRequest: isUpdate);
    _isFetchingProfile = !_isFetchingProfile;
    notifyListeners();
    return resp;
  }
}
