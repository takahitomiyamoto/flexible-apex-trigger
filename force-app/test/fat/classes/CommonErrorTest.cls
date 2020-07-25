/**
 * @name CommonErrorTest.cls
 * @description test class for CommonError
 */
@isTest(SeeAllData=false)
private class CommonErrorTest {
  @testSetup
  static void setup() {
  }

  @isTest
  static void handleError() {
    Test.startTest();
    Account account = new Account();
    Database.SaveResult result = Database.update(account, false);
    CommonError.handleError(result);
    System.assertNotEquals(null, result);
    Test.stopTest();
  }

  @isTest
  static void createErrorMessage_Exception() {
    Test.startTest();
    try {
      Account account = new Account();
      update account;
    } catch (Exception e) {
      String message = CommonError.createErrorMessage(e);
      System.assertNotEquals('', message);
    }
    Test.stopTest();
  }

  @isTest
  static void createErrorMessage_CustomException() {
    Test.startTest();
    try {
      throw new CommonUtils.CustomException();
    } catch (Exception e) {
      String message = CommonError.createErrorMessage(e);
      System.assertNotEquals('', message);
    }
    Test.stopTest();
  }

  @isTest
  static void hasStackTrace_empty() {
    Test.startTest();
    String stackTrace = '()\n';
    Boolean result = CommonError.hasStackTrace(stackTrace);
    System.assertEquals(false, result);
    Test.stopTest();
  }
}
