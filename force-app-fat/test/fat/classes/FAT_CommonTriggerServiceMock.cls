/**
 * @name FAT_CommonTriggerServiceMock.cls
 * @description service for FAT_CommonTrigger
 */
@isTest(SeeAllData=false)
public with sharing class FAT_CommonTriggerServiceMock implements FAT_ITriggerObserver {
  /**
   * @description Custom Exception
   */
  public class CustomException extends Exception {
  }

  // Logger Variable
  private final EAL_Logger logger = EAL_Logger.getInstance();

  /**
   * @description set method name
   * @param methodName
   */
  private void setMethodName(String methodName) {
    logger.setClassName(FAT_CommonTriggerServiceMock.class.getName());
    logger.setMethodName(methodName);
  }

  /**
   * @description constructor with no parameter
   */
  public FAT_CommonTriggerServiceMock() {
    this.setMethodName('FAT_CommonTriggerServiceMock');
  }

  /**
   * @description custom action in case of before insert
   * @param handler
   */
  public void onBeforeInsert(FAT_CommonTriggerHandler handler) {
    logger.setMethodName('onBeforeInsert');
  }

  /**
   * @description custom action in case of before update
   * @param handler
   */
  public void onBeforeUpdate(FAT_CommonTriggerHandler handler) {
    logger.setMethodName('onBeforeUpdate');
  }

  /**
   * @description custom action in case of before delete
   * @param handler
   */
  public void onBeforeDelete(FAT_CommonTriggerHandler handler) {
    logger.setMethodName('onBeforeDelete');
  }

  /**
   * @description custom action in case of after insert
   * @param handler
   */
  public void onAfterInsert(FAT_CommonTriggerHandler handler) {
    logger.setMethodName('onAfterInsert');
  }

  /**
   * @description custom action in case of after update
   * @param handler
   */
  public void onAfterUpdate(FAT_CommonTriggerHandler handler) {
    logger.setMethodName('onAfterUpdate');
  }

  /**
   * @description custom action in case of after delete
   * @param handler
   */
  public void onAfterDelete(FAT_CommonTriggerHandler handler) {
    logger.setMethodName('onAfterDelete');
  }

  /**
   * @description custom action in case of after undelete
   * @param handler
   */
  public void onAfterUndelete(FAT_CommonTriggerHandler handler) {
    logger.setMethodName('onAfterDelete');
  }
}
