/**
 * @name AccountTriggerService.cls
 * @description service for AccountTrigger
 */
public with sharing class AccountTriggerService implements FAT_ITriggerObserver {
  /**
   * @description Custom Exception
   */
  public class CustomException extends Exception {
  }

  // Constants
  private static final String NAME_PREFIX_SAMPLE = System.Label.NAME_PREFIX_SAMPLE;

  // Logger Variable
  private final EAL_Logger logger = EAL_Logger.getInstance();

  /**
   * @description set method name
   * @param methodName
   */
  private void setMethodName(String methodName) {
    logger.setClassName(AccountTriggerService.class.getName());
    logger.setMethodName(methodName);
  }

  /**
   * @description 取引先名(Name)項目の先頭に[サンプル]という文字列を付ける。
   * @param accounts
   */
  @TestVisible
  private void addPrefixToName(List<Account> accounts) {
    this.setMethodName('addPrefixToName');

    if (null == accounts) {
      return;
    }

    for (Account account : accounts) {
      logger.store(LoggingLevel.DEBUG, 'Name: ' + account.Name);
      if (null == account.Name) {
        continue;
      }
      account.Name = NAME_PREFIX_SAMPLE + account.Name;
      logger.store(LoggingLevel.DEBUG, 'Name: ' + account.Name);
    }
  }

  /**
   * @description constructor with no parameter
   */
  public AccountTriggerService() {
    this.setMethodName('AccountTriggerService');
  }

  /**
   * @description custom action in case of before insert
   * @param handler
   */
  public void onBeforeInsert(FAT_CommonTriggerHandler handler) {
    this.setMethodName('onBeforeInsert');

    if (null == handler) {
      return;
    }

    this.addPrefixToName((List<Account>) handler.newObjects);
  }

  /**
   * @description custom action in case of before update
   * @param handler
   */
  public void onBeforeUpdate(FAT_CommonTriggerHandler handler) {
    this.setMethodName('onBeforeUpdate');
  }

  /**
   * @description custom action in case of before delete
   * @param handler
   */
  public void onBeforeDelete(FAT_CommonTriggerHandler handler) {
    this.setMethodName('onBeforeDelete');
  }

  /**
   * @description custom action in case of after insert
   * @param handler
   */
  public void onAfterInsert(FAT_CommonTriggerHandler handler) {
    this.setMethodName('onAfterInsert');
  }

  /**
   * @description custom action in case of after update
   * @param handler
   */
  public void onAfterUpdate(FAT_CommonTriggerHandler handler) {
    this.setMethodName('onAfterUpdate');
  }

  /**
   * @description custom action in case of after delete
   * @param handler
   */
  public void onAfterDelete(FAT_CommonTriggerHandler handler) {
    this.setMethodName('onAfterDelete');
  }

  /**
   * @description custom action in case of after undelete
   * @param handler
   */
  public void onAfterUndelete(FAT_CommonTriggerHandler handler) {
    this.setMethodName('onAfterUndelete');
  }
}
