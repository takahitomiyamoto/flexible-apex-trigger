/**
 * @name FAT_CommonUtilsTest.cls
 * @description test class for FAT_CommonUtils
 */
@isTest(SeeAllData=false)
private class FAT_CommonUtilsTest {
  @isTest
  static void createObjectException() {
    Test.startTest();
    List<Boolean> exceptions = new List<Boolean>();
    try {
      SObject obj = FAT_CommonUtils.createObject('Dummy');
    } catch (Exception e) {
      exceptions.add(true);
      System.assertEquals(
        'The sObject Dummy is NOT FOUND.',
        e.getMessage(),
        'createObjectException'
      );
    }
    Test.stopTest();

    for (Boolean b : exceptions) {
      System.assertEquals(true, b, 'createObjectException');
    }
  }
}
