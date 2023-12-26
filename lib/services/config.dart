class Config {
  static const apiUrl = "flymediabackend-production.up.railway.app";
  // static const apiUrl = " localhost:6002";

  static const String signupUrl = "/api/register";
  static const String influencerSignup = "/api/register/influencer";
  static const String verifyEmail = "/api/verifyEmail";
  static const String login = "/api/login";
  static const String influencerLogin = "/api/influencer/login";
  static const String companyVerification = "/api/verifyCompany";
  static const String campaignUpload = "/api/uploadCampaign";
  static const String getAllCampaigns = "/api/uploadCampaign/campaigns";
  static const String specificUserCampaign = "/api/uploadCampaign/client";
  static const String searchCampaign = "/api/uploadCampaign/search";
  static const String deleteCampaign = "/api/uploadCampaign/delete";
  static const String influencerProfile = "/api/influencerProfile/";
  static const String forgotPassword = "/api/forgotPassword";
  static const String verifyOtp = "/api/verifyPasswordReset";
  static const String resendOtp = "/api/resendVerification";
  static const String resetPassword = "/api/resetPassword";
  static const String campaignApplication = "/api/applications/";
  static const String campaignApplicants = "/api/applications/campaign";
  static const String validateToken = "/api/confirm/token";
  static const String validateCompany = "/api/confirm/company";
  static const String chats = "/api/chats";
}
