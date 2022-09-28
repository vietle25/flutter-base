import 'package:get/get.dart';

class Localizes {
  // Language code
  static const viCode = 'vi';
  static const enCode = 'en';

  // Key string
  static String signIn = "signIn";
  static String logout = "logout";
  static String password = "password";
  static String userName = "userName";
  static String cancel = "cancel";
  static String confirm = "confirm";
  static String ok = "ok";
  static String loading = "loading";
  static String informationAccount = "accountInfo";
  static String account = "account";
  static String cancelled = "cancelled";
  static String rejected = "rejected";
  static String draft = "draft";
  static String undefined = "undefined";
  static String home = "home";
  static String noData = "noData";
  static String date = "date";
  static String time = "time";
  static String permissionDenied = "permissionDenied";
  static String notification = "notification";
  static String search = "search";
  static String selectDate = "selectDate";
  static String english = "english";
  static String vietnamese = "vietnamese";
  static String incorrectDateFormat = "incorrectDateFormat";
  static String incorrectTimeFormat = "incorrectTimeFormat";
  static String dataNotFound = "dataNotFound";
  static String back = "back";
  static String processingErr = "processingErr";
  static String wantToExit = "wantToExit";
  static String close = "close";
  static String welcome = "welcome";
  static String continueString = "continue";
  static String setupPassword = "setupPassword";
  static String setupPasswordHint = "setupPasswordHint";
  static String setupPasswordValidate = "setupPasswordValidate";
  static String passwordNonMatchFormat = "passwordNonMatchFormat";
  static String name = "name";
  static String nameMaxLengthError = "nameMaxLengthError";
  static String yourName = "yourName";
  static String listChat = "listChat";
  static String generateChat = "generateChat";
  static String chatId = "chatId";
  static String nameChat = "nameChat";
  static String passwordChat = "passwordChat";
  static String inputMessage = "inputMessage";
  static String createNewConversation = "createNewConversation";
  static String joinExitsConversation = "joinExitsConversation";
  static String conversationNotFound = "conversationNotFound";
  static String conversationPasswordMissMatch = "conversationPasswordMissMatch";
  static String conversationPassOrCodeMissMatch =
      "conversationPassOrCodeMissMatch";
  static String dateCreated = "dateCreated";
  static String youAreCurrentJoined = "youAreCurrentJoined";
  static String member = "member";
  static String fileMedia = "fileMedia";
  static String chooseImage = "chooseImage";
  static String addMember = "addMember";
  static String addMemberDes = "addMemberDes";
  static String inviteByCodeAndPass = "inviteByCodeAndPass";
  static String conversationCode = "conversationCode";
  static String copyConversationInfo = "copyConversationInfo";
  static String joinChatWithUs = "joinChatWithUs";
  static String copyToClipboardSuccess = "copyToClipboardSuccess";
  static String nameMustDontHaveSpecialChar = "nameMustDontHaveSpecialChar";
  static String updateName = "updateName";
  static String changeLanguage = "changeLanguage";
  static String wantToLogout = "wantToLogout";
  static String creditApp = "creditApp";
  static String deleteData = "deleteData";
  static String image = "image";
  static String removeMember = "removeMember";
  static String joinAt = "joinAt";
  static String areYouSureDeleteMember = "areYouSureDeleteMember";
  static String video = "video";
  static String register = "register";
  static String registerDes = "registerDes";
  static String createNew = "createNew";
  static String join = "join";
  static String areYouWantDeleteChat = "areYouWantDeleteChat";
  static String noHaveFile = "noHaveFile";
  static String inviteByCode = "inviteByCode";

  // Key string trArgs
  static String pleaseEnter(String value) => "pleaseEnter".trArgs([value]);

  static String from(String value) => "from".trArgs([value]);

  static String to(String value) => "to".trArgs([value]);

  static String please(String value) => "please".trArgs([value]);

  static String createAnySuccess(String value) =>
      "createAnySuccess".trArgs([value]);

  static String editAnySuccess(String value) =>
      "editAnySuccess".trArgs([value]);
  static String maxLength(String value, int length) =>
      "maxLength".trArgs([value, length.toString()]);
}
