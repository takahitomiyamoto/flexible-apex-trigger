/**
 * @name AccountTriggerTest.cls
 * @description test class for AccountTrigger
 */
@isTest(SeeAllData=false)
private class AccountTriggerTest {
  @testSetup
  static void setup() {
    List<Account> accounts = AccountTestUtils.createNormalAccounts();
    AccountTestUtils.insertAccounts(accounts);
  }

  @isTest
  static void invokeUpdate() {
    List<Account> accounts = AccountTestUtils.selectAccounts();

    Test.startTest();
    AccountTestUtils.updateAccounts(accounts);
    Test.stopTest();

    System.assertNotEquals(0, accounts.size(), 'invokeUpdate');
  }

  @isTest
  static void invokeDelete() {
    List<Account> accounts = AccountTestUtils.selectAccounts();
    AccountTestUtils.deleteAccounts(accounts);

    Test.startTest();
    AccountTestUtils.undeleteAccounts(accounts);
    Test.stopTest();

    System.assertNotEquals(0, accounts.size(), 'invokeDelete');
  }

  @isTest
  static void invokeException() {
    List<Account> accounts = AccountTestUtils.createAbnormalAccounts();

    Test.startTest();
    AccountTestUtils.insertAccounts(accounts);
    Test.stopTest();

    System.assertNotEquals(0, accounts.size(), 'invokeException');
  }
}
