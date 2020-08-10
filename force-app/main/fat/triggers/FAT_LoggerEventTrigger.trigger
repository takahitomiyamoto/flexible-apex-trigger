/**
 * @name FAT_LoggerEventTrigger.trigger
 * @description trigger for FAT_LoggerEvent__e : You must not use FAT_CommonTriggerHandler
 */
trigger FAT_LoggerEventTrigger on FAT_LoggerEvent__e(after insert) {
  FAT_LoggerEventTriggerService.fetchDebugLogs();
}
