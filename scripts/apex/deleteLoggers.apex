// Use .apex files to store anonymous Apex.
// You can execute anonymous Apex in VS Code by selecting the
//     apex text and running the command:
//     SFDX: Execute Anonymous Apex with Currently Selected Text
// You can also execute the entire file by running the command:
//     SFDX: Execute Anonymous Apex with Editor Contents

List<EAL_Logger__c> oldLoggers = [
  SELECT Id
  FROM EAL_Logger__c
  ORDER BY CreatedDate ASC
  LIMIT 100
];
Database.delete(oldLoggers, false);
