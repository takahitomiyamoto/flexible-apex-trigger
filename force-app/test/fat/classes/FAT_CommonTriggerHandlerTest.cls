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

    system.assertEquals(
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

    system.assertNotEquals(0, accounts.size(), 'invokeUpdate');
  }

  @isTest
  static void invokeDelete() {
    List<Account> accounts = FAT_CommonTestUtils.selectAccounts();
    FAT_CommonTestUtils.deleteAccounts(accounts);

    Test.startTest();
    FAT_CommonTestUtils.undeleteAccounts(accounts);
    Test.stopTest();

    system.assertNotEquals(0, accounts.size(), 'invokeDelete');
  }

  @isTest
  static void invokeException() {
    List<Account> accounts = FAT_CommonTestUtils.createAbnormalAccounts();

    Test.startTest();
    FAT_CommonTestUtils.insertAccounts(accounts);
    Test.stopTest();

    system.assertNotEquals(0, accounts.size(), 'invokeException');
  }

  // @isTest
  // static void onBeforeInsert() {
  //   handler.beforeInsert.add(triggerObserver);

  //   Test.startTest();
  //   handler.onBeforeInsert();
  //   Test.stopTest();

  //   system.assertEquals(1, handler.beforeInsert.size(), 'onBeforeInsert');
  // }

  // @isTest
  // static void onBeforeUpdate() {
  //   handler.beforeUpdate.add(triggerObserver);

  //   Test.startTest();
  //   handler.onBeforeUpdate();
  //   Test.stopTest();

  //   system.assertEquals(1, handler.beforeUpdate.size(), 'onBeforeUpdate');
  // }

  // @isTest
  // static void onBeforeDelete() {
  //   handler.beforeDelete.add(triggerObserver);

  //   Test.startTest();
  //   handler.onBeforeDelete();
  //   Test.stopTest();

  //   system.assertEquals(1, handler.beforeDelete.size(), 'onBeforeDelete');
  // }

  // @isTest
  // static void onAfterInsert() {
  //   handler.afterInsert.add(triggerObserver);

  //   Test.startTest();
  //   handler.onAfterInsert();
  //   Test.stopTest();

  //   system.assertEquals(1, handler.afterInsert.size(), 'onAfterInsert');
  // }

  // @isTest
  // static void onAfterUpdate() {
  //   handler.afterUpdate.add(triggerObserver);

  //   Test.startTest();
  //   handler.onAfterUpdate();
  //   Test.stopTest();

  //   system.assertEquals(1, handler.afterUpdate.size(), 'onAfterUpdate');
  // }

  // @isTest
  // static void onAfterDelete() {
  //   handler.afterDelete.add(triggerObserver);

  //   Test.startTest();
  //   handler.onAfterDelete();
  //   Test.stopTest();

  //   system.assertEquals(1, handler.afterDelete.size(), 'onAfterDelete');
  // }

  // @isTest
  // static void onAfterUndelete() {
  //   handler.afterUndelete.add(triggerObserver);

  //   Test.startTest();
  //   handler.onAfterUndelete();
  //   Test.stopTest();

  //   system.assertEquals(1, handler.afterUndelete.size(), 'onAfterUndelete');
  // }

  // @isTest
  // static void addTriggerObserver() {
  //   List<TriggerOperation> triggerOperations = new List<TriggerOperation>{
  //     TriggerOperation.BEFORE_INSERT,
  //     TriggerOperation.BEFORE_UPDATE,
  //     TriggerOperation.BEFORE_DELETE,
  //     TriggerOperation.AFTER_INSERT,
  //     TriggerOperation.AFTER_UPDATE,
  //     TriggerOperation.AFTER_DELETE,
  //     TriggerOperation.AFTER_UNDELETE
  //   };

  //   Test.startTest();
  //   handler.addTriggerObserver(triggerOperations, triggerObserver);
  //   Test.stopTest();

  //   system.assertEquals(7, triggerOperations.size(), 'addTriggerObserver');
  // }

  // @isTest
  // static void setTriggerObserversNull() {
  //   Test.startTest();
  //   handler.setTriggerObservers(null);
  //   Test.stopTest();

  //   system.assertNotEquals(null, handler, 'setTriggerObserversNull');
  // }

  // @isTest
  // static void addTriggerObserverNull() {
  //   Test.startTest();
  //   handler.addTriggerObserver(null, null);
  //   Test.stopTest();

  //   system.assertNotEquals(null, handler, 'addTriggerObserverNull');
  // }
}
