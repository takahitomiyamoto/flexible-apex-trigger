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

  @isTest
  static void onBeforeInsert() {
    handler.beforeInsert.add(triggerObserver);

    Test.startTest();
    handler.onBeforeInsert();
    Test.stopTest();

    system.assertEquals(1, handler.beforeInsert.size(), 'onBeforeInsert');
  }

  @isTest
  static void onBeforeUpdate() {
    handler.beforeUpdate.add(triggerObserver);

    Test.startTest();
    handler.onBeforeUpdate();
    Test.stopTest();

    system.assertEquals(1, handler.beforeUpdate.size(), 'onBeforeUpdate');
  }

  @isTest
  static void onBeforeDelete() {
    handler.beforeDelete.add(triggerObserver);

    Test.startTest();
    handler.onBeforeDelete();
    Test.stopTest();

    system.assertEquals(1, handler.beforeDelete.size(), 'onBeforeDelete');
  }

  @isTest
  static void onAfterInsert() {
    handler.afterInsert.add(triggerObserver);

    Test.startTest();
    handler.onAfterInsert();
    Test.stopTest();

    system.assertEquals(1, handler.afterInsert.size(), 'onAfterInsert');
  }

  @isTest
  static void onAfterUpdate() {
    handler.afterUpdate.add(triggerObserver);

    Test.startTest();
    handler.onAfterUpdate();
    Test.stopTest();

    system.assertEquals(1, handler.afterUpdate.size(), 'onAfterUpdate');
  }

  @isTest
  static void onAfterDelete() {
    handler.afterDelete.add(triggerObserver);

    Test.startTest();
    handler.onAfterDelete();
    Test.stopTest();

    system.assertEquals(1, handler.afterDelete.size(), 'onAfterDelete');
  }

  @isTest
  static void onAfterUndelete() {
    handler.afterUndelete.add(triggerObserver);

    Test.startTest();
    handler.onAfterUndelete();
    Test.stopTest();

    system.assertEquals(1, handler.afterUndelete.size(), 'onAfterUndelete');
  }

  @isTest
  static void addTriggerObservers() {
    Test.startTest();
    handler.addTriggerObservers(Account.class.getName());
    Test.stopTest();

    system.assertNotEquals(null, handler, 'addTriggerObservers');
  }

  @isTest
  static void invoke() {
    Test.startTest();
    handler.invoke();
    Test.stopTest();

    system.assertNotEquals(null, handler, 'invoke');
  }
}
