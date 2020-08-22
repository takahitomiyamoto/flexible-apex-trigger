/**
 * @name FAT_CommonTriggerUtils.cls
 * @description utilities for commonTrigger
 */
@SuppressWarnings('PMD.StdCyclomaticComplexity')
public without sharing class FAT_CommonTriggerUtils {
  // Logger Variable
  private final FAT_CommonLogger logger = FAT_CommonLogger.getInstance();

  // Class Variables
  private static FAT_CommonTriggerUtils singleton = new FAT_CommonTriggerUtils();

  /**
   * @description private constructor with no parameter
   */
  private FAT_CommonTriggerUtils() {
    System.debug(LoggingLevel.FINEST, 'FAT_CommonTriggerUtils');
  }

  /**
   * @description get the instance
   * @return singleton
   */
  public static FAT_CommonTriggerUtils getInstance() {
    return singleton;
  }

  /**
   * @description fetch TriggerObserver
   * @param apexClass
   * @return (FAT_ITriggerObserver) apexClass.newInstance()
   */
  // public static FAT_ITriggerObserver fetchTriggerObserver(Type apexClass) {
  public FAT_ITriggerObserver fetchTriggerObserver(Type apexClass) {
    if (null == apexClass) {
      return null;
    }

    return (FAT_ITriggerObserver) apexClass.newInstance();
  }

  /**
   * @description add some active TriggerOperations
   * @param triggerObserver
   * @return activeTriggerOperation
   */
  @SuppressWarnings('PMD.CyclomaticComplexity')
  public List<TriggerOperation> fetchActiveOperations(
    FAT_TriggerObserver__mdt triggerObserver
  ) {
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

    logger.store(LoggingLevel.DEBUG, activeTriggerOperation);
    return activeTriggerOperation;
  }
}
