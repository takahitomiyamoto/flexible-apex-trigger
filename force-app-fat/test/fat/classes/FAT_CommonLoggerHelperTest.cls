/**
 * @name FAT_CommonLoggerHelperTest.cls
 * @description test class for FAT_CommonLoggerHelper
 */
@isTest(SeeAllData=false)
private class FAT_CommonLoggerHelperTest {
  private static FAT_CommonLoggerHelper helper = FAT_CommonLoggerHelper.getInstance();

  @isTest
  static void getLoggingLevelNone() {
    Test.startTest();
    LoggingLevel level = helper.getLoggingLevel('NONE');
    Test.stopTest();

    System.assertEquals(LoggingLevel.NONE, level, 'getLoggingLevelNone');
  }

  @isTest
  static void getLoggingLevelError() {
    Test.startTest();
    LoggingLevel level = helper.getLoggingLevel('ERROR');
    Test.stopTest();

    System.assertEquals(LoggingLevel.ERROR, level, 'getLoggingLevelNone');
  }

  @isTest
  static void getLoggingLevelWarn() {
    Test.startTest();
    LoggingLevel level = helper.getLoggingLevel('WARN');
    Test.stopTest();

    System.assertEquals(LoggingLevel.WARN, level, 'getLoggingLevelNone');
  }

  @isTest
  static void getLoggingLevelInfo() {
    Test.startTest();
    LoggingLevel level = helper.getLoggingLevel('INFO');
    Test.stopTest();

    System.assertEquals(LoggingLevel.INFO, level, 'getLoggingLevelNone');
  }

  @isTest
  static void getLoggingLevelFine() {
    Test.startTest();
    LoggingLevel level = helper.getLoggingLevel('FINE');
    Test.stopTest();

    System.assertEquals(LoggingLevel.FINE, level, 'getLoggingLevelNone');
  }

  @isTest
  static void getLoggingLevelFiner() {
    Test.startTest();
    LoggingLevel level = helper.getLoggingLevel('FINER');
    Test.stopTest();

    System.assertEquals(LoggingLevel.FINER, level, 'getLoggingLevelNone');
  }

  @isTest
  static void getLoggingLevelFinest() {
    Test.startTest();
    LoggingLevel level = helper.getLoggingLevel('FINEST');
    Test.stopTest();

    System.assertEquals(LoggingLevel.FINEST, level, 'getLoggingLevelNone');
  }

  @isTest
  static void getLoggingLevelOthers() {
    Test.startTest();
    LoggingLevel level = helper.getLoggingLevel('OTHERS');
    Test.stopTest();

    System.assertEquals(LoggingLevel.DEBUG, level, 'getLoggingLevelNone');
  }
}
