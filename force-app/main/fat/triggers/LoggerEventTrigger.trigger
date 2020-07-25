/**
 * @name LoggerEventTrigger.trigger
 * @description trigger for LoggerEvent__e : You must not use CommonTriggerHandler
 */
trigger LoggerEventTrigger on LoggerEvent__e(after insert) {
  LoggerEventTriggerService.fetchDebugLogs();
}
