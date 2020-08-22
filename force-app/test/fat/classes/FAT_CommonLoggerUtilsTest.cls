/**
 * @name FAT_CommonLoggerUtilsTest.cls
 * @description test class for FAT_CommonLoggerUtils
 */
@isTest(SeeAllData=false)
private class FAT_CommonLoggerUtilsTest {
  private static FAT_CommonLoggerUtils utils = FAT_CommonLoggerUtils.getInstance();

  @isTest
  static void getLoggingLevelNone() {
    Test.startTest();
    LoggingLevel level = utils.getLoggingLevel('NONE');
    Test.stopTest();

    System.assertEquals(LoggingLevel.NONE, level, 'getLoggingLevelNone');
  }

  @isTest
  static void getLoggingLevelError() {
    Test.startTest();
    LoggingLevel level = utils.getLoggingLevel('ERROR');
    Test.stopTest();

    System.assertEquals(LoggingLevel.ERROR, level, 'getLoggingLevelNone');
  }

  @isTest
  static void getLoggingLevelWarn() {
    Test.startTest();
    LoggingLevel level = utils.getLoggingLevel('WARN');
    Test.stopTest();

    System.assertEquals(LoggingLevel.WARN, level, 'getLoggingLevelNone');
  }

  @isTest
  static void getLoggingLevelInfo() {
    Test.startTest();
    LoggingLevel level = utils.getLoggingLevel('INFO');
    Test.stopTest();

    System.assertEquals(LoggingLevel.INFO, level, 'getLoggingLevelNone');
  }

  @isTest
  static void getLoggingLevelFine() {
    Test.startTest();
    LoggingLevel level = utils.getLoggingLevel('FINE');
    Test.stopTest();

    System.assertEquals(LoggingLevel.FINE, level, 'getLoggingLevelNone');
  }

  @isTest
  static void getLoggingLevelFiner() {
    Test.startTest();
    LoggingLevel level = utils.getLoggingLevel('FINER');
    Test.stopTest();

    System.assertEquals(LoggingLevel.FINER, level, 'getLoggingLevelNone');
  }

  @isTest
  static void getLoggingLevelFinest() {
    Test.startTest();
    LoggingLevel level = utils.getLoggingLevel('FINEST');
    Test.stopTest();

    System.assertEquals(LoggingLevel.FINEST, level, 'getLoggingLevelNone');
  }

  @isTest
  static void getLoggingLevelOthers() {
    Test.startTest();
    LoggingLevel level = utils.getLoggingLevel('OTHERS');
    Test.stopTest();

    System.assertEquals(LoggingLevel.DEBUG, level, 'getLoggingLevelNone');
  }
}
