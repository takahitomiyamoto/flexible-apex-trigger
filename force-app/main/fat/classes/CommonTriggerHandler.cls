/**
 * @name CommonTriggerHandler.cls
 * @description base for all trigger handlers
 */
public without sharing class CommonTriggerHandler {
  // Custom Exception
  private class CommonException extends Exception {
  }

  // Logger Variable
  private final CommonLogger logger = CommonLogger.getInstance();

  // Class Variables
  public static Boolean firstRun = true;

  // Instance Variables
  public List<sObject> oldObjects;
  public List<sObject> newObjects;
  public Map<ID, sObject> oldObjectMap;
  public Map<ID, sObject> newObjectMap;
  private String sObjectName;
  private Boolean triggerIsExecuting;
  private Integer triggerSize;
  private TriggerOperation triggerOperationType;

  @TestVisible
  private List<ITriggerObserver> beforeInsert = new List<ITriggerObserver>();
  @TestVisible
  private List<ITriggerObserver> beforeUpdate = new List<ITriggerObserver>();
  @TestVisible
  private List<ITriggerObserver> beforeDelete = new List<ITriggerObserver>();
  @TestVisible
  private List<ITriggerObserver> afterInsert = new List<ITriggerObserver>();
  @TestVisible
  private List<ITriggerObserver> afterUpdate = new List<ITriggerObserver>();
  @TestVisible
  private List<ITriggerObserver> afterDelete = new List<ITriggerObserver>();
  @TestVisible
  private List<ITriggerObserver> afterUndelete = new List<ITriggerObserver>();

  /**
   * @name CommonTriggerHandler
   * @description Constructor with no parameter
   */
  public CommonTriggerHandler(String sObjectName) {
    logger.setClassName('CommonTriggerHandler');
    logger.setMethodName('CommonTriggerHandler');

    this.sObjectName = sObjectName;
    this.oldObjects = Trigger.old;
    this.newObjects = Trigger.new;
    this.oldObjectMap = Trigger.oldMap;
    this.newObjectMap = Trigger.newMap;
    this.triggerIsExecuting = Trigger.isExecuting;
    this.triggerSize = Trigger.size;
    this.triggerOperationType = Trigger.operationType;
  }

  /**
   * @name onBeforeInsert
   * @description custom action in case of before insert
   */
  @TestVisible
  private void onBeforeInsert() {
    logger.setMethodName('onBeforeInsert');
    logger.stackDebugLog(
      LoggingLevel.DEBUG,
      'beforeInsert: ' + beforeInsert.size()
    );
    for (ITriggerObserver triggerObserver : beforeInsert) {
      triggerObserver.onBeforeInsert();
    }
  }

  /**
   * @name onBeforeUpdate
   * @description custom action in case of before update
   */
  @TestVisible
  private void onBeforeUpdate() {
    logger.setMethodName('onBeforeUpdate');
    logger.stackDebugLog(
      LoggingLevel.DEBUG,
      'beforeUpdate: ' + beforeUpdate.size()
    );
    for (ITriggerObserver triggerObserver : beforeUpdate) {
      triggerObserver.onBeforeUpdate();
    }
  }

  /**
   * @name onBeforeDelete
   * @description custom action in case of before delete
   */
  @TestVisible
  private void onBeforeDelete() {
    logger.setMethodName('onBeforeDelete');
    logger.stackDebugLog(
      LoggingLevel.DEBUG,
      'beforeDelete: ' + beforeDelete.size()
    );
    for (ITriggerObserver triggerObserver : beforeDelete) {
      triggerObserver.onBeforeDelete();
    }
  }

  /**
   * @name onAfterInsert
   * @description custom action in case of after insert
   */
  @TestVisible
  private void onAfterInsert() {
    logger.setMethodName('onAfterInsert');
    logger.stackDebugLog(
      LoggingLevel.DEBUG,
      'afterInsert: ' + afterInsert.size()
    );
    for (ITriggerObserver triggerObserver : afterInsert) {
      triggerObserver.onAfterInsert();
    }
  }

  /**
   * @name: onAfterUpdate
   * @description custom action in case of after update
   */
  @TestVisible
  private void onAfterUpdate() {
    logger.setMethodName('onAfterUpdate');
    logger.stackDebugLog(
      LoggingLevel.DEBUG,
      'afterUpdate: ' + afterUpdate.size()
    );
    for (ITriggerObserver triggerObserver : afterUpdate) {
      triggerObserver.onAfterUpdate();
    }
  }

  /**
   * @name onAfterDelete
   * @description custom action in case of after delete
   */
  @TestVisible
  private void onAfterDelete() {
    logger.setMethodName('onAfterDelete');
    logger.stackDebugLog(
      LoggingLevel.DEBUG,
      'afterDelete: ' + afterDelete.size()
    );
    for (ITriggerObserver triggerObserver : afterDelete) {
      triggerObserver.onAfterDelete();
    }
  }

  /**
   * @name onAfterUndelete
   * @description custom action in case of after undelete
   */
  @TestVisible
  private void onAfterUndelete() {
    logger.setMethodName('onAfterUndelete');
    logger.stackDebugLog(
      LoggingLevel.DEBUG,
      'afterUndelete: ' + afterUndelete.size()
    );
    for (ITriggerObserver triggerObserver : afterUndelete) {
      triggerObserver.onAfterUndelete();
    }
  }

  /**
   * @name addObserver
   * @description add an observer
   */
  private void addObserver(
    List<TriggerOperation> triggerOperations,
    ITriggerObserver triggerObserver
  ) {
    logger.setMethodName('addObserver');

    for (TriggerOperation triggerOperation : triggerOperations) {
      switch on triggerOperation {
        when BEFORE_INSERT {
          beforeInsert.add(triggerObserver);
        }
        when BEFORE_UPDATE {
          beforeUpdate.add(triggerObserver);
        }
        when BEFORE_DELETE {
          beforeDelete.add(triggerObserver);
        }
        when AFTER_INSERT {
          afterInsert.add(triggerObserver);
        }
        when AFTER_UPDATE {
          afterUpdate.add(triggerObserver);
        }
        when AFTER_DELETE {
          afterDelete.add(triggerObserver);
        }
        // AFTER_UNDELETE
        when else {
          afterUndelete.add(triggerObserver);
        }
      }
    }
  }

  /**
   * @name createTriggerObserver
   * @description create TriggerObserver
   */
  @TestVisible
  private ITriggerObserver createTriggerObserver(Type apexClass) {
    if (null == apexClass) {
      return null;
    }

    ITriggerObserver observer = (ITriggerObserver) apexClass.newInstance();
    return observer.getTriggerObserver(this);
  }

  /**
   * @name addActiveTriggerOperations
   * @description add some active TriggerOperations
   */
  private void addActiveTriggerOperations(
    TriggerObserver__mdt triggerObserver
  ) {
    logger.setMethodName('addActiveTriggerOperations');

    if (!triggerObserver.Active__c) {
      return;
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
      return;
    }

    ITriggerObserver activeTriggerObserver = this.createTriggerObserver(
      Type.forName(triggerObserver.ApexClass__c)
    );
    this.addObserver(activeTriggerOperation, activeTriggerObserver);
  }

  /**
   * @name addObservers
   * @description add observers
   */
  @TestVisible
  private void addObservers(String sObjectName) {
    logger.setMethodName('addObservers');

    for (TriggerObserver__mdt triggerObserver : [
      SELECT
        Id,
        DeveloperName,
        SObject__c,
        ApexClass__c,
        TestOnly__c,
        Active__c,
        BeforeInsert__c,
        BeforeUpdate__c,
        BeforeDelete__c,
        AfterInsert__c,
        AfterUpdate__c,
        AfterDelete__c,
        AfterUndelete__c
      FROM TriggerObserver__mdt
      WHERE SObject__c = :sObjectName
      ORDER BY DeveloperName ASC
      LIMIT 50000
    ]) {
      this.addActiveTriggerOperations(triggerObserver);
    }
  }

  /**
   * @name: isRecursive
   * @description validate whether this is recursive or not
   */
  @TestVisible
  private Boolean isRecursive() {
    logger.setMethodName('isRecursive');
    logger.stackDebugLog(
      LoggingLevel.DEBUG,
      'firstRun: ' + CommonTriggerHandler.firstRun
    );

    if (CommonTriggerHandler.firstRun) {
      return false;
    } else if (TriggerOperation.AFTER_UNDELETE === this.triggerOperationType) {
      return false;
    } else {
      return true;
    }
  }

  /**
   * @name invoke
   * @description invoke each custom action depending on the Apex DML operations
   */
  public void invoke() {
    logger.setMethodName('invoke');

    try {
      if (this.isRecursive()) {
        return;
      }

      this.addObservers(this.sObjectName);

      switch on Trigger.operationType {
        when BEFORE_INSERT {
          this.onBeforeInsert();
        }
        when BEFORE_UPDATE {
          this.onBeforeUpdate();
        }
        when BEFORE_DELETE {
          this.onBeforeDelete();
        }
        when AFTER_INSERT {
          this.onAfterInsert();
          CommonTriggerHandler.firstRun = false;
        }
        when AFTER_UPDATE {
          this.onAfterUpdate();
          CommonTriggerHandler.firstRun = false;
        }
        when AFTER_DELETE {
          this.onAfterDelete();
          CommonTriggerHandler.firstRun = false;
        }
        // AFTER_UNDELETE
        when else {
          this.onAfterUndelete();
          CommonTriggerHandler.firstRun = false;
        }
      }
    } catch (Exception ex) {
      logger.stackDebugLog(
        LoggingLevel.ERROR,
        CommonError.createErrorMessage(ex)
      );
    } finally {
      logger.fetchDebugLogs();
    }
  }
}
