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
   * @description Constructor with parameters
   */
  public CommonTriggerHandler(String sObjectName) {
    logger.setClassName('CommonTriggerHandler');
    logger.setMethodName('CommonTriggerHandler');
    logger.stackDebugLog(LoggingLevel.FINE, '-');

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
    logger.setClassName('CommonTriggerHandler');
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
    logger.setClassName('CommonTriggerHandler');
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
    logger.setClassName('CommonTriggerHandler');
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
    logger.setClassName('CommonTriggerHandler');
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
    logger.setClassName('CommonTriggerHandler');
    logger.setMethodName('onAfterUpdate');
    logger.stackDebugLog(
      LoggingLevel.DEBUG,
      'afterUpdate: ' + afterUpdate.size()
    );
    System.debug('afterUpdate: ' + afterUpdate);
    for (ITriggerObserver triggerObserver : afterUpdate) {
      System.debug('triggerObserver: ' + triggerObserver);
      triggerObserver.onAfterUpdate();
    }
  }

  /**
   * @name onAfterDelete
   * @description custom action in case of after delete
   */
  @TestVisible
  private void onAfterDelete() {
    logger.setClassName('CommonTriggerHandler');
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
    logger.setClassName('CommonTriggerHandler');
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
   * @name addTriggerObserver
   * @description add an observer
   */
  private void addTriggerObserver(
    List<TriggerOperation> triggerOperations,
    ITriggerObserver triggerObserver
  ) {
    logger.setClassName('CommonTriggerHandler');
    logger.setMethodName('addTriggerObserver');
    logger.stackDebugLog(LoggingLevel.FINE, '-');

    if (null == triggerOperations) {
      return;
    }

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
   * @name addTriggerObservers
   * @description add observers
   */
  public void addTriggerObservers(String sObjectName) {
    logger.setClassName('CommonTriggerHandler');
    logger.setMethodName('addTriggerObservers');
    logger.stackDebugLog(LoggingLevel.FINE, '-');

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
      ITriggerObserver observer = CommonTriggerUtils.fetchTriggerObserver(
        Type.forName(triggerObserver.ApexClass__c)
      );
      if (null == observer) {
        continue;
      }

      this.addTriggerObserver(
        CommonTriggerUtils.addActiveTriggerOperations(triggerObserver),
        observer.storeTriggerObserver(this)
      );
    }
  }

  /**
   * @name: isRecursive
   * @description validate whether this is recursive or not
   */
  private Boolean isRecursive() {
    logger.setClassName('CommonTriggerHandler');
    logger.setMethodName('isRecursive');
    logger.stackDebugLog(LoggingLevel.DEBUG, 'firstRun: ' + firstRun);

    if (firstRun) {
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
    logger.setClassName('CommonTriggerHandler');
    logger.setMethodName('invoke');
    logger.stackDebugLog(
      LoggingLevel.DEBUG,
      'sObjectName: ' + this.sObjectName
    );

    try {
      if (this.isRecursive()) {
        return;
      }

      this.addTriggerObservers(this.sObjectName);

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
          firstRun = false;
        }
        when AFTER_UPDATE {
          this.onAfterUpdate();
          firstRun = false;
        }
        when AFTER_DELETE {
          this.onAfterDelete();
          firstRun = false;
        }
        // AFTER_UNDELETE
        when else {
          this.onAfterUndelete();
          firstRun = false;
        }
      }
    } catch (Exception ex) {
      logger.setClassName('CommonTriggerHandler');
      logger.setMethodName('invoke');
      logger.stackDebugLog(
        LoggingLevel.ERROR,
        CommonError.createErrorMessage(ex)
      );
    } finally {
      logger.fetchDebugLogs();
    }
  }
}