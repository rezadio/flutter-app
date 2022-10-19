import 'package:eidupay/view/authentication/auth_face_id_page.dart';
import 'package:eidupay/view/authentication/auth_finger_print_page.dart';
import 'package:eidupay/view/authentication/auth_pin_page.dart';
import 'package:eidupay/view/chat/chat_list_page.dart';
import 'package:eidupay/view/chat/chat_screen_page.dart';
import 'package:eidupay/view/chat/pay_amount_page.dart';
import 'package:eidupay/view/chat/request_amount_page.dart';
import 'package:eidupay/view/forgot_pin/reset_pin_page.dart';
import 'package:eidupay/view/forgot_pin/security_question_page.dart';
import 'package:eidupay/view/home_page.dart';
import 'package:eidupay/view/invest/invest_page.dart';
import 'package:eidupay/view/invest/portfolio_page.dart';
import 'package:eidupay/view/invest/portfolio_page_2.dart';
import 'package:eidupay/view/komunitas_list.dart';
import 'package:eidupay/view/kyc/image_confirmation_page.dart';
import 'package:eidupay/view/kyc/instruction_page.dart';
import 'package:eidupay/view/kyc/kyc_camera_page.dart';
import 'package:eidupay/view/kyc/kyc_data_confirmation_page.dart';
import 'package:eidupay/view/kyc/kyc_success_page.dart';
import 'package:eidupay/view/kyc/scan_ktp_page.dart';
import 'package:eidupay/view/notification/notification_info_detail_page.dart';
import 'package:eidupay/view/profile/biometric_setting.dart';
import 'package:eidupay/view/profile/support.dart';
import 'package:eidupay/view/services/belanja/belanja_service.dart';
import 'package:eidupay/view/services/education/education_direct_confirm.dart';
import 'package:eidupay/view/services/esamsat/esamsat_service.dart';
import 'package:eidupay/view/services/pulsa/pulsa_list_produk.dart';
import 'package:eidupay/view/services/telkom/telkom_service.dart';
import 'package:eidupay/view/services/tv/tv_service.dart';
import 'package:eidupay/view/sub_account/profile/sub_profile_page.dart';
import 'package:eidupay/view/sub_account/sub_home_page.dart';
import 'package:eidupay/view/swiff/swiff_payment_page.dart';
import 'package:eidupay/view/transaction_detail_page.dart';
import 'package:eidupay/view/opening.dart';
import 'package:eidupay/view/otp_page.dart';
import 'package:eidupay/view/profile/about.dart';
import 'package:eidupay/view/profile/edit_profile.dart';
import 'package:eidupay/view/profile/faqs.dart';
import 'package:eidupay/view/profile/profile.dart';
import 'package:eidupay/view/profile/reset_pin.dart';
import 'package:eidupay/view/profile/term_condition.dart';
import 'package:eidupay/view/qris/qris_scan_page.dart';
import 'package:eidupay/view/qris/qris_payment_page.dart';
import 'package:eidupay/view/register_voice_page.dart';
import 'package:eidupay/view/services/bpjs/bpjs_confirm.dart';
import 'package:eidupay/view/services/bpjs/bpjs_service.dart';
import 'package:eidupay/view/services/education/education_confirm.dart';
import 'package:eidupay/view/services/education/education_select_payment_method.dart';
import 'package:eidupay/view/services/education/education_services.dart';
import 'package:eidupay/view/services/education/edukasi_input_siswa.dart';
import 'package:eidupay/view/services/eduprime/eduprime_page.dart';
import 'package:eidupay/view/services/games/game_detail.dart';
import 'package:eidupay/view/services/games/games_list.dart';
import 'package:eidupay/view/services/games/voucher_detail.dart';
import 'package:eidupay/view/services/listrik/listrik_service.dart';
import 'package:eidupay/view/services/pascabayar/pascabayar_service.dart';
import 'package:eidupay/view/services/pdam/pdam_page.dart';
import 'package:eidupay/view/services/pulsa/pulsa_service.dart';
import 'package:eidupay/view/services/sedekah/sedekah_amount_page.dart';
import 'package:eidupay/view/services/sedekah/sedekah_detail_page.dart';
import 'package:eidupay/view/services/sedekah/sedekah_page.dart';
import 'package:eidupay/view/services/services_page.dart';
import 'package:eidupay/view/services/titipan/titipan_confirmation_page.dart';
import 'package:eidupay/view/services/titipan/titipan_input_siswa.dart';
import 'package:eidupay/view/services/titipan/titipan_service.dart';
import 'package:eidupay/view/setup_login_pin.dart';
import 'package:eidupay/view/setup_login_pin_2.dart';
import 'package:eidupay/view/signup.dart';
import 'package:eidupay/view/sub_account/sub_account_on_board_page.dart';
import 'package:eidupay/view/topup/code_generated_success_page.dart';
import 'package:eidupay/view/topup/manage_card.dart';
import 'package:eidupay/view/sub_account/sub_account_reset_pin.dart';
import 'package:eidupay/view/topup/topup_merchant_denom_page.dart';
import 'package:eidupay/view/notification/notification_page.dart';
import 'package:eidupay/view/sub_account/add_sub_account_page.dart';
import 'package:eidupay/view/sub_account/edit_sub_account_page.dart';
import 'package:eidupay/view/sub_account/sub_account_detail_page.dart';
import 'package:eidupay/view/sub_account/sub_account_list_page.dart';
import 'package:eidupay/view/success_signup.dart';
import 'package:eidupay/view/terms_signup.dart';
import 'package:eidupay/view/topup/add_new_card.dart';
import 'package:eidupay/view/topup/merchant_info.dart';
import 'package:eidupay/view/topup/merchant_partner.dart';
import 'package:eidupay/view/topup/topup.dart';
import 'package:eidupay/view/topup/topup_bank.dart';
import 'package:eidupay/view/topup/topup_bank_islami.dart';
import 'package:eidupay/view/topup/topup_instant.dart';
import 'package:eidupay/view/topup/toupup_bank_info.dart';
import 'package:eidupay/view/transaction_page.dart';
import 'package:eidupay/view/transaction_success_page.dart';
import 'package:eidupay/view/transfer/transfer_page.dart';
import 'package:eidupay/view/transfer/transfer_to_bank_page.dart';
import 'package:eidupay/view/transfer/transfer_to_cash_page.dart';
import 'package:eidupay/view/transfer/transfer_to_emoney_page.dart';
import 'package:eidupay/view/transfer/transfer_to_wallet_page.dart';
import 'package:eidupay/view/verification_signup.dart';
import 'package:eidupay/view/pin_verification_page.dart';
import 'package:eidupay/view/withdrawal/account_detail_page.dart';
import 'package:eidupay/view/withdrawal/transfer_withdrawal_page.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:eidupay/view/login.dart';

List<GetPage> pages = [
  OpeningView.route,
  Login.route,
  Signup.route,
  TermSignup.route,
  VerificationSignUp.route,
  SetupLoginPin.route,
  SetupLoginPin2.route,
  SuccessSignUp.route,
  Home.route,
  TransferWithdrawalPage.route,
  AccountDetailPage.route,
  PinVerificationPage.route,
  QrisScanPage.route,
  QrisPaymentPage.route,
  NotificationPage.route,
  TransactionDetailPage.route,
  Topup.route,
  TopupBank.route,
  TopupBankInfo.route,
  TopupInstant.route,
  ManageCard.route,
  AddNewCard.route,
  TransactionSuccessPage.route,
  TransferPage.route,
  TransferToWalletPage.route,
  MerchantPartner.route,
  MerchantInfo.route,
  TransferToBankPage.route,
  TransferToCashPage.route,
  TransferToEMoneyPage.route,
  ServicesPage.route,
  ProfilePage.route,
  TermsCondition.route,
  AboutPage.route,
  EditProfile.route,
  ResetPin.route,
  Faqs.route,
  InvestPage.route,
  PortfolioPage.route,
  PortfolioPage2.route,
  AddSubAccountPage.route,
  SubAccountDetailPage.route,
  SubAccountListPage.route,
  EditSubAccountPage.route,
  RegisterVoicePage.route,
  BPJS.route,
  BPJSConfirm.route,
  InstructionPage.route,
  KycCameraPage.route,
  KycDataConfirmationPage.route,
  ImageConfirmationPage.route,
  KycSuccessPage.route,
  ScanKtpPage.route,
  EducationService.route,
  EducationConfirm.route,
  EducationDirectConfirm.route,
  EducationSelectPaymentMethod.route,
  ChatListPage.route,
  ChatScreenPage.route,
  RequestAmountPage.route,
  PayAmountPage.route,
  BelanjaService.route,
  PascabayarService.route,
  ListrikService.route,
  TvService.route,
  TelkomService.route,
  EsamsatService.route,
  EduprimePage.route,
  PdamPage.route,
  TitipanService.route,
  TitipanInputSiswa.route,
  TitipanConfirmationPage.route,
  SedekahPage.route,
  SedekahDetailPage.route,
  SedekahAmountPage.route,
  OpenInit.route,
  OtpPage.route,
  PulsaService.route,
  PulsaListProduk.route,
  TopupBankIslami.route,
  EdukasiInputSiswa.route,
  GameListPage.route,
  GameDetailPage.route,
  VoucherDetailPage.route,
  SubAccountResetPin.route,
  TopupMerchantDenomPage.route,
  ResetPinPage.route,
  SecurityQuestionPage.route,
  CodeGeneratedSuccessPage.route,
  AuthFaceIdPage.route,
  AuthFingerPrintPage.route,
  AuthPinPage.route,
  KomunitasList.route,
  TransactionPage.route,
  SubAccountOnBoardPage.route,
  TransactionDetailPage.route,
  NotificationInfoDetailPage.route,
  BiometricSettingPage.route,
  SupportPage.route,
  SubHomePage.route,
  SubProfilePage.route,
  SwiffPaymentPage.route,
];
