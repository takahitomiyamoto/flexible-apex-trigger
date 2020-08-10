/**
 * @name AccountTriggerValidation.cls
 * @description validation for AccountTrigger
 */
@SuppressWarnings('PMD.EmptyStatementBlock')
public with sharing class AccountTriggerValidation implements FAT_ITriggerObserver {
  /**
   * @description Custom Exception
   */
  public class CustomException extends Exception {
  }

  // Constants
  private static final String ERROR_MESSAGE_PHONE_REQUIRED = System.Label.ERROR_MESSAGE_PHONE_REQUIRED;

  // Logger Variable
  private final FAT_CommonLogger logger = FAT_CommonLogger.getInstance();

  // Instance Variables
  private FAT_CommonTriggerHandler handler;

  /**
   * @description constructor with no parameter
   */
  public AccountTriggerValidation() {
    this.setMethodName('AccountTriggerValidation');
  }

  /**
   * @description set method name
   * @param methodName
   */
  private void setMethodName(String methodName) {
    logger.setClassName(AccountTriggerValidation.class.getName());
    logger.setMethodName(methodName);
  }

  /**
   * @description Fax(FAX)項目に値が入っており、かつ電話(Phone)項目に値が入っていない場合は
   * 「FAXが入っている場合は電話番号も入力してください」というエラーにする。
   * @param accounts
   */
  @TestVisible
  private void validatePhone(List<Account> accounts) {
    this.setMethodName('validatePhone');

    if (null == accounts) {
      return;
    }

    for (Account account : accounts) {
      Boolean hasFax = String.isNotEmpty(account.Fax);
      Boolean hasPhone = String.isNotEmpty(account.Phone);

      logger.stackDebugLog(LoggingLevel.DEBUG, 'hasFax: ' + hasFax);
      logger.stackDebugLog(LoggingLevel.DEBUG, 'hasPhone: ' + hasPhone);

      if (hasFax && !hasPhone) {
        account.Phone.addError(ERROR_MESSAGE_PHONE_REQUIRED);
        throw new CustomException(ERROR_MESSAGE_PHONE_REQUIRED);
      }
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

    if (null == handler) {
      return;
    }

    this.validatePhone((List<Account>) handler.newObjects);
  }

  /**
   * @description custom action in case of before update
   */
  public void onBeforeUpdate() {
    this.setMethodName('onBeforeUpdate');

    if (null == handler) {
      return;
    }

    this.validatePhone((List<Account>) handler.newObjects);
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
