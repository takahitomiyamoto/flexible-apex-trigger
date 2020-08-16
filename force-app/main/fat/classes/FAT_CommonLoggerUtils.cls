/**
 * @name FAT_CommonLoggerUtils.cls
 * @description utilities for FAT_CommonLogger
 */
public without sharing class FAT_CommonLoggerUtils {
  // Constants
  private static final Integer MAX_WIDTH = FAT_CommonLoggerConstants.MAX_WIDTH;
  private static final String DATE_FORMAT = FAT_CommonLoggerConstants.DATE_FORMAT;
  private static final String FIELD_RECORD_TYPE_ID = FAT_CommonLoggerConstants.FIELD_RECORD_TYPE_ID;
  private static final String LOGGER_DEFAULT = FAT_CommonLoggerConstants.LOGGER_DEFAULT;
  private static final String SYMBOL_CLS = FAT_CommonLoggerConstants.SYMBOL_CLS;
  private static final String SYMBOL_DIVIDER = FAT_CommonLoggerConstants.SYMBOL_DIVIDER;
  private static final String SYMBOL_NEWLINE = FAT_CommonLoggerConstants.SYMBOL_NEWLINE;
  private static final String TIMEZONE_JST = FAT_CommonLoggerConstants.TIMEZONE_JST;

  // Class Variables
  private static FAT_CommonLoggerUtils singletonCommonLoggerUtils = new FAT_CommonLoggerUtils();

  // Instance Variables
  private String timestampNow;
  private FAT_LoggerConfig__mdt defaultLoggerConfig;

  /**
   * @description private constructor with no parameter
   */
  private FAT_CommonLoggerUtils() {
    this.setDefaultLoggerConfig();
  }

  /**
   * @description set TimestampNow
   */
  private void setTimestampNow() {
    this.timestampNow = String.valueof(
      Datetime.now().format(DATE_FORMAT, TIMEZONE_JST)
    );
  }

  /**
   * @description get TimestampNow
   * @return timestampNow
   */
  private String getTimestampNow() {
    return this.timestampNow;
  }

  /**
   * @description set default FAT_LoggerConfig__mdt
   */
  private void setDefaultLoggerConfig() {
    this.defaultLoggerConfig = this.queryLoggerConfig(LOGGER_DEFAULT);
  }

  /**
   * @description get default FAT_LoggerConfig__mdt
   * @return defaultLoggerConfig
   */
  private FAT_LoggerConfig__mdt getDefaultLoggerConfig() {
    return this.defaultLoggerConfig;
  }

  /**
   * @description get the instance
   * @return singletonCommonLoggerUtils
   */
  public static FAT_CommonLoggerUtils getInstance() {
    return singletonCommonLoggerUtils;
  }

  /**
   * @description get FAT_LoggerConfig__mdt
   * @param developerName
   * @return FAT_LoggerConfig__mdt
   */
  @SuppressWarnings('PMD.ApexCRUDViolation')
  public FAT_LoggerConfig__mdt queryLoggerConfig(String developerName) {
    return [
      SELECT
        Archive__c,
        LoggerObject__r.QualifiedApiName,
        LoggerObjectLoggingLevel__r.QualifiedApiName,
        LoggerObjectLogMessage__r.QualifiedApiName,
        LoggerObjectName__r.QualifiedApiName,
        LoggerObjectRecordType__c,
        LoggingLevel__c
      FROM FAT_LoggerConfig__mdt
      WHERE DeveloperName = :developerName
    ];
  }

  /**
   * @description get default LoggingLevel
   * @return defaultLoggerConfig.LoggingLevel__c
   */
  public String getDefaultLoggingLevelValue() {
    FAT_LoggerConfig__mdt defaultLoggerConfig = this.getDefaultLoggerConfig();
    return defaultLoggerConfig.LoggingLevel__c;
  }

  /**
   * @description get LoggingLevel
   * @param value
   * @return LoggingLevel
   */
  public LoggingLevel getLoggingLevel(String value) {
    switch on value {
      when 'NONE' {
        return LoggingLevel.NONE;
      }
      when 'ERROR' {
        return LoggingLevel.ERROR;
      }
      when 'WARN' {
        return LoggingLevel.WARN;
      }
      when 'INFO' {
        return LoggingLevel.INFO;
      }
      when 'DEBUG' {
        return LoggingLevel.DEBUG;
      }
      when 'FINE' {
        return LoggingLevel.FINE;
      }
      when 'FINER' {
        return LoggingLevel.FINER;
      }
      when 'FINEST' {
        return LoggingLevel.FINEST;
      }
      when else {
        return LoggingLevel.DEBUG;
      }
    }
  }

  /**
   * @description get default LoggingLevel
   * @return LoggingLevel
   */
  public LoggingLevel getDefaultLoggingLevel() {
    String value = this.getDefaultLoggingLevelValue();
    return this.getLoggingLevel(value);
  }

  /**
   * @description whether Logging is enabled or not
   * @param defaultLevel
   * @return Boolean
   */
  public Boolean notLogging(LoggingLevel defaultLevel) {
    return LoggingLevel.NONE.equals(defaultLevel);
  }

  /**
   * @description whether this logginglevel is higher than default or not
   * @param level
   * @param defaultLevel
   * @return level.ordinal() >= defaultLevel.ordinal()
   */
  public Boolean isHigherLevel(LoggingLevel level, LoggingLevel defaultLevel) {
    return level.ordinal() >= defaultLevel.ordinal();
  }

  /**
   * @description create debugLog message
   * @param methodName
   * @param message
   * @return methodName + SYMBOL_DIVIDER + message
   */
  public String createLogMessage(String methodName, Object message) {
    return methodName + SYMBOL_DIVIDER + message;
  }

  /**
   * @description create debugLog
   * @param level
   * @param className
   * @param logMessage
   * @return String
   */
  public String createDebugLog(
    LoggingLevel level,
    String className,
    Object logMessage
  ) {
    return className +
      SYMBOL_CLS +
      SYMBOL_DIVIDER +
      String.valueOf(level) +
      SYMBOL_DIVIDER +
      logMessage;
  }

  /**
   * @description whether Logger Object is archivable or not
   * @return defaultLoggerConfig.Archive__c
   */
  public Boolean archivable() {
    FAT_LoggerConfig__mdt defaultLoggerConfig = this.getDefaultLoggerConfig();
    return defaultLoggerConfig.Archive__c;
  }

  /**
   * @description archive Logger Object
   * @param logMessage
   */
  public void archiveLoggerObject(String logMessage) {
    this.setTimestampNow();

    FAT_LoggerConfig__mdt defaultLoggerConfig = this.getDefaultLoggerConfig();
    final String OBJECT_LOGGER = defaultLoggerConfig.LoggerObject__r.QualifiedApiName;
    final String FIELD_NAME = defaultLoggerConfig.LoggerObjectName__r.QualifiedApiName;
    final String FIELD_LOGGING_LEVEL = defaultLoggerConfig.LoggerObjectLoggingLevel__r.QualifiedApiName;
    final String FIELD_LOG_MESSAGE = defaultLoggerConfig.LoggerObjectLogMessage__r.QualifiedApiName;
    SObject loggerObject = FAT_CommonUtils.createObject(OBJECT_LOGGER);

    // Logger RecordTypeId
    Id defaultLoggerRecordTypeId = FAT_CommonUtils.getRecordTypeId(
      OBJECT_LOGGER,
      defaultLoggerConfig.LoggerObjectRecordType__c
    );
    loggerObject.put(FIELD_RECORD_TYPE_ID, defaultLoggerRecordTypeId);

    // Logger Name
    loggerObject.put(FIELD_NAME, this.getTimestampNow());

    // Logging Level
    loggerObject.put(FIELD_LOGGING_LEVEL, defaultLoggerConfig.LoggingLevel__c);

    // Log Message
    loggerObject.put(FIELD_LOG_MESSAGE, logMessage);

    Database.SaveResult result = Database.insert(loggerObject, false);
    FAT_CommonError.handleError(result);
  }

  /**
   * @description create logMessage
   * @param debugLogs
   * @return logMessage
   */
  public String createLogMessage(List<String> debugLogs) {
    String logMessage = String.join(debugLogs, SYMBOL_NEWLINE);
    Boolean isLong = (MAX_WIDTH < logMessage.length());
    if (isLong) {
      logMessage = logMessage.abbreviate(MAX_WIDTH);
    }

    return logMessage;
  }

  /**
   * @description create FAT_LoggerEvent__e
   * @param logger
   * @return events
   */
  public List<FAT_LoggerEvent__e> createLoggerEvent(FAT_CommonLogger logger) {
    FAT_LoggerEvent__e event = new FAT_LoggerEvent__e();
    event.Logger__c = JSON.serialize(logger);
    List<FAT_LoggerEvent__e> events = new List<FAT_LoggerEvent__e>();
    events.add(event);

    return events;
  }
}
