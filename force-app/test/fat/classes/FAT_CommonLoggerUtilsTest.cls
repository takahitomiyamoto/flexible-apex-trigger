/**
 * @name FAT_CommonLoggerUtilsTest.cls
 * @description test class for FAT_CommonLoggerUtils
 */
@isTest(SeeAllData=false)
private class FAT_CommonLoggerUtilsTest {
  @isTest
  static void getLoggingLevelNone() {
    Test.startTest();
    FAT_CommonLoggerUtils utils = FAT_CommonLoggerUtils.getInstance();
    LoggingLevel level = utils.getLoggingLevel('NONE');
    Test.stopTest();

    system.assertEquals(LoggingLevel.NONE, level, 'getLoggingLevelNone');
  }

  @isTest
  static void getLoggingLevelError() {
    Test.startTest();
    FAT_CommonLoggerUtils utils = FAT_CommonLoggerUtils.getInstance();
    LoggingLevel level = utils.getLoggingLevel('ERROR');
    Test.stopTest();

    system.assertEquals(LoggingLevel.ERROR, level, 'getLoggingLevelNone');
  }

  @isTest
  static void getLoggingLevelWarn() {
    Test.startTest();
    FAT_CommonLoggerUtils utils = FAT_CommonLoggerUtils.getInstance();
    LoggingLevel level = utils.getLoggingLevel('WARN');
    Test.stopTest();

    system.assertEquals(LoggingLevel.WARN, level, 'getLoggingLevelNone');
  }

  @isTest
  static void getLoggingLevelInfo() {
    Test.startTest();
    FAT_CommonLoggerUtils utils = FAT_CommonLoggerUtils.getInstance();
    LoggingLevel level = utils.getLoggingLevel('INFO');
    Test.stopTest();

    system.assertEquals(LoggingLevel.INFO, level, 'getLoggingLevelNone');
  }

  @isTest
  static void getLoggingLevelFine() {
    Test.startTest();
    FAT_CommonLoggerUtils utils = FAT_CommonLoggerUtils.getInstance();
    LoggingLevel level = utils.getLoggingLevel('FINE');
    Test.stopTest();

    system.assertEquals(LoggingLevel.FINE, level, 'getLoggingLevelNone');
  }

  @isTest
  static void getLoggingLevelFiner() {
    Test.startTest();
    FAT_CommonLoggerUtils utils = FAT_CommonLoggerUtils.getInstance();
    LoggingLevel level = utils.getLoggingLevel('FINER');
    Test.stopTest();

    system.assertEquals(LoggingLevel.FINER, level, 'getLoggingLevelNone');
  }

  @isTest
  static void getLoggingLevelFinest() {
    Test.startTest();
    FAT_CommonLoggerUtils utils = FAT_CommonLoggerUtils.getInstance();
    LoggingLevel level = utils.getLoggingLevel('FINEST');
    Test.stopTest();

    system.assertEquals(LoggingLevel.FINEST, level, 'getLoggingLevelNone');
  }

  @isTest
  static void getLoggingLevelOthers() {
    Test.startTest();
    FAT_CommonLoggerUtils utils = FAT_CommonLoggerUtils.getInstance();
    LoggingLevel level = utils.getLoggingLevel('OTHERS');
    Test.stopTest();

    system.assertEquals(LoggingLevel.DEBUG, level, 'getLoggingLevelNone');
  }
}
