/**
 * @name CommonLogger.cls
 * @description common logger
 */
public without sharing class CommonLogger {
  // Class Variables
  private static CommonLogger singletonCommonLogger = new CommonLogger();
  private final CommonLoggerUtils utils = CommonLoggerUtils.getInstance();

  // Instance Variables
  private String className;
  private String methodName;
  private List<String> debugLogs = new List<String>();

  /**
   * @name CommonLogger
   * @description private constructor with no parameter
   */
  private CommonLogger() {
    System.debug(LoggingLevel.FINEST, 'CommonLogger');
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
  public void stackDebugLog(LoggingLevel level, Object message) {
    LoggingLevel defaultLevel = utils.getDefaultLoggingLevel();
    if (utils.notLogging(defaultLevel)) {
      return;
    }
    if (utils.isHigherLevel(level, defaultLevel)) {
      String logMessage = utils.createDebugLogMessage(getMethodName(), message);
      String debugLog = utils.createDebugLog(level, getClassName(), logMessage);
      this.debugLogs.add(debugLog);
    }
  }

  /**
   * @name fetchDebugLogs
   * @description fetch all debugLogs
   */
  public void fetchDebugLogs() {
    Boolean isEmpty = 0 == this.debugLogs.size();
    if (isEmpty) {
      return;
    }

    if (utils.archivable()) {
      utils.archiveLoggerObject(utils.createLogMessage(this.debugLogs));
    }
  }

  /**
   * @name publish
   * @description publish LoggerEvent__e
   */
  public void publish() {
    List<LoggerEvent__e> events = utils.createLoggerEvent(this);
    List<Database.SaveResult> results = EventBus.publish(events);
    for (Database.SaveResult result : results) {
      CommonError.handleError(result);
    }
  }

  /**
   * @name clearDebugLogs
   * @description clear all debugLogs
   */
  public void clearDebugLogs() {
    this.debugLogs.clear();
  }
}
