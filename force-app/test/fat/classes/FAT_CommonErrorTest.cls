/**
 * @name FAT_CommonErrorTest.cls
 * @description test class for FAT_CommonError
 */
@isTest(SeeAllData=false)
private class FAT_CommonErrorTest {
  @isTest
  static void handleError() {
    Test.startTest();
    Account account = new Account();
    Database.SaveResult result = Database.update(account, false);
    FAT_CommonError.handleError(result);
    Test.stopTest();

    System.assertEquals(false, result.isSuccess(), 'handleError');
  }

  @isTest
  static void hasStackTraceEmpty() {
    Test.startTest();
    String stackTrace = '()\n';
    Boolean result = FAT_CommonError.hasStackTrace(stackTrace);
    Test.stopTest();

    System.assertEquals(false, result, 'hasStackTraceEmpty');
  }

  @isTest
  static void createErrorMessageException() {
    Test.startTest();
    try {
      Account account = new Account();
      update account;
    } catch (Exception e) {
      String message = FAT_CommonError.createErrorMessage(e);
      System.assertNotEquals('', message, 'createErrorMessageException');
    }
    Test.stopTest();
  }

  @isTest
  static void createErrorMessageCustomException() {
    Test.startTest();
    try {
      throw new FAT_CommonUtils.CustomException();
    } catch (Exception e) {
      String message = FAT_CommonError.createErrorMessage(e);
      System.assertNotEquals('', message, 'createErrorMessageCustomException');
    }
    Test.stopTest();
  }
}
