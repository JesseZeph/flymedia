import 'package:flutter/cupertino.dart';
import 'package:flymedia_app/models/profile/profile_model.dart';
import 'package:flymedia_app/models/response/get_all_influencers.dart';
import 'package:flymedia_app/services/helpers/profile_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProvider extends ChangeNotifier with ProfileHelper {
  List<GetAllInfluencersRes> profileList = [];
  bool _isFetching = true;
  bool get isFetching => _isFetching;
  bool _isFetchingProfile = false;
  bool get isFetchingProfile => _isFetchingProfile;
  ProfileModel? _userProfile;
  ProfileModel? get userProfile => _userProfile;

  getProfile(String userId) async {
    var prefs = await SharedPreferences.getInstance();

    _isFetchingProfile = !_isFetchingProfile;
    _userProfile = await getUserProfile(userId);
    if (_userProfile != null) {
      prefs.setBool('profile', true);
      prefs.setString('influencerId', _userProfile?.id ?? '');
    } else {
      prefs.setBool('profile', false);
    }
    _isFetchingProfile = !_isFetchingProfile;
    notifyListeners();
  }

  Future<List<dynamic>> updateUserProfile(
      String userId, ProfileModel details, hasFile, isUpdate) async {
    _isFetchingProfile = !_isFetchingProfile;
    notifyListeners();
    var resp = await updateProfile(userId, details.toMap(), hasFile,
        isPutRequest: isUpdate);
    await getProfile(userId);
    _isFetchingProfile = !_isFetchingProfile;
    notifyListeners();
    return resp;
  }

  Future<bool> getAllInfluencerProfiles(int page,
      {bool isLoadingMore = false}) async {
    bool canLoadMore = true;
    if (isLoadingMore) {
      var newList = await ProfileHelper.getAllInfluencers(page);
      profileList.addAll(newList);
      canLoadMore = newList.isNotEmpty && newList.length == 20;
    } else {
      profileList = await ProfileHelper.getAllInfluencers(page);
      canLoadMore = profileList.isNotEmpty && profileList.length == 20;
    }
    _isFetching = false;
    notifyListeners();
    return canLoadMore;
  }
}
