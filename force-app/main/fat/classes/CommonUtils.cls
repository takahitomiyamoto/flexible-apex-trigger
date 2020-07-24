/**
 * @name CommonUtils.cls
 * @description common utilities
 */
public without sharing class CommonUtils {
  // Custom Exception
  private class CreateObjectException extends Exception {
  }

  /**
   * @name createObject
   * @description create sObject
   */
  public static SObject createObject(String typeName) {
    Schema.SObjectType targetType = Schema.getGlobalDescribe().get(typeName);
    if (targetType == null) {
      throw new CreateObjectException(
        'The sObject ' +
        typeName +
        ' is NOT FOUND.'
      );
    }
    return targetType.newSObject();
  }

  /**
   * @name getRecordTypeId
   * @description get recordTypeId
   */
  public static Id getRecordTypeId(String sObjectName, String developerName) {
    return Schema.getGlobalDescribe()
      .get(sObjectName)
      .getDescribe()
      .getRecordTypeInfosByDeveloperName()
      .get(developerName)
      .getRecordTypeId();
  }
}
