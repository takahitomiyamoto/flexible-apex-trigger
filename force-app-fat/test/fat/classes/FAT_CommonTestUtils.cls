/**
 * @name FAT_CommonTestUtils.cls
 * @description test utilities
 */
@isTest(SeeAllData=false)
public with sharing class FAT_CommonTestUtils {
  /**
   * @description select FAT_CommonTriggerServiceMock
   * @return FAT_TriggerObserver__mdt
   */
  public static FAT_TriggerObserver__mdt selectTriggerServiceMock() {
    return [
      SELECT
        Id,
        DeveloperName,
        SObject__c,
        ApexClass__c,
        Active__c,
        BeforeInsert__c,
        BeforeUpdate__c,
        BeforeDelete__c,
        AfterInsert__c,
        AfterUpdate__c,
        AfterDelete__c,
        AfterUndelete__c
      FROM FAT_TriggerObserver__mdt
      WHERE DeveloperName = 'FAT_CommonTriggerServiceMock'
    ];
  }
}
