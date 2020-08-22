/**
 * @name FAT_CommonTriggerHelperTest.cls
 * @description test class for FAT_CommonTriggerHelper
 */
@isTest(SeeAllData=false)
private class FAT_CommonTriggerHelperTest {
  private static FAT_ITriggerObserver triggerObserver = (FAT_ITriggerObserver) FAT_CommonTriggerServiceMock.class
    .newInstance();

  private static FAT_CommonTriggerHelper helper = FAT_CommonTriggerHelper.getInstance();

  @isTest
  static void setTriggerObserverNull() {
    FAT_TriggerObserver__mdt triggerObserver = null;
    FAT_TriggerObserver__mdt triggerObserverApexClass = new FAT_TriggerObserver__mdt();
    triggerObserverApexClass.ApexClass__c = null;

    Test.startTest();
    helper.setTriggerObserver(triggerObserver);
    helper.setTriggerObserver(triggerObserverApexClass);
    Test.stopTest();

    System.assertEquals(null, triggerObserver, 'setTriggerObserverNull');
  }

  @isTest
  static void setTriggerObserverApexClassNull() {
    FAT_TriggerObserver__mdt triggerObserver = new FAT_TriggerObserver__mdt();
    triggerObserver.ApexClass__c = 'FAT_Temp';

    Test.startTest();
    helper.setTriggerObserver(triggerObserver);
    Test.stopTest();

    System.assertEquals(
      'FAT_Temp',
      triggerObserver.ApexClass__c,
      'setTriggerObserverApexClassNull'
    );
  }

  @isTest
  static void addObserverBeforeInsert() {
    TriggerOperation triggerOperation = TriggerOperation.BEFORE_INSERT;

    Test.startTest();
    helper.addObserver(triggerOperation, triggerObserver);
    Test.stopTest();

    System.assertEquals(
      1,
      helper.beforeInserts.size(),
      'addObserverBeforeInsert'
    );
  }

  @isTest
  static void addObserverBeforeUpdate() {
    TriggerOperation triggerOperation = TriggerOperation.BEFORE_UPDATE;

    Test.startTest();
    helper.addObserver(triggerOperation, triggerObserver);
    Test.stopTest();

    System.assertEquals(
      1,
      helper.beforeUpdates.size(),
      'addObserverBeforeUpdate'
    );
  }

  @isTest
  static void addObserverBeforeDelete() {
    TriggerOperation triggerOperation = TriggerOperation.BEFORE_DELETE;

    Test.startTest();
    helper.addObserver(triggerOperation, triggerObserver);
    Test.stopTest();

    System.assertEquals(
      1,
      helper.beforeDeletes.size(),
      'addObserverBeforeDelete'
    );
  }

  @isTest
  static void addObserverAfterInsert() {
    TriggerOperation triggerOperation = TriggerOperation.AFTER_INSERT;

    Test.startTest();
    helper.addObserver(triggerOperation, triggerObserver);
    Test.stopTest();

    System.assertEquals(
      1,
      helper.afterInserts.size(),
      'addObserverAfterInsert'
    );
  }

  @isTest
  static void addObserverAfterUpdate() {
    TriggerOperation triggerOperation = TriggerOperation.AFTER_UPDATE;

    Test.startTest();
    helper.addObserver(triggerOperation, triggerObserver);
    Test.stopTest();

    System.assertEquals(
      1,
      helper.afterUpdates.size(),
      'addObserverAfterUpdate'
    );
  }

  @isTest
  static void addObserverAfterDelete() {
    TriggerOperation triggerOperation = TriggerOperation.AFTER_DELETE;

    Test.startTest();
    helper.addObserver(triggerOperation, triggerObserver);
    Test.stopTest();

    System.assertEquals(
      1,
      helper.afterDeletes.size(),
      'addObserverAfterDelete'
    );
  }

  @isTest
  static void addObserverAfterUndelete() {
    TriggerOperation triggerOperation = TriggerOperation.AFTER_UNDELETE;

    Test.startTest();
    helper.addObserver(triggerOperation, triggerObserver);
    Test.stopTest();

    System.assertEquals(
      1,
      helper.afterUndeletes.size(),
      'addObserverAfterUndelete'
    );
  }

  @isTest
  static void addObserverNull() {
    Test.startTest();
    helper.addObserver(null, null);
    Test.stopTest();

    System.assertNotEquals(null, helper, 'addObserverNull');
  }
}
