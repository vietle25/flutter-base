class ErrorCode {
  static const int success = 0; // Success
  static const int common = 1; // Error common
  static const int missingParam = 101; // Missing param
  static const int phoneAndSessionNotMatch =
      102; // Phone Number & Session Info does not match each other
  static const int invalidAccount =
      103; // No parent account found with provided phone number
  static const int invalidParam = 105; // Invalid data format / invalid params
  static const int studentIDNotCorrect = 106; // Student ID is not correct.
  static const int studentNotBeenAttachedSchool =
      107; // Student with id has not been attached to any school.
  static const int dataNotFound = 108; // Data not found with provided ID
  static const int forbiddenAction = 109; // Forbidden action
  static const int deviceNotRegister =
      404; // Device has not been registered (getOPT Code has not been sent
  static const int wrongOtp = 405; // Wrong OTP Code
  static const int unauthorised =
      403; // Timeout session, (check with firebase), missing AccessToken in header
  static const int sessionTimeout =
      401; // Timeout session, (check with firebase), missing AccessToken in header
  static const int invalidAccountBus = 401;

  /// No bus monitor account found with provided phone number
  static const int deactivate =
      406; // Account has not been activated, this account does not contain a student.
  static const int permissionDenied = 407; // User login is not employee
  static const int absentRequestDateExisted =
      110; // Absent request date ------ of ------ is already exists
  static const int internalServerError = 500; // Server error
}
