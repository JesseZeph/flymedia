class Config {
  static const apiUrl = "flymediabackend-production.up.railway.app";
  static const String signupUrl = "/api/register";
  static const String signupApple = "/apple/sign_up_with_apple";
  static const String appleCallback = "/apple/callbacks/sign_up_with_apple";
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
  static const String subscription = "/api/subscriptions";
  static const String allPlans = "/api/checkout/all-plans";
  static const String addAccount = "/api/account";
  static const String stripemakePayment = "/api/checkout/subscription-checkout";
  static const String stripeConfirmPayment = "/api/checkout/payment-success";
  static const String influencerPayment =
      "/api/campaignPayment/initiate-payment";
  static const String confirmCampaignPayment =
      "/api/campaignPayment/payment-success";
}
