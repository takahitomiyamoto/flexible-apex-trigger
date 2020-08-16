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
  static void store() {
    Test.startTest();
    FAT_CommonLogger logger = FAT_CommonLogger.getInstance();
    String maxWidthMsg = '';
    for (Integer i = 0; i < FAT_CommonLoggerConstants.MAX_WIDTH; i++) {
      maxWidthMsg += 'a';
    }
    logger.store(LoggingLevel.DEBUG, maxWidthMsg);
    logger.publish();
    logger.fetch();
    logger.clear();
    Test.stopTest();

    System.assertNotEquals(null, logger, 'stackDebugLog');
  }

  @isTest
  static void stackNotLogging() {
    Test.startTest();
    FAT_CommonLogger logger = FAT_CommonLogger.getInstance();
    logger.storeDefaultDebugLog(LoggingLevel.NONE, LoggingLevel.DEBUG, '');
    Test.stopTest();

    System.assertNotEquals(null, logger, 'stackDebugLogNotLogging');
  }

  @isTest
  static void stackNone() {
    Test.startTest();
    FAT_CommonLogger logger = FAT_CommonLogger.getInstance();
    String message = '';
    logger.store(LoggingLevel.NONE, message);
    Test.stopTest();

    System.assertNotEquals(null, logger, 'stackDebugLogNone');
  }

  @isTest
  static void fetchEmpty() {
    Test.startTest();
    FAT_CommonLogger logger = FAT_CommonLogger.getInstance();
    logger.fetch();
    Test.stopTest();

    System.assertNotEquals(null, logger, 'fetchDebugLogsEmpty');
  }
}
