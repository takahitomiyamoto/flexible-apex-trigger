/**
 * @name FAT_CommonTriggerHelper.cls
 * @description helper for FAT_CommonTriggerHandler
 */
public without sharing class FAT_CommonTriggerHelper {
  // Logger Variable
  private final EAL_Logger logger = EAL_Logger.getInstance();

  // Class Variables
  private static FAT_CommonTriggerHelper singleton = new FAT_CommonTriggerHelper();

  // Observer Variables
  @TestVisible
  private List<FAT_ITriggerObserver> beforeInserts = new List<FAT_ITriggerObserver>();
  @TestVisible
  private List<FAT_ITriggerObserver> beforeUpdates = new List<FAT_ITriggerObserver>();
  @TestVisible
  private List<FAT_ITriggerObserver> beforeDeletes = new List<FAT_ITriggerObserver>();
  @TestVisible
  private List<FAT_ITriggerObserver> afterInserts = new List<FAT_ITriggerObserver>();
  @TestVisible
  private List<FAT_ITriggerObserver> afterUpdates = new List<FAT_ITriggerObserver>();
  @TestVisible
  private List<FAT_ITriggerObserver> afterDeletes = new List<FAT_ITriggerObserver>();
  @TestVisible
  private List<FAT_ITriggerObserver> afterUndeletes = new List<FAT_ITriggerObserver>();

  /**
   * @description private constructor with no parameter
   */
  private FAT_CommonTriggerHelper() {
    this.setMethodName('FAT_CommonTriggerHelper');
  }

  /**
   * @description set method name
   * @param methodName
   */
  private void setMethodName(String methodName) {
    logger.setClassName(FAT_CommonTriggerHelper.class.getName());
    logger.setMethodName(methodName);
  }

  /**
   * @description add observer
   * @param operation
   * @param observer
   */
  @TestVisible
  private void addObserver(
    TriggerOperation operation,
    FAT_ITriggerObserver observer
  ) {
    this.setMethodName('addObserver');

    if (null == operation) {
      return;
    }

    switch on operation {
      when BEFORE_INSERT {
        this.beforeInserts.add(observer);
      }
      when BEFORE_UPDATE {
        this.beforeUpdates.add(observer);
      }
      when BEFORE_DELETE {
        this.beforeDeletes.add(observer);
      }
      when AFTER_INSERT {
        this.afterInserts.add(observer);
      }
      when AFTER_UPDATE {
        this.afterUpdates.add(observer);
      }
      when AFTER_DELETE {
        this.afterDeletes.add(observer);
      }
      // AFTER_UNDELETE
      when else {
        this.afterUndeletes.add(observer);
      }
    }
  }

  /**
   * @description fetch TriggerObserver
   * @param apexClass
   * @return (FAT_ITriggerObserver) apexClass.newInstance()
   */
  @TestVisible
  private FAT_ITriggerObserver fetchTriggerObserverClass(Type apexClass) {
    this.setMethodName('fetchTriggerObserverClass');

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
  @TestVisible
  private List<TriggerOperation> fetchActiveTriggerOperations(
    FAT_TriggerObserver__mdt triggerObserver
  ) {
    this.setMethodName('fetchActiveTriggerOperations');

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

    logger.store(LoggingLevel.DEBUG, triggerObserver.ApexClass__c);
    logger.store(LoggingLevel.DEBUG, activeTriggerOperation);
    return activeTriggerOperation;
  }

  /**
   * @description add TriggerObserver
   * @param triggerObserver
   */
  @TestVisible
  private void addTriggerObserver(FAT_TriggerObserver__mdt triggerObserver) {
    this.setMethodName('addTriggerObserver');

    if (null == triggerObserver || null == triggerObserver.ApexClass__c) {
      return;
    }

    FAT_ITriggerObserver observer = this.fetchTriggerObserverClass(
      Type.forName(triggerObserver.ApexClass__c)
    );

    if (null == observer) {
      return;
    }

    List<TriggerOperation> activeTriggerOperations = this.fetchActiveTriggerOperations(
      triggerObserver
    );

    for (TriggerOperation operation : activeTriggerOperations) {
      this.addObserver(operation, observer);
    }
  }

  /**
   * @description get the instance
   * @return singleton
   */
  public static FAT_CommonTriggerHelper getInstance() {
    return singleton;
  }

  /**
   * @description get beforeInserts
   * @return this.beforeInserts
   */
  public List<FAT_ITriggerObserver> getBeforeInserts() {
    return this.beforeInserts;
  }

  /**
   * @description get beforeUpdates
   * @return this.beforeUpdates
   */
  public List<FAT_ITriggerObserver> getBeforeUpdates() {
    return this.beforeUpdates;
  }

  /**
   * @description get beforeDeletes
   * @return this.beforeDeletes
   */
  public List<FAT_ITriggerObserver> getBeforeDeletes() {
    return this.beforeDeletes;
  }

  /**
   * @description get afterInserts
   * @return this.afterInserts
   */
  public List<FAT_ITriggerObserver> getAfterInserts() {
    return this.afterInserts;
  }

  /**
   * @description get afterUpdates
   * @return this.afterUpdates
   */
  public List<FAT_ITriggerObserver> getAfterUpdates() {
    return this.afterUpdates;
  }

  /**
   * @description get afterDeletes
   * @return this.afterDeletes
   */
  public List<FAT_ITriggerObserver> getAfterDeletes() {
    return this.afterDeletes;
  }

  /**
   * @description get afterUndeletes
   * @return this.afterUndeletes
   */
  public List<FAT_ITriggerObserver> getAfterUndeletes() {
    return this.afterUndeletes;
  }

  /**
   * @description add triggerObservers
   * @param sObjectName
   */
  public void addTriggerObservers(String sObjectName) {
    this.setMethodName('addTriggerObservers');

    for (FAT_TriggerObserver__mdt triggerObserver : [
      SELECT
        Id,
        DeveloperName,
        SObject__c,
        ApexClass__c,
        Active__c,
        BeforeInsert__c,
        BeforeUpdate__c,
        BeforeDelete__c,
        AfterInsert__c,
        AfterUpdate__c,
        AfterDelete__c,
        AfterUndelete__c
      FROM FAT_TriggerObserver__mdt
      WHERE SObject__c = :sObjectName AND Active__c = TRUE
      ORDER BY DeveloperName ASC
      LIMIT 50000
    ]) {
      this.addTriggerObserver(triggerObserver);
    }
  }

  /**
   * @description clear all observers
   */
  public void clearObservers() {
    this.beforeInserts.clear();
    this.beforeUpdates.clear();
    this.beforeDeletes.clear();
    this.afterInserts.clear();
    this.afterUpdates.clear();
    this.afterDeletes.clear();
    this.afterUndeletes.clear();
  }
}
