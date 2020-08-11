/**
 * @name FAT_CommonTriggerServiceMock.cls
 * @description service for FAT_CommonTrigger
 */
@SuppressWarnings('PMD.EmptyStatementBlock')
@isTest(SeeAllData=false)
public with sharing class FAT_CommonTriggerServiceMock implements FAT_ITriggerObserver {
  /**
   * @description Custom Exception
   */
  public class CustomException extends Exception {
  }

  // Logger Variable
  private final FAT_CommonLogger logger = FAT_CommonLogger.getInstance();

  // Instance Variables
  private FAT_CommonTriggerHandler handler;

  /**
   * @description constructor with no parameter
   */
  public FAT_CommonTriggerServiceMock() {
    this.setMethodName('FAT_CommonTriggerServiceMock');
  }

  /**
   * @description set method name
   * @param methodName
   */
  private void setMethodName(String methodName) {
    logger.setClassName(FAT_CommonTriggerServiceMock.class.getName());
    logger.setMethodName(methodName);
  }

  /**
   * @description store TriggerObserver
   * @param handler
   * @return (FAT_ITriggerObserver) this
   */
  public FAT_ITriggerObserver storeTriggerObserver(
    FAT_CommonTriggerHandler handler
  ) {
    this.setMethodName('storeTriggerObserver');

    this.handler = handler;
    return (FAT_ITriggerObserver) this;
  }

  /**
   * @description custom action in case of before insert
   */
  public void onBeforeInsert() {
  }

  /**
   * @description custom action in case of before update
   */
  public void onBeforeUpdate() {
  }

  /**
   * @description custom action in case of before delete
   */
  public void onBeforeDelete() {
  }

  /**
   * @description custom action in case of after insert
   */
  public void onAfterInsert() {
  }

  /**
   * @description custom action in case of after update
   */
  public void onAfterUpdate() {
  }

  /**
   * @description custom action in case of after delete
   */
  public void onAfterDelete() {
  }

  /**
   * @description custom action in case of after undelete
   */
  public void onAfterUndelete() {
  }
}
