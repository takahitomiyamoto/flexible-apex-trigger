/**
 * @name FAT_CommonLogger.cls
 * @description common logger
 */
public without sharing class FAT_CommonLogger {
  // Logger Variable
  private static FAT_CommonLogger singleton = new FAT_CommonLogger();

  // Utils Variable
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
   * @description stack the debugLog with defaultLevel
   * @param defaultLevel
   * @param level
   * @param message
   */
  @TestVisible
  private void storeDefaultDebugLog(
    LoggingLevel defaultLevel,
    LoggingLevel level,
    Object message
  ) {
    if (utils.notLogging(defaultLevel)) {
      return;
    }
    if (utils.isHigherLevel(level, defaultLevel)) {
      String logMessage = utils.createLogMessage(getMethodName(), message);
      String debugLog = utils.createDebugLog(level, getClassName(), logMessage);
      this.debugLogs.add(debugLog);
    }
  }

  /**
   * @description get the instance
   * @return FAT_CommonLogger
   */
  public static FAT_CommonLogger getInstance() {
    return singleton;
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
   * @description store the debugLog
   * @param level
   * @param message
   */
  public void store(LoggingLevel level, Object message) {
    LoggingLevel defaultLevel = utils.getDefaultLoggingLevel();
    this.storeDefaultDebugLog(defaultLevel, level, message);
  }

  /**
   * @description fetch all debugLogs
   */
  public void fetch() {
    Boolean isEmpty = 0 == this.debugLogs.size();
    if (isEmpty) {
      return;
    }

    if (utils.archivable()) {
      String logMessage = utils.createLogMessage(this.debugLogs);
      utils.archiveLoggerObject(logMessage);
    }
  }

  /**
   * @description publish FAT_LoggerEvent__e
   */
  public void publish() {
    List<FAT_LoggerEvent__e> events = utils.createLoggerEvent(this);
    List<Database.SaveResult> results = EventBus.publish(events);
    FAT_CommonError.handleErrors(results);
  }

  /**
   * @description clear all debugLogs
   */
  public void clear() {
    this.debugLogs.clear();
  }
}
