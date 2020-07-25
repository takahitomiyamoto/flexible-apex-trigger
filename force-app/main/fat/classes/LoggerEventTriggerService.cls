/**
 * @name LoggerEventTriggerService.cls
 * @description service for LoggerEventTrigger
 */
public without sharing class LoggerEventTriggerService {
  /**
   * @name fetchDebugLogs
   * @description fetch all debugLogs
   */
  public static void fetchDebugLogs() {
    List<LoggerEvent__e> events = (List<LoggerEvent__e>) Trigger.new;
    for (LoggerEvent__e event : events) {
      CommonLogger logger = (CommonLogger) JSON.deserialize(
        event.Logger__c,
        CommonLogger.class
      );
      logger.fetchDebugLogs();
    }
  }
}
