/**
 * @name CommonErrorTest.cls
 * @description test class for CommonError
 */
@isTest(SeeAllData=false)
private class CommonErrorTest {
  @isTest
  static void handleError() {
    Test.startTest();
    Account account = new Account();
    Database.SaveResult result = Database.update(account, false);
    CommonError.handleError(result);
    Test.stopTest();

    System.assertEquals(false, result.isSuccess());
  }

  @isTest
  static void hasStackTraceEmpty() {
    Test.startTest();
    String stackTrace = '()\n';
    Boolean result = CommonError.hasStackTrace(stackTrace);
    Test.stopTest();

    System.assertEquals(false, result);
  }

  @isTest
  static void createErrorMessageException() {
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
  static void createErrorMessageCustomException() {
    Test.startTest();
    try {
      throw new CommonUtils.CustomException();
    } catch (Exception e) {
      String message = CommonError.createErrorMessage(e);
      System.assertNotEquals('', message);
    }
    Test.stopTest();
  }
}
