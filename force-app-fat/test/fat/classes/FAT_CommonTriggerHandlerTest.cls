/**
 * @name FAT_CommonTriggerHandlerTest.cls
 * @description test class for FAT_CommonTriggerHandler
 */
@isTest(SeeAllData=false)
private class FAT_CommonTriggerHandlerTest {
  private static FAT_CommonTriggerHandler handler = FAT_CommonTriggerHandler.create(
    FAT_CommonTriggerServiceMock.class
  );

  private static FAT_ITriggerObserver triggerObserver = (FAT_ITriggerObserver) FAT_CommonTriggerServiceMock.class
    .newInstance();

  private static FAT_CommonTriggerHelper helper = FAT_CommonTriggerHelper.getInstance();

  @isTest
  static void invoke() {
    Test.startTest();
    handler.invoke();
    Test.stopTest();

    System.assertEquals(false, FAT_CommonTriggerHandler.firstRun, 'invoke');
  }

  @isTest
  static void invokeIsRecursiveFalse() {
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
