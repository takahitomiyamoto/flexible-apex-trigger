/**
 * @name CommonUtils.cls
 * @description common utilities
 */
public without sharing class CommonUtils {
  // Custom Exception
  public class CustomException extends Exception {
  }

  /**
   * @name getSObjectType
   * @description get SObjectType
   */
  public static Schema.SObjectType getSObjectType(String typeName) {
    return Schema.getGlobalDescribe().get(typeName);
  }

  /**
   * @name createObject
   * @description create sObject
   */
  public static SObject createObject(String typeName) {
    Schema.SObjectType targetType = getSObjectType(typeName);
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
    return getSObjectType(sObjectName)
      .getDescribe()
      .getRecordTypeInfosByDeveloperName()
      .get(developerName)
      .getRecordTypeId();
  }
}
