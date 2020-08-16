/**
 * @name AccountTriggerService.cls
 * @description service for AccountTrigger
 */
@SuppressWarnings('PMD.EmptyStatementBlock')
public with sharing class AccountTriggerService implements FAT_ITriggerObserver {
  /**
   * @description Custom Exception
   */
  public class CustomException extends Exception {
  }

  // Constants
  private static final String NAME_PREFIX_SAMPLE = System.Label.NAME_PREFIX_SAMPLE;

  // Logger Variable
  private final FAT_CommonLogger logger = FAT_CommonLogger.getInstance();

  // Instance Variables
  private FAT_CommonTriggerHandler handler;

  /**
   * @description constructor with no parameter
   */
  public AccountTriggerService() {
    this.setMethodName('AccountTriggerService');
  }

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
    this.setMethodName('onBeforeInsert');

    if (null == this.handler) {
      return;
    }

    this.addPrefixToName((List<Account>) this.handler.newObjects);
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
