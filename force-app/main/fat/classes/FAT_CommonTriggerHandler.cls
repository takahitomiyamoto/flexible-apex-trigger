/**
 * @name FAT_CommonTriggerHandler.cls
 * @description base for all trigger handlers
 */
@SuppressWarnings('PMD.TooManyFields')
public without sharing class FAT_CommonTriggerHandler {
  // Logger Variable
  private final FAT_CommonLogger logger = FAT_CommonLogger.getInstance();

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
  private List<FAT_ITriggerObserver> beforeInsert = new List<FAT_ITriggerObserver>();
  @TestVisible
  private List<FAT_ITriggerObserver> beforeUpdate = new List<FAT_ITriggerObserver>();
  @TestVisible
  private List<FAT_ITriggerObserver> beforeDelete = new List<FAT_ITriggerObserver>();
  @TestVisible
  private List<FAT_ITriggerObserver> afterInsert = new List<FAT_ITriggerObserver>();
  @TestVisible
  private List<FAT_ITriggerObserver> afterUpdate = new List<FAT_ITriggerObserver>();
  @TestVisible
  private List<FAT_ITriggerObserver> afterDelete = new List<FAT_ITriggerObserver>();
  @TestVisible
  private List<FAT_ITriggerObserver> afterUndelete = new List<FAT_ITriggerObserver>();

  /**
   * @description constructor with parameters
   * @param sObjectName
   */
  public FAT_CommonTriggerHandler(String sObjectName) {
    this.setMethodName('FAT_CommonTriggerHandler');

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
   * @description set method name
   * @param methodName
   */
  private void setMethodName(String methodName) {
    logger.setClassName(FAT_CommonTriggerHandler.class.getName());
    logger.setMethodName(methodName);
  }

  /**
   * @description custom action in case of before insert
   */
  @TestVisible
  private void onBeforeInsert() {
    this.setMethodName('onBeforeInsert');
    logger.stackDebugLog(
      LoggingLevel.DEBUG,
      'beforeInsert: ' + beforeInsert.size()
    );
    for (FAT_ITriggerObserver triggerObserver : beforeInsert) {
      triggerObserver.onBeforeInsert();
    }
  }

  /**
   * @description custom action in case of before update
   */
  @TestVisible
  private void onBeforeUpdate() {
    this.setMethodName('onBeforeUpdate');
    logger.stackDebugLog(
      LoggingLevel.DEBUG,
      'beforeUpdate: ' + beforeUpdate.size()
    );
    for (FAT_ITriggerObserver triggerObserver : beforeUpdate) {
      triggerObserver.onBeforeUpdate();
    }
  }

  /**
   * @description custom action in case of before delete
   */
  @TestVisible
  private void onBeforeDelete() {
    this.setMethodName('onBeforeDelete');
    logger.stackDebugLog(
      LoggingLevel.DEBUG,
      'beforeDelete: ' + beforeDelete.size()
    );
    for (FAT_ITriggerObserver triggerObserver : beforeDelete) {
      triggerObserver.onBeforeDelete();
    }
  }

  /**
   * @description custom action in case of after insert
   */
  @TestVisible
  private void onAfterInsert() {
    this.setMethodName('onAfterInsert');
    logger.stackDebugLog(
      LoggingLevel.DEBUG,
      'afterInsert: ' + afterInsert.size()
    );
    for (FAT_ITriggerObserver triggerObserver : afterInsert) {
      triggerObserver.onAfterInsert();
    }
  }

  /**
   * @description custom action in case of after update
   */
  @TestVisible
  private void onAfterUpdate() {
    this.setMethodName('onAfterUpdate');
    logger.stackDebugLog(
      LoggingLevel.DEBUG,
      'afterUpdate: ' + afterUpdate.size()
    );
    for (FAT_ITriggerObserver triggerObserver : afterUpdate) {
      triggerObserver.onAfterUpdate();
    }
  }

  /**
   * @description custom action in case of after delete
   */
  @TestVisible
  private void onAfterDelete() {
    this.setMethodName('onAfterDelete');
    logger.stackDebugLog(
      LoggingLevel.DEBUG,
      'afterDelete: ' + afterDelete.size()
    );
    for (FAT_ITriggerObserver triggerObserver : afterDelete) {
      triggerObserver.onAfterDelete();
    }
  }

  /**
   * @description custom action in case of after undelete
   */
  @TestVisible
  private void onAfterUndelete() {
    this.setMethodName('onAfterUndelete');
    logger.stackDebugLog(
      LoggingLevel.DEBUG,
      'afterUndelete: ' + afterUndelete.size()
    );
    for (FAT_ITriggerObserver triggerObserver : afterUndelete) {
      triggerObserver.onAfterUndelete();
    }
  }

  /**
   * @description add an observer
   * @param triggerOperations
   * @param triggerObserver
   */
  private void addTriggerObserver(
    List<TriggerOperation> triggerOperations,
    FAT_ITriggerObserver triggerObserver
  ) {
    this.setMethodName('addTriggerObserver');

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
   * @description add observers
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
        TestOnly__c,
        Active__c,
        BeforeInsert__c,
        BeforeUpdate__c,
        BeforeDelete__c,
        AfterInsert__c,
        AfterUpdate__c,
        AfterDelete__c,
        AfterUndelete__c
      FROM FAT_TriggerObserver__mdt
      WHERE SObject__c = :sObjectName
      ORDER BY DeveloperName ASC
      LIMIT 50000
    ]) {
      FAT_ITriggerObserver observer = FAT_CommonTriggerUtils.fetchTriggerObserver(
        Type.forName(triggerObserver.ApexClass__c)
      );

      if (null == observer) {
        return;
      }

      this.addTriggerObserver(
        FAT_CommonTriggerUtils.addActiveTriggerOperations(triggerObserver),
        observer.storeTriggerObserver(this)
      );
    }
  }

  /**
   * @description validate whether this is recursive or not
   * @return Boolean
   */
  private Boolean isRecursive() {
    this.setMethodName('isRecursive');
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
   * @description invoke each custom action depending on the Apex DML operations
   */
  public void invoke() {
    this.setMethodName('invoke');
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
    } catch (Exception e) {
      logger.stackDebugLog(
        LoggingLevel.ERROR,
        FAT_CommonError.createErrorMessage(e)
      );
    } finally {
      logger.publish();
      logger.clearDebugLogs();
    }
  }
}
