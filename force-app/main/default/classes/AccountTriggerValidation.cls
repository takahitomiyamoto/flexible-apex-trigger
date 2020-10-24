/**
 * @name AccountTriggerValidation.cls
 * @description validation for AccountTrigger
 */
public with sharing class AccountTriggerValidation implements FAT_ITriggerObserver {
  /**
   * @description Custom Exception
   */
  public class CustomException extends Exception {
  }

  // Constants
  private static final String ERROR_MESSAGE_PHONE_REQUIRED = System.Label.ERROR_MESSAGE_PHONE_REQUIRED;

  // Logger Variable
  private final EAL_Logger logger = EAL_Logger.getInstance();

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

      logger.store(LoggingLevel.DEBUG, 'hasFax: ' + hasFax);
      logger.store(LoggingLevel.DEBUG, 'hasPhone: ' + hasPhone);

      if (hasFax && !hasPhone) {
        account.Phone.addError(ERROR_MESSAGE_PHONE_REQUIRED);
        CustomException e = new CustomException();
        e.setMessage(ERROR_MESSAGE_PHONE_REQUIRED);
        throw e;
      }
    }
  }

  /**
   * @description constructor with no parameter
   */
  public AccountTriggerValidation() {
    this.setMethodName('AccountTriggerValidation');
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

    this.validatePhone((List<Account>) handler.newObjects);
  }

  /**
   * @description custom action in case of before update
   * @param handler
   */
  public void onBeforeUpdate(FAT_CommonTriggerHandler handler) {
    this.setMethodName('onBeforeUpdate');

    if (null == handler) {
      return;
    }

    this.validatePhone((List<Account>) handler.newObjects);
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
