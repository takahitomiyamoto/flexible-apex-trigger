/**
 * @name CommonLoggerTest.cls
 * @description test class for CommonLogger
 */
@isTest(SeeAllData=false)
private class CommonLoggerTest {
  @testSetup
  static void setup() {
  }

  @isTest
  static void stackDebugLog() {
    Test.startTest();
    CommonLogger logger = CommonLogger.getInstance();
    String maxWidthMsg = '';
    for (Integer i = 0; i < CommonLoggerConstants.MAX_WIDTH; i++) {
      maxWidthMsg += 'a';
    }
    logger.stackDebugLog(LoggingLevel.DEBUG, maxWidthMsg);
    logger.publish();
    logger.fetchDebugLogs();
    logger.clearDebugLogs();
    Test.stopTest();

    System.assertNotEquals(null, logger);
  }

  @isTest
  static void stackDebugLogNone() {
    Test.startTest();
    CommonLogger logger = CommonLogger.getInstance();
    String message = '';
    logger.stackDebugLog(LoggingLevel.NONE, message);
    Test.stopTest();

    System.assertNotEquals(null, logger);
  }

  @isTest
  static void fetchDebugLogsEmpty() {
    Test.startTest();
    CommonLogger logger = CommonLogger.getInstance();
    logger.fetchDebugLogs();
    Test.stopTest();

    System.assertNotEquals(null, logger);
  }
}
