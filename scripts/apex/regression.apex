Savepoint sp = Database.setSavepoint();
List<Account> accounts = new List<Account>();
for (Integer i = 0; i < 201; i++) {
  Account account = new Account();
  account.Name = 'demo ' + i;
  account.AccountNumber = 'demo';
  accounts.add(account);
}
insert accounts;

List<Account> newAccounts = [
  SELECT Name
  FROM Account
  WHERE AccountNumber = 'demo' AND account.Name LIKE '[サンプル]demo %'
];

for (Account a : newAccounts) {
  a.AccountNumber = 'demo2';
}
update newAccounts;

System.debug(newAccounts.size());
System.assertEquals(201, newAccounts.size(), '件数が違います！！');
Database.rollback(sp);
