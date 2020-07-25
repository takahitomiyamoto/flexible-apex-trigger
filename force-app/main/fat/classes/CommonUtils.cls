/**
 * @name CommonUtils.cls
 * @description common utilities
 */
public without sharing class CommonUtils {
  // Custom Exception
  public class CustomException extends Exception {
  }

  /**
   * @name createObject
   * @description create sObject
   */
  public static SObject createObject(String typeName) {
    Schema.SObjectType targetType = Schema.getGlobalDescribe().get(typeName);
    if (null == targetType) {
      String message = 'The sObject ' + typeName + ' is NOT FOUND.';
      throw new CustomException(message);
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
