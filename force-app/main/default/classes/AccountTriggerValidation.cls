/**
 * @name AccountTriggerValidation.cls
 * @description validation for Account Trigger
 */
public with sharing class AccountTriggerValidation implements ITriggerObserver {
  // Custom Exception
  public class CustomException extends Exception {
  }

  // Constants
  private static final String ERROR_MESSAGE_PHONE_REQUIRED = System.Label.ERROR_MESSAGE_PHONE_REQUIRED;

  // Logger Variable
  private final CommonLogger logger = CommonLogger.getInstance();

  // Instance Variables
  private CommonTriggerHandler handler;

  /**
   * @name AccountTriggerValidation
   * @description constructor with no parameter
   */
  public AccountTriggerValidation() {
    logger.setClassName('AccountTriggerValidation');
    logger.setMethodName('AccountTriggerValidation');
    logger.stackDebugLog(LoggingLevel.FINEST, '-');
  }

  /**
   * @name validatePhone
   * @description Fax(FAX)項目に値が入っており、かつ電話(Phone)項目に値が入っていない場合は
   * 「FAXが入っている場合は電話番号も入力してください」というエラーにする。
   */
  @TestVisible
  private void validatePhone(List<Account> accounts) {
    logger.setClassName('AccountTriggerValidation');
    logger.setMethodName('validatePhone');
    logger.stackDebugLog(LoggingLevel.FINE, '-');

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
   * @name storeTriggerObserver
   * @description store TriggerObserver
   */
  public ITriggerObserver storeTriggerObserver(CommonTriggerHandler handler) {
    logger.setClassName('AccountTriggerValidation');
    logger.setMethodName('storeTriggerObserver');
    logger.stackDebugLog(LoggingLevel.FINE, '-');

    this.handler = handler;
    return (ITriggerObserver) this;
  }

  /**
   * @name onBeforeInsert
   * @description custom action in case of before insert
   */
  public void onBeforeInsert() {
    logger.setClassName('AccountTriggerValidation');
    logger.setMethodName('onBeforeInsert');
    logger.stackDebugLog(LoggingLevel.FINE, '-');

    if (null == handler) {
      return;
    }

    this.validatePhone((List<Account>) handler.newObjects);
  }

  /**
   * @name onBeforeUpdate
   * @description custom action in case of before update
   */
  public void onBeforeUpdate() {
    logger.setClassName('AccountTriggerValidation');
    logger.setMethodName('onBeforeUpdate');
    logger.stackDebugLog(LoggingLevel.FINE, '-');

    if (null == handler) {
      return;
    }

    this.validatePhone((List<Account>) handler.newObjects);
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
