/**
 * @name FAT_CommonErrorTest.cls
 * @description test class for FAT_CommonError
 */
@isTest(SeeAllData=false)
private class FAT_CommonErrorTest {
  @isTest
  static void handleErrorNull() {
    Database.SaveResult result = null;

    Test.startTest();
    FAT_CommonError.handleError(result);
    Test.stopTest();

    System.assertEquals(null, result, 'handleErrorNull');
  }

  @isTest
  static void handleErrorsNull() {
    List<Database.SaveResult> result = null;

    Test.startTest();
    FAT_CommonError.handleErrors(result);
    Test.stopTest();

    System.assertEquals(null, result, 'handleErrorsNull');
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
    List<Boolean> exceptions = new List<Boolean>();
    try {
      Account account = new Account();
      update account;
    } catch (Exception e) {
      exceptions.add(true);
      String message = FAT_CommonError.createErrorMessage(e);
      System.assertNotEquals('', message, 'createErrorMessageException');
    }
    Test.stopTest();

    for (Boolean b : exceptions) {
      System.assertEquals(true, b, 'createErrorMessageException');
    }
  }

  @isTest
  static void createErrorMessageCustomException() {
    Test.startTest();
    List<Boolean> exceptions = new List<Boolean>();
    try {
      throw new FAT_CommonUtils.CustomException();
    } catch (Exception e) {
      exceptions.add(true);
      String message = FAT_CommonError.createErrorMessage(e);
      System.assertNotEquals('', message, 'createErrorMessageCustomException');
    }
    Test.stopTest();

    for (Boolean b : exceptions) {
      System.assertEquals(true, b, 'createErrorMessageCustomException');
    }
  }
}
