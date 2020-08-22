/**
 * @name FAT_CommonTriggerHandlerTest.cls
 * @description test class for FAT_CommonTriggerHandler
 */
@isTest(SeeAllData=false)
private class FAT_CommonTriggerHandlerTest {
  private static FAT_CommonTriggerHandler handler = new FAT_CommonTriggerHandler(
    FAT_CommonTriggerServiceMock.class.getName()
  );

  private static FAT_ITriggerObserver triggerObserver = (FAT_ITriggerObserver) FAT_CommonTriggerServiceMock.class
    .newInstance();

  private static FAT_CommonTriggerHelper helper = FAT_CommonTriggerHelper.getInstance();

  @testSetup
  static void setup() {
    List<Account> accounts = FAT_CommonTestUtils.createNormalAccounts();
    FAT_CommonTestUtils.insertAccounts(accounts);
  }

  @isTest
  static void invokeIsRecursive() {
    FAT_CommonTriggerHandler.firstRun = false;

    Test.startTest();
    handler.invoke();
    Test.stopTest();

    System.assertEquals(
      false,
      FAT_CommonTriggerHandler.firstRun,
      'invokeIsRecursive'
    );
  }

  @isTest
  static void invokeUpdate() {
    List<Account> accounts = FAT_CommonTestUtils.selectAccounts();

    Test.startTest();
    FAT_CommonTestUtils.updateAccounts(accounts);
    Test.stopTest();

    System.assertNotEquals(0, accounts.size(), 'invokeUpdate');
  }

  @isTest
  static void invokeDelete() {
    List<Account> accounts = FAT_CommonTestUtils.selectAccounts();
    FAT_CommonTestUtils.deleteAccounts(accounts);

    Test.startTest();
    FAT_CommonTestUtils.undeleteAccounts(accounts);
    Test.stopTest();

    System.assertNotEquals(0, accounts.size(), 'invokeDelete');
  }

  @isTest
  static void invokeException() {
    List<Account> accounts = FAT_CommonTestUtils.createAbnormalAccounts();

    Test.startTest();
    FAT_CommonTestUtils.insertAccounts(accounts);
    Test.stopTest();

    System.assertNotEquals(0, accounts.size(), 'invokeException');
  }

  @isTest
  static void onBeforeInsert() {
    helper.beforeInserts.add(triggerObserver);

    Test.startTest();
    handler.onBeforeInsert();
    Test.stopTest();

    System.assertEquals(1, helper.beforeInserts.size(), 'onBeforeInsert');
  }

  @isTest
  static void onBeforeUpdate() {
    helper.beforeUpdates.add(triggerObserver);

    Test.startTest();
    handler.onBeforeUpdate();
    Test.stopTest();

    System.assertEquals(1, helper.beforeUpdates.size(), 'onBeforeUpdate');
  }

  @isTest
  static void onBeforeDelete() {
    helper.beforeDeletes.add(triggerObserver);

    Test.startTest();
    handler.onBeforeDelete();
    Test.stopTest();

    System.assertEquals(1, helper.beforeDeletes.size(), 'onBeforeDelete');
  }

  @isTest
  static void onAfterInsert() {
    helper.afterInserts.add(triggerObserver);

    Test.startTest();
    handler.onAfterInsert();
    Test.stopTest();

    System.assertEquals(1, helper.afterInserts.size(), 'onAfterInsert');
  }

  @isTest
  static void onAfterUpdate() {
    helper.afterUpdates.add(triggerObserver);

    Test.startTest();
    handler.onAfterUpdate();
    Test.stopTest();

    System.assertEquals(1, helper.afterUpdates.size(), 'onAfterUpdate');
  }

  @isTest
  static void onAfterDelete() {
    helper.afterDeletes.add(triggerObserver);

    Test.startTest();
    handler.onAfterDelete();
    Test.stopTest();

    System.assertEquals(1, helper.afterDeletes.size(), 'onAfterDelete');
  }

  @isTest
  static void onAfterUndelete() {
    helper.afterUndeletes.add(triggerObserver);

    Test.startTest();
    handler.onAfterUndelete();
    Test.stopTest();

    System.assertEquals(1, helper.afterUndeletes.size(), 'onAfterUndelete');
  }
}
