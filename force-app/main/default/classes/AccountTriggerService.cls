/**
 * @name AccountTriggerService.cls
 * @description service for AccountTrigger
 */
public with sharing class AccountTriggerService implements ITriggerObserver {
  // Custom Exception
  public class CustomException extends Exception {
  }

  // Constants
  private static final String NAME_PREFIX_SAMPLE = System.Label.NAME_PREFIX_SAMPLE;

  // Logger Variable
  private final CommonLogger logger = CommonLogger.getInstance();

  // Instance Variables
  private CommonTriggerHandler handler;

  /**
   * @name AccountTriggerService
   * @description constructor with no parameter
   */
  public AccountTriggerService() {
    this.setMethodName('AccountTriggerService');
  }

  /**
   * @name setMethodName
   * @description set method name
   */
  private void setMethodName(String methodName) {
    logger.setClassName(AccountTriggerService.class.getName());
    logger.setMethodName(methodName);
  }

  /**
   * @name addPrefixToName
   * @description 取引先名(Name)項目の先頭に[サンプル]という文字列を付ける。
   */
  @TestVisible
  private void addPrefixToName(List<Account> accounts) {
    this.setMethodName('addPrefixToName');

    if (null == accounts) {
      return;
    }

    for (Account account : accounts) {
      logger.stackDebugLog(LoggingLevel.DEBUG, 'Name: ' + account.Name);
      if (null == account.Name) {
        continue;
      }
      account.Name = NAME_PREFIX_SAMPLE + account.Name;
      logger.stackDebugLog(LoggingLevel.DEBUG, 'Name: ' + account.Name);
    }
  }

  /**
   * @name storeTriggerObserver
   * @description store TriggerObserver
   */
  public ITriggerObserver storeTriggerObserver(CommonTriggerHandler handler) {
    this.setMethodName('storeTriggerObserver');

    this.handler = handler;
    return (ITriggerObserver) this;
  }

  /**
   * @name onBeforeInsert
   * @description custom action in case of before insert
   */
  public void onBeforeInsert() {
    this.setMethodName('onBeforeInsert');

    if (null == handler) {
      return;
    }

    this.addPrefixToName((List<Account>) handler.newObjects);
  }

  /**
   * @name onBeforeUpdate
   * @description custom action in case of before update
   */
  public void onBeforeUpdate() {
  }

  /**
   * @name onBeforeDelete
   * @description custom action in case of before delete
   */
  public void onBeforeDelete() {
  }

  /**
   * @name onAfterInsert
   * @description custom action in case of after insert
   */
  public void onAfterInsert() {
  }

  /**
   * @name onAfterUpdate
   * @description custom action in case of after update
   */
  public void onAfterUpdate() {
  }

  /**
   * @name onAfterDelete
   * @description custom action in case of after delete
   */
  public void onAfterDelete() {
  }

  /**
   * @name onAfterUndelete
   * @description custom action in case of after undelete
   */
  public void onAfterUndelete() {
  }
}
