/**
 * @name AccountTriggerValidationTest.cls
 * @description test class for AccountTriggerValidation
 */
@isTest(SeeAllData=false)
private class AccountTriggerValidationTest {
  private static AccountTriggerValidation service = new AccountTriggerValidation();

  @testSetup
  static void setup() {
    List<Account> accounts = AccountTestUtils.createNormalAccounts();
    AccountTestUtils.insertAccounts(accounts);
  }

  @isTest
  static void validatePhone() {
    List<Account> accounts = AccountTestUtils.selectAccounts();

    Test.startTest();
    service.validatePhone(accounts);
    Test.stopTest();

    System.assertNotEquals(0, accounts.size(), 'validatePhone');
  }

  @isTest
  static void validatePhoneNull() {
    List<Account> accounts = null;

    Test.startTest();
    service.validatePhone(accounts);
    Test.stopTest();

    System.assertEquals(null, accounts, 'validatePhoneNull');
  }

  @isTest
  static void onBeforeInsertNull() {
    FAT_CommonTriggerHandler handler = null;

    Test.startTest();
    service.onBeforeInsert(handler);
    Test.stopTest();

    System.assertEquals(null, handler, 'onBeforeInsertNull');
  }

  @isTest
  static void onBeforeUpdateNull() {
    FAT_CommonTriggerHandler handler = null;

    Test.startTest();
    service.onBeforeUpdate(handler);
    Test.stopTest();

    System.assertEquals(null, handler, 'onBeforeUpdateNull');
  }

  @isTest
  static void onBeforeDeleteNull() {
    FAT_CommonTriggerHandler handler = null;

    Test.startTest();
    service.onBeforeDelete(handler);
    Test.stopTest();

    System.assertEquals(null, handler, 'onBeforeDeleteNull');
  }

  @isTest
  static void onAfterInsertNull() {
    FAT_CommonTriggerHandler handler = null;

    Test.startTest();
    service.onAfterInsert(handler);
    Test.stopTest();

    System.assertEquals(null, handler, 'onAfterInsertNull');
  }

  @isTest
  static void onAfterUpdateNull() {
    FAT_CommonTriggerHandler handler = null;

    Test.startTest();
    service.onAfterUpdate(handler);
    Test.stopTest();

    System.assertEquals(null, handler, 'onAfterUpdateNull');
  }

  @isTest
  static void onAfterDeleteNull() {
    FAT_CommonTriggerHandler handler = null;

    Test.startTest();
    service.onAfterDelete(handler);
    Test.stopTest();

    System.assertEquals(null, handler, 'onAfterDeleteNull');
  }

  @isTest
  static void onAfterUndeleteNull() {
    FAT_CommonTriggerHandler handler = null;

    Test.startTest();
    service.onAfterUndelete(handler);
    Test.stopTest();

    System.assertEquals(null, handler, 'onAfterUndeleteNull');
  }
}
