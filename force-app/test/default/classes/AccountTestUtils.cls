/**
 * @name AccountTestUtils.cls
 * @description test utilities for Account
 */
@isTest(SeeAllData=false)
public with sharing class AccountTestUtils {
  /**
   * @description create normal accounts
   * @return accounts
   */
  public static List<Account> createNormalAccounts() {
    List<Account> accounts = new List<Account>();

    Account normalAccount0 = new Account();
    normalAccount0.Name = 'Normal Account 0';
    accounts.add(normalAccount0);

    Account normalAccount1 = new Account();
    normalAccount1.Name = null;
    accounts.add(normalAccount1);

    return accounts;
  }

  /**
   * @description create abnormal accounts
   * @return accounts
   */
  public static List<Account> createAbnormalAccounts() {
    List<Account> accounts = new List<Account>();

    Account abnormalAccount0 = new Account();
    abnormalAccount0.Name = 'Abnormal Account 1';
    abnormalAccount0.Fax = '03-1234-5678';
    abnormalAccount0.Phone = '';
    accounts.add(abnormalAccount0);

    return accounts;
  }

  /**
   * @description select accounts
   * @return accounts
   */
  public static List<Account> selectAccounts() {
    return [
      SELECT Id, Name, Fax, Phone
      FROM Account
      ORDER BY Name ASC
      LIMIT 50000
    ];
  }

  /**
   * @description insert accounts
   * @param accounts
   */
  public static void insertAccounts(List<Account> accounts) {
    List<Database.SaveResult> results = Database.insert(accounts, false);
  }

  /**
   * @description update accounts
   * @param accounts
   */
  public static void updateAccounts(List<Account> accounts) {
    List<Database.SaveResult> results = Database.update(accounts, false);
  }

  /**
   * @description delete accounts
   * @param accounts
   */
  public static void deleteAccounts(List<Account> accounts) {
    List<Database.DeleteResult> results = Database.delete(accounts, false);
  }

  /**
   * @description undelete accounts
   * @param accounts
   */
  public static void undeleteAccounts(List<Account> accounts) {
    List<Database.UndeleteResult> results = Database.undelete(accounts, false);
  }
}
