/**
 * @name CommonTriggerUtils.cls
 * @description utilities for commonTrigger
 */
public without sharing class CommonTriggerUtils {
  // Logger Variable
  private static final CommonLogger logger = CommonLogger.getInstance();

  /**
   * @name fetchTriggerObserver
   * @description fetch TriggerObserver
   */
  public static ITriggerObserver fetchTriggerObserver(Type apexClass) {
    logger.setClassName('CommonTriggerUtils');
    logger.setMethodName('fetchTriggerObserver');
    logger.stackDebugLog(LoggingLevel.FINE, '-');

    if (null == apexClass) {
      return null;
    }

    return (ITriggerObserver) apexClass.newInstance();
  }

  /**
   * @name addActiveTriggerOperations
   * @description add some active TriggerOperations
   */
  public static List<TriggerOperation> addActiveTriggerOperations(
    TriggerObserver__mdt triggerObserver
  ) {
    logger.setClassName('CommonTriggerUtils');
    logger.setMethodName('addActiveTriggerOperations');
    logger.stackDebugLog(LoggingLevel.DEBUG, triggerObserver.ApexClass__c);

    if (!triggerObserver.Active__c) {
      return null;
    }

    List<TriggerOperation> activeTriggerOperation = new List<TriggerOperation>();

    if (triggerObserver.BeforeInsert__c) {
      activeTriggerOperation.add(TriggerOperation.BEFORE_INSERT);
    }

    if (triggerObserver.BeforeUpdate__c) {
      activeTriggerOperation.add(TriggerOperation.BEFORE_UPDATE);
    }

    if (triggerObserver.BeforeDelete__c) {
      activeTriggerOperation.add(TriggerOperation.BEFORE_DELETE);
    }

    if (triggerObserver.AfterInsert__c) {
      activeTriggerOperation.add(TriggerOperation.AFTER_INSERT);
    }

    if (triggerObserver.AfterUpdate__c) {
      activeTriggerOperation.add(TriggerOperation.AFTER_UPDATE);
    }

    if (triggerObserver.AfterDelete__c) {
      activeTriggerOperation.add(TriggerOperation.AFTER_DELETE);
    }

    if (triggerObserver.AfterUndelete__c) {
      activeTriggerOperation.add(TriggerOperation.AFTER_UNDELETE);
    }

    if (triggerObserver.TestOnly__c) {
      return null;
    }

    logger.setClassName('CommonTriggerUtils');
    logger.setMethodName('addActiveTriggerOperations');
    logger.stackDebugLog(LoggingLevel.DEBUG, activeTriggerOperation);
    return activeTriggerOperation;
  }
}
