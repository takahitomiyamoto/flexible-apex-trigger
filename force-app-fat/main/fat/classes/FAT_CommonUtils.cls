/**
 * @name FAT_CommonUtils.cls
 * @description common utilities
 */
public without sharing class FAT_CommonUtils {
  /**
   * @description Custom Exception
   */
  public class CustomException extends Exception {
  }

  /**
   * @description get SObjectType
   * @param typeName
   * @return Schema.getGlobalDescribe().get(typeName)
   */
  public static Schema.SObjectType getSObjectType(String typeName) {
    return Schema.getGlobalDescribe().get(typeName);
  }

  /**
   * @description create sObject
   * @param typeName
   * @return targetType.newSObject()
   */
  public static SObject createObject(String typeName) {
    Schema.SObjectType targetType = getSObjectType(typeName);
    if (null == targetType) {
      String message = 'The sObject ' + typeName + ' is NOT FOUND.';
      CustomException e = new CustomException();
      e.setMessage(message);
      throw e;
    }
    return targetType.newSObject();
  }

  /**
   * @description get recordTypeId
   * @param sObjectName
   * @param developerName
   * @return Id
   */
  public static Id getRecordTypeId(String sObjectName, String developerName) {
    return getSObjectType(sObjectName)
      .getDescribe()
      .getRecordTypeInfosByDeveloperName()
      .get(developerName)
      .getRecordTypeId();
  }
}
