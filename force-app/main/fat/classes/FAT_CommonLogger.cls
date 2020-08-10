/**
 * @name FAT_CommonLogger.cls
 * @description common logger
 */
public without sharing class FAT_CommonLogger {
  // Class Variables
  private static FAT_CommonLogger singletonCommonLogger = new FAT_CommonLogger();
  private final FAT_CommonLoggerUtils utils = FAT_CommonLoggerUtils.getInstance();

  // Instance Variables
  private String className;
  private String methodName;
  private List<String> debugLogs = new List<String>();

  /**
   * @description private constructor with no parameter
   */
  private FAT_CommonLogger() {
    System.debug(LoggingLevel.FINEST, 'FAT_CommonLogger');
  }

  /**
   * @description get the instance
   * @return FAT_CommonLogger
   */
  public static FAT_CommonLogger getInstance() {
    return singletonCommonLogger;
  }

  /**
   * @description set className
   * @param className
   */
  public void setClassName(String className) {
    this.className = className;
  }

  /**
   * @description get className
   * @return className
   */
  public String getClassName() {
    return this.className;
  }

  /**
   * @description set methodName
   * @param methodName
   */
  public void setMethodName(String methodName) {
    this.methodName = methodName;
  }

  /**
   * @description get methodName
   * @return methodName
   */
  public String getMethodName() {
    return this.methodName;
  }

  /**
   * @description stack the debugLog
   * @param level
   * @param message
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
   * @description publish FAT_LoggerEvent__e
   */
  public void publish() {
    List<FAT_LoggerEvent__e> events = utils.createLoggerEvent(this);
    List<Database.SaveResult> results = EventBus.publish(events);
    for (Database.SaveResult result : results) {
      FAT_CommonError.handleError(result);
    }
  }

  /**
   * @description clear all debugLogs
   */
  public void clearDebugLogs() {
    this.debugLogs.clear();
  }
}
