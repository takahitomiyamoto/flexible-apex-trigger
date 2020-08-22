/**
 * @name FAT_CommonTriggerHandler.cls
 * @description base for all trigger handlers
 */
public without sharing class FAT_CommonTriggerHandler {
  // Logger Variable
  private final FAT_CommonLogger logger = FAT_CommonLogger.getInstance();

  // Helper Variable
  private final FAT_CommonTriggerHelper helper = FAT_CommonTriggerHelper.getInstance();

  // Class Variables
  @TestVisible
  private static Boolean firstRun = true;

  // Instance Variables
  private String sObjectName;
  private Boolean triggerIsExecuting;
  private Integer triggerSize;
  private TriggerOperation triggerOperationType;
  public List<sObject> oldObjects;
  public List<sObject> newObjects;
  public Map<Id, sObject> oldObjectMap;
  public Map<Id, sObject> newObjectMap;

  /**
   * @description constructor with parameters
   * @param sObjectName
   */
  private FAT_CommonTriggerHandler(String sObjectName) {
    this.setMethodName('FAT_CommonTriggerHandler');

    this.sObjectName = sObjectName;
    this.oldObjects = Trigger.old;
    this.newObjects = Trigger.new;
    this.oldObjectMap = Trigger.oldMap;
    this.newObjectMap = Trigger.newMap;
    this.triggerIsExecuting = Trigger.isExecuting;
    this.triggerSize = Trigger.size;
    this.triggerOperationType = Trigger.operationType;

    logger.store(LoggingLevel.DEBUG, 'sObjectName: ' + this.sObjectName);
    logger.store(LoggingLevel.DEBUG, 'IsExecuting: ' + this.triggerIsExecuting);
    logger.store(LoggingLevel.DEBUG, 'Size: ' + this.triggerSize);
    logger.store(LoggingLevel.DEBUG, 'Type: ' + this.triggerOperationType);
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
   * @description notifyObservers for before insert
   */
  @TestVisible
  private void onBeforeInsert() {
    this.setMethodName('onBeforeInsert');
    List<FAT_ITriggerObserver> beforeInserts = helper.getBeforeInserts();
    logger.store(LoggingLevel.DEBUG, 'size: ' + beforeInserts.size());
    for (FAT_ITriggerObserver triggerObserver : beforeInserts) {
      triggerObserver.onBeforeInsert(this);
    }
  }

  /**
   * @description notifyObservers for before update
   */
  @TestVisible
  private void onBeforeUpdate() {
    this.setMethodName('onBeforeUpdate');
    List<FAT_ITriggerObserver> beforeUpdates = helper.getBeforeUpdates();
    logger.store(LoggingLevel.DEBUG, 'size: ' + beforeUpdates.size());
    for (FAT_ITriggerObserver triggerObserver : beforeUpdates) {
      triggerObserver.onBeforeUpdate(this);
    }
  }

  /**
   * @description notifyObservers for before delete
   */
  @TestVisible
  private void onBeforeDelete() {
    this.setMethodName('onBeforeDelete');
    List<FAT_ITriggerObserver> beforeDeletes = helper.getBeforeDeletes();
    logger.store(LoggingLevel.DEBUG, 'size: ' + beforeDeletes.size());
    for (FAT_ITriggerObserver triggerObserver : beforeDeletes) {
      triggerObserver.onBeforeDelete(this);
    }
  }

  /**
   * @description notifyObservers for after insert
   */
  @TestVisible
  private void onAfterInsert() {
    this.setMethodName('onAfterInsert');
    List<FAT_ITriggerObserver> afterInserts = helper.getAfterInserts();
    logger.store(LoggingLevel.DEBUG, 'size: ' + afterInserts.size());
    for (FAT_ITriggerObserver triggerObserver : afterInserts) {
      triggerObserver.onAfterInsert(this);
    }
  }

  /**
   * @description notifyObservers for after update
   */
  @TestVisible
  private void onAfterUpdate() {
    this.setMethodName('onAfterUpdate');
    List<FAT_ITriggerObserver> afterUpdates = helper.getAfterUpdates();
    logger.store(LoggingLevel.DEBUG, 'size: ' + afterUpdates.size());
    for (FAT_ITriggerObserver triggerObserver : afterUpdates) {
      triggerObserver.onAfterUpdate(this);
    }
  }

  /**
   * @description notifyObservers for after delete
   */
  @TestVisible
  private void onAfterDelete() {
    this.setMethodName('onAfterDelete');
    List<FAT_ITriggerObserver> afterDeletes = helper.getAfterDeletes();
    logger.store(LoggingLevel.DEBUG, 'size: ' + afterDeletes.size());
    for (FAT_ITriggerObserver triggerObserver : afterDeletes) {
      triggerObserver.onAfterDelete(this);
    }
  }

  /**
   * @description notifyObservers for after undelete
   */
  @TestVisible
  private void onAfterUndelete() {
    this.setMethodName('onAfterUndelete');
    List<FAT_ITriggerObserver> afterUndeletes = helper.getAfterUndeletes();
    logger.store(LoggingLevel.DEBUG, 'size: ' + afterUndeletes.size());
    for (FAT_ITriggerObserver triggerObserver : afterUndeletes) {
      triggerObserver.onAfterUndelete(this);
    }
  }

  /**
   * @description validate whether this is recursive or not
   * @return Boolean
   */
  @TestVisible
  private Boolean isRecursive() {
    this.setMethodName('isRecursive');
    logger.store(LoggingLevel.DEBUG, 'firstRun: ' + firstRun);

    if (firstRun) {
      return false;
    } else if (TriggerOperation.AFTER_UNDELETE === this.triggerOperationType) {
      return false;
    } else {
      return true;
    }
  }

  /**
   * @description get the instance
   * @param sObjectClass
   * @return new FAT_CommonTriggerHandler(objectClass.getName())
   */
  public static FAT_CommonTriggerHandler create(Type sObjectClass) {
    return new FAT_CommonTriggerHandler(sObjectClass.getName());
  }

  /**
   * @description invoke each custom action depending on the Apex DML operations
   */
  public void invoke() {
    this.setMethodName('invoke');

    try {
      if (this.isRecursive()) {
        return;
      }

      helper.addTriggerObservers(this.sObjectName);

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
      logger.store(LoggingLevel.ERROR, FAT_CommonError.createErrorMessage(e));
    } finally {
      logger.publish();
      logger.clear();
    }
  }
}
