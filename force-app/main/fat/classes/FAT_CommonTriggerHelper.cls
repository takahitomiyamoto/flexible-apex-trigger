/**
 * @name FAT_CommonTriggerHelper.cls
 * @description helper for FAT_CommonTriggerHandler
 */
public without sharing class FAT_CommonTriggerHelper {
  // Logger Variable
  private final FAT_CommonLogger logger = FAT_CommonLogger.getInstance();

  // Class Variables
  private static FAT_CommonTriggerHelper singleton = new FAT_CommonTriggerHelper();

  // Instance Variables
  private final FAT_CommonTriggerUtils utils = FAT_CommonTriggerUtils.getInstance();

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
    System.debug(LoggingLevel.FINEST, 'FAT_CommonTriggerHelper');
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
   * @description set triggerObserver
   * @param triggerObserver
   */
  @TestVisible
  private void setTriggerObserver(FAT_TriggerObserver__mdt triggerObserver) {
    if (null == triggerObserver || null == triggerObserver.ApexClass__c) {
      return;
    }

    FAT_ITriggerObserver observer = utils.fetchTriggerObserver(
      Type.forName(triggerObserver.ApexClass__c)
    );

    if (null == observer) {
      return;
    }

    List<TriggerOperation> activeOperations = utils.fetchActiveOperations(
      triggerObserver
    );

    for (TriggerOperation operation : activeOperations) {
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
      this.setTriggerObserver(triggerObserver);
    }
  }
}
