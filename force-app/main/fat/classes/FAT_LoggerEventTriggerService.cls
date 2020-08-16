/**
 * @name FAT_LoggerEventTriggerService.cls
 * @description service for LoggerEventTrigger
 */
public without sharing class FAT_LoggerEventTriggerService {
  /**
   * @description fetch all debugLogs
   */
  public static void fetchDebugLogs() {
    List<FAT_LoggerEvent__e> events = (List<FAT_LoggerEvent__e>) Trigger.new;
    for (FAT_LoggerEvent__e event : events) {
      FAT_CommonLogger logger = (FAT_CommonLogger) JSON.deserialize(
        event.Logger__c,
        FAT_CommonLogger.class
      );
      logger.fetch();
    }
  }
}
