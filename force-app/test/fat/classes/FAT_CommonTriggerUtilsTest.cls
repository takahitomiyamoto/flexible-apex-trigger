/**
 * @name FAT_CommonTriggerUtilsTest.cls
 * @description test class for FAT_CommonTriggerUtils
 */
@isTest(SeeAllData=false)
private class FAT_CommonTriggerUtilsTest {
  @isTest
  static void fetchTriggerObserver() {
    Test.startTest();
    FAT_ITriggerObserver observer = FAT_CommonTriggerUtils.fetchTriggerObserver(
      FAT_CommonTriggerServiceMock.class
    );
    Test.stopTest();

    system.assertNotEquals(null, observer, 'fetchTriggerObserver');
  }

  @isTest
  static void fetchTriggerObserverNull() {
    Test.startTest();
    FAT_ITriggerObserver observer = FAT_CommonTriggerUtils.fetchTriggerObserver(
      null
    );
    Test.stopTest();

    system.assertEquals(null, observer, 'fetchTriggerObserverNull');
  }

  @isTest
  static void addActiveTriggerOperations() {
    FAT_TriggerObserver__mdt triggerObserver = new FAT_TriggerObserver__mdt();
    triggerObserver.Active__c = true;
    triggerObserver.BeforeInsert__c = true;
    triggerObserver.BeforeUpdate__c = true;
    triggerObserver.BeforeDelete__c = true;
    triggerObserver.AfterInsert__c = true;
    triggerObserver.AfterUpdate__c = true;
    triggerObserver.AfterDelete__c = true;
    triggerObserver.AfterUndelete__c = true;

    List<TriggerOperation> allTriggerOperations = new List<TriggerOperation>();
    allTriggerOperations.add(TriggerOperation.BEFORE_INSERT);
    allTriggerOperations.add(TriggerOperation.BEFORE_UPDATE);
    allTriggerOperations.add(TriggerOperation.BEFORE_DELETE);
    allTriggerOperations.add(TriggerOperation.AFTER_INSERT);
    allTriggerOperations.add(TriggerOperation.AFTER_UPDATE);
    allTriggerOperations.add(TriggerOperation.AFTER_DELETE);
    allTriggerOperations.add(TriggerOperation.AFTER_UNDELETE);

    Test.startTest();
    List<TriggerOperation> operations = FAT_CommonTriggerUtils.addActiveTriggerOperations(
      triggerObserver
    );
    Test.stopTest();

    system.assertEquals(
      allTriggerOperations,
      operations,
      'addActiveTriggerOperations'
    );
  }

  @isTest
  static void addActiveTriggerOperationsInactive() {
    FAT_TriggerObserver__mdt triggerObserver = new FAT_TriggerObserver__mdt();
    triggerObserver.Active__c = false;

    Test.startTest();
    List<TriggerOperation> operations = FAT_CommonTriggerUtils.addActiveTriggerOperations(
      triggerObserver
    );
    Test.stopTest();

    system.assertEquals(null, operations, 'addActiveTriggerOperationsInactive');
  }
}
