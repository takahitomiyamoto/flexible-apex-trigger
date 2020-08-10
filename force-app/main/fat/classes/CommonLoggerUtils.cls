/**
 * @name CommonLoggerUtils.cls
 * @description utilities for CommonLogger
 */
public without sharing class CommonLoggerUtils {
  // Constants
  private static final Integer MAX_WIDTH = CommonLoggerConstants.MAX_WIDTH;
  private static final String DATE_FORMAT = CommonLoggerConstants.DATE_FORMAT;
  private static final String FIELD_RECORD_TYPE_ID = CommonLoggerConstants.FIELD_RECORD_TYPE_ID;
  private static final String LOGGER_DEFAULT = CommonLoggerConstants.LOGGER_DEFAULT;
  private static final String PARTING_LINE = CommonLoggerConstants.PARTING_LINE;
  private static final String SYMBOL_CLS = CommonLoggerConstants.SYMBOL_CLS;
  private static final String SYMBOL_DIVIDER = CommonLoggerConstants.SYMBOL_DIVIDER;
  private static final String SYMBOL_NEWLINE = CommonLoggerConstants.SYMBOL_NEWLINE;
  private static final String TIMEZONE_JST = CommonLoggerConstants.TIMEZONE_JST;

  // Class Variables
  private static CommonLoggerUtils singletonCommonLoggerUtils = new CommonLoggerUtils();

  // Instance Variables
  private String timestampNow;
  private LoggerConfig__mdt defaultLoggerConfig;

  /**
   * @name CommonLoggerUtils
   * @description private constructor with no parameter
   */
  private CommonLoggerUtils() {
    this.setDefaultLoggerConfig();
  }

  /**
   * @name setTimestampNow
   * @description set TimestampNow
   */
  private void setTimestampNow() {
    this.timestampNow = String.valueof(
      Datetime.now().format(DATE_FORMAT, TIMEZONE_JST)
    );
  }

  /**
   * @name getTimestampNow
   * @description get TimestampNow
   */
  private String getTimestampNow() {
    return this.timestampNow;
  }

  /**
   * @name setDefaultLoggerConfig
   * @description set default LoggerConfig__mdt
   */
  private void setDefaultLoggerConfig() {
    this.defaultLoggerConfig = this.queryLoggerConfig(LOGGER_DEFAULT);
  }

  /**
   * @name getDefaultLoggerConfig
   * @description get default LoggerConfig__mdt
   */
  private LoggerConfig__mdt getDefaultLoggerConfig() {
    return this.defaultLoggerConfig;
  }

  /**
   * @name getInstance
   * @description get the instance
   */
  public static CommonLoggerUtils getInstance() {
    return singletonCommonLoggerUtils;
  }

  /**
   * @name queryLoggerConfig
   * @description get LoggerConfig__mdt
   */
  public LoggerConfig__mdt queryLoggerConfig(String developerName) {
    // TODO: https://pmd.github.io/latest/pmd_rules_apex_security.html#apexcrudviolation
    return [
      SELECT
        Archive__c,
        LoggerObject__r.QualifiedApiName,
        LoggerObjectLoggingLevel__r.QualifiedApiName,
        LoggerObjectLogMessage__r.QualifiedApiName,
        LoggerObjectName__r.QualifiedApiName,
        LoggerObjectRecordType__c,
        LoggingLevel__c
      FROM LoggerConfig__mdt
      WHERE DeveloperName = :developerName
    ];
  }

  /**
   * @name getDefaultLoggingLevelValue
   * @description get default LoggingLevel
   */
  public String getDefaultLoggingLevelValue() {
    LoggerConfig__mdt defaultLoggerConfig = this.getDefaultLoggerConfig();
    return defaultLoggerConfig.LoggingLevel__c;
  }

  /**
   * @name getLoggingLevel
   * @description get LoggingLevel
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
   * @name getDefaultLoggingLevel
   * @description get default LoggingLevel
   */
  public LoggingLevel getDefaultLoggingLevel() {
    String value = this.getDefaultLoggingLevelValue();
    return this.getLoggingLevel(value);
  }

  /**
   * @name notLogging
   * @description whether Logging is enabled or not
   */
  public Boolean notLogging(LoggingLevel defaultLevel) {
    return LoggingLevel.NONE.equals(defaultLevel);
  }

  /**
   * @name isHigherLevel
   * @description whether this logginglevel is higher than default or not
   */
  public Boolean isHigherLevel(LoggingLevel level, LoggingLevel defaultLevel) {
    return level.ordinal() >= defaultLevel.ordinal();
  }

  /**
   * @name createDebugLog
   * @description create debugLog
   */
  public String createDebugLog(
    LoggingLevel level,
    String className,
    String methodName,
    Object message
  ) {
    return className +
      SYMBOL_CLS +
      SYMBOL_DIVIDER +
      String.valueOf(level) +
      SYMBOL_DIVIDER +
      methodName +
      SYMBOL_DIVIDER +
      message;
  }

  /**
   * @name archivable
   * @description whether Logger Object is archivable or not
   */
  public Boolean archivable() {
    LoggerConfig__mdt defaultLoggerConfig = this.getDefaultLoggerConfig();
    return defaultLoggerConfig.Archive__c;
  }

  /**
   * @name archiveLoggerObject
   * @description archive Logger Object
   */
  public void archiveLoggerObject(String logMessage) {
    this.setTimestampNow();

    LoggerConfig__mdt defaultLoggerConfig = this.getDefaultLoggerConfig();
    final String OBJECT_LOGGER = defaultLoggerConfig.LoggerObject__r.QualifiedApiName;
    final String FIELD_NAME = defaultLoggerConfig.LoggerObjectName__r.QualifiedApiName;
    final String FIELD_LOGGING_LEVEL = defaultLoggerConfig.LoggerObjectLoggingLevel__r.QualifiedApiName;
    final String FIELD_LOG_MESSAGE = defaultLoggerConfig.LoggerObjectLogMessage__r.QualifiedApiName;
    SObject loggerObject = CommonUtils.createObject(OBJECT_LOGGER);

    // Logger RecordTypeId
    Id defaultLoggerRecordTypeId = CommonUtils.getRecordTypeId(
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
    CommonError.handleError(result);
  }

  /**
   * @name createLogMessage
   * @description create logMessage
   */
  public String createLogMessage(List<String> debugLogs) {
    String logMessage = String.join(debugLogs, SYMBOL_NEWLINE);
    Boolean isLong = (MAX_WIDTH < logMessage.length());
    if (isLong) {
      logMessage = logMessage.abbreviate(MAX_WIDTH);
    }

    System.debug(LoggingLevel.DEBUG, PARTING_LINE);
    System.debug(LoggingLevel.DEBUG, logMessage);
    System.debug(LoggingLevel.DEBUG, PARTING_LINE);

    return logMessage;
  }

  /**
   * @name createLoggerEvent
   * @description create LoggerEvent__e
   */
  public List<LoggerEvent__e> createLoggerEvent(CommonLogger logger) {
    LoggerEvent__e event = new LoggerEvent__e();
    event.Logger__c = JSON.serialize(logger);
    List<LoggerEvent__e> events = new List<LoggerEvent__e>();
    events.add(event);

    return events;
  }
}
