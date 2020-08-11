/**
 * @name FAT_CommonLoggerTest.cls
 * @description test class for FAT_CommonLogger
 */
@isTest(SeeAllData=false)
private class FAT_CommonLoggerTest {
  @testSetup
  static void setup() {
    System.debug(LoggingLevel.FINEST, 'setup');
  }

  @isTest
  static void stackDebugLog() {
    Test.startTest();
    FAT_CommonLogger logger = FAT_CommonLogger.getInstance();
    String maxWidthMsg = '';
    for (Integer i = 0; i < FAT_CommonLoggerConstants.MAX_WIDTH; i++) {
      maxWidthMsg += 'a';
    }
    logger.stackDebugLog(LoggingLevel.DEBUG, maxWidthMsg);
    logger.publish();
    logger.fetchDebugLogs();
    logger.clearDebugLogs();
    Test.stopTest();

    System.assertNotEquals(null, logger, 'stackDebugLog');
  }

  @isTest
  static void stackDebugLogNotLogging() {
    Test.startTest();
    FAT_CommonLogger logger = FAT_CommonLogger.getInstance();
    logger.stackDefaultDebugLog(LoggingLevel.NONE, LoggingLevel.DEBUG, '');
    Test.stopTest();

    System.assertNotEquals(null, logger, 'stackDebugLogNotLogging');
  }

  @isTest
  static void stackDebugLogNone() {
    Test.startTest();
    FAT_CommonLogger logger = FAT_CommonLogger.getInstance();
    String message = '';
    logger.stackDebugLog(LoggingLevel.NONE, message);
    Test.stopTest();

    System.assertNotEquals(null, logger, 'stackDebugLogNone');
  }

  @isTest
  static void fetchDebugLogsEmpty() {
    Test.startTest();
    FAT_CommonLogger logger = FAT_CommonLogger.getInstance();
    logger.fetchDebugLogs();
    Test.stopTest();

    System.assertNotEquals(null, logger, 'fetchDebugLogsEmpty');
  }
}
