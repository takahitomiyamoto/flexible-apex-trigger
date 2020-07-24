/**
 * @name CommonLogger.cls
 * @description common logger
 */
public without sharing class CommonLogger {
  // Constants
  public static final System.loggingLevel LOGGING_LEVEL_DEFAULT = getLoggingLevelDefault();
  private static final Integer MAX_WIDTH = CommonLoggerConstants.MAX_WIDTH;
  private static final String DATE_FORMAT = CommonLoggerConstants.DATE_FORMAT;
  private static final String MSG_START_LOGGING = CommonLoggerConstants.MSG_START_LOGGING;
  private static final String PARTING_LINE = CommonLoggerConstants.PARTING_LINE;
  private static final String SYMBOL_CLS = CommonLoggerConstants.SYMBOL_CLS;
  private static final String SYMBOL_DIVIDER = CommonLoggerConstants.SYMBOL_DIVIDER;
  private static final String SYMBOL_NEWLINE = CommonLoggerConstants.SYMBOL_NEWLINE;
  private static final String TIMEZONE_JST = CommonLoggerConstants.TIMEZONE_JST;

  // Class Variables
  private static CommonLogger singletonCommonLogger = new CommonLogger();
  private static Logger__mdt globalLogger;

  // Instance Variables
  private List<String> debuglogs = new List<String>();
  private String timestampNow;
  private String className;
  private String methodName;

  /**
   * @name CommonLogger
   * @description private constructor with no parameter
   */
  private CommonLogger() {
    System.debug(System.loggingLevel.FINEST, MSG_START_LOGGING);
  }

  /**
   * @name getLoggingLevel
   * @description get LoggingLevel
   */
  @TestVisible
  private static System.LoggingLevel getLoggingLevel(String value) {
    switch on value {
      when 'NONE' {
        return System.LoggingLevel.NONE;
      }
      when 'ERROR' {
        return System.LoggingLevel.ERROR;
      }
      when 'WARN' {
        return System.LoggingLevel.WARN;
      }
      when 'INFO' {
        return System.LoggingLevel.INFO;
      }
      when 'DEBUG' {
        return System.LoggingLevel.DEBUG;
      }
      when 'FINE' {
        return System.LoggingLevel.FINE;
      }
      when 'FINER' {
        return System.LoggingLevel.FINER;
      }
      when 'FINEST' {
        return System.LoggingLevel.FINEST;
      }
      when else {
        return System.LoggingLevel.DEBUG;
      }
    }
  }

  /**
   * @name setTimestampNow
   * @description set TimestampNow
   */
  @TestVisible
  private void setTimestampNow() {
    this.timestampNow = String.valueof(
      Datetime.now().format(DATE_FORMAT, TIMEZONE_JST)
    );
  }

  /**
   * @name getTimestampNow
   * @description get TimestampNow
   */
  @TestVisible
  private String getTimestampNow() {
    return this.timestampNow;
  }

  /**
   * @name setLogger
   * @description set logger
   */
  @TestVisible
  private static void setLogger(Logger__mdt logger) {
    globalLogger = logger;
  }

  /**
   * @name setLogger
   * @description get logger
   */
  @TestVisible
  private static Logger__mdt getLogger() {
    return globalLogger;
  }

  /**
   * @name getLoggingLevelDefault
   * @description get the default value of LoggingLevel
   */
  private static System.loggingLevel getLoggingLevelDefault() {
    String developerName = CommonLoggerConstants.LOGGER_DEFAULT;

    Logger__mdt logger = [
      SELECT
        Archive__c,
        LoggerObject__c,
        LoggerObjectLoggingLevel__c,
        LoggerObjectMessage__c,
        LoggerObjectName__c,
        LoggerObjectRecordType__c,
        LoggingLevel__c
      FROM Logger__mdt
      WHERE DeveloperName = :developerName
    ];
    setLogger(logger);

    return getLoggingLevel(logger.LoggingLevel__c);
  }

  /**
   * @name archiveLoggerObject
   * @description archive Logger Object
   */
  private void archiveLoggerObject(String logMessage) {
    Logger__mdt globalLogger = getLogger();
    Boolean archive = globalLogger.Archive__c;
    if (archive) {
      String loggerObject = globalLogger.LoggerObject__c;
      SObject apexLogger = CommonUtils.createObject(loggerObject);
      apexLogger.put(globalLogger.LoggerObjectName__c, getTimestampNow());
      apexLogger.put(
        globalLogger.LoggerObjectLoggingLevel__c,
        globalLogger.LoggingLevel__c
      );
      apexLogger.put(globalLogger.LoggerObjectMessage__c, logMessage);
      apexLogger.put(
        'RecordTypeId',
        CommonUtils.getRecordTypeId(
          globalLogger.LoggerObject__c,
          globalLogger.LoggerObjectRecordType__c
        )
      );
      // TODO: saveResult
      Database.insert(apexLogger, false);
    }
  }

  /**
   * @name getInstance
   * @description get the instance
   */
  public static CommonLogger getInstance() {
    return singletonCommonLogger;
  }

  /**
   * @name setClassName
   * @description set className
   */
  public void setClassName(String className) {
    this.className = className;
  }

  /**
   * @name getClassName
   * @description get className
   */
  public String getClassName() {
    return this.className;
  }

  /**
   * @name setMethodName
   * @description set methodName
   */
  public void setMethodName(String methodName) {
    this.methodName = methodName;
  }

  /**
   * @name getMethodName
   * @description get methodName
   */
  public String getMethodName() {
    return this.methodName;
  }

  /**
   * @name stackDebugLog
   * @description stack the debugLog
   */
  public void stackDebugLog(System.LoggingLevel loggingLevel, Object message) {
    System.LoggingLevel defaultLevel = getLoggingLevel(
      LOGGING_LEVEL_DEFAULT.name()
    );

    Boolean notLogging = System.LoggingLevel.NONE.equals(defaultLevel);
    if (notLogging) {
      return;
    }

    // output log if it is higher than default logginglevel
    Boolean isHigher = loggingLevel.ordinal() >= defaultLevel.ordinal();
    if (isHigher) {
      String debugLog =
        String.valueOf(loggingLevel) +
        SYMBOL_DIVIDER +
        getClassName() +
        SYMBOL_CLS +
        SYMBOL_DIVIDER +
        getMethodName() +
        SYMBOL_DIVIDER +
        message;

      this.debuglogs.add(debugLog);
    }
  }

  /**
   * @name fetchDebugLogs
   * @description fetch all debugLogs
   */
  public void fetchDebugLogs() {
    Boolean isEmpty = 0 == this.debuglogs.size();
    if (isEmpty) {
      return;
    }

    setTimestampNow();

    String logMessage = String.join(this.debuglogs, SYMBOL_NEWLINE);
    Boolean isLong = (MAX_WIDTH < logMessage.length());
    if (isLong) {
      logMessage = logMessage.abbreviate(MAX_WIDTH);
    }

    System.debug(LOGGING_LEVEL_DEFAULT, PARTING_LINE);
    System.debug(LOGGING_LEVEL_DEFAULT, logMessage);
    System.debug(LOGGING_LEVEL_DEFAULT, PARTING_LINE);

    this.archiveLoggerObject(logMessage);
    this.debuglogs.clear();
  }
}
