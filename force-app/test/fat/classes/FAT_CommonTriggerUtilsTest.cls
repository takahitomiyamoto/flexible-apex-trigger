/**
 * @name FAT_CommonTriggerUtilsTest.cls
 * @description test class for FAT_CommonTriggerUtils
 */
@isTest(SeeAllData=false)
private class FAT_CommonTriggerUtilsTest {
  private static FAT_CommonTriggerUtils utils = FAT_CommonTriggerUtils.getInstance();

  @isTest
  static void fetchTriggerObserver() {
    Test.startTest();
    FAT_ITriggerObserver observer = utils.fetchTriggerObserver(
      FAT_CommonTriggerServiceMock.class
    );
    Test.stopTest();

    System.assertNotEquals(null, observer, 'fetchTriggerObserver');
  }

  @isTest
  static void fetchTriggerObserverNull() {
    Test.startTest();
    FAT_ITriggerObserver observer = utils.fetchTriggerObserver(null);
    Test.stopTest();

    System.assertEquals(null, observer, 'fetchTriggerObserverNull');
  }

  @isTest
  static void fetchActiveOperations() {
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
    List<TriggerOperation> operations = utils.fetchActiveOperations(
      triggerObserver
    );
    Test.stopTest();

    System.assertEquals(
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
    List<TriggerOperation> operations = utils.fetchActiveOperations(
      triggerObserver
    );
    Test.stopTest();

    System.assertEquals(
      new List<TriggerOperation>(),
      operations,
      'addActiveTriggerOperationsInactive'
    );
  }
}
