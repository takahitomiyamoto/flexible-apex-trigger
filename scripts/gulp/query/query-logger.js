/**
 * @name query-logger.js
 * @description queryLogger
 */
import { query, readFileSyncUtf8, writeFileSyncUtf8 } from '../common/lib';
import { getEnvironment } from '../common/utils';

/**
 * @name _queryLogger
 * @description query Logger__c
 */
export default async function _queryLogger() {
  const environment = getEnvironment();

  // login
  const loginResultString = readFileSyncUtf8(environment.logs.loginJwt);
  const loginResult = JSON.parse(loginResultString);

  const fields = [];
  fields.push('Id');
  fields.push('Name');
  fields.push('LoggingLevel__c');
  fields.push('LogMessage__c');

  const _query = [];
  _query.push('SELECT');
  _query.push(fields.join(','));
  _query.push('FROM');
  _query.push('Logger__c');
  _query.push('WHERE');
  _query.push('Id != null');
  _query.push('ORDER BY');
  _query.push('CreatedDate DESC');
  _query.push('LIMIT');
  _query.push('50000');

  // queryLogger
  const result = await query({
    accessToken: loginResult.accessToken,
    instanceUrl: loginResult.instanceUrl,
    options: {
      asOfVersion: environment.secrets.asOfVersion,
      q: encodeURI(_query.join('+').split(' ').join('+'))
    }
  });

  writeFileSyncUtf8(environment.logs.queryLogger, JSON.parse(result));
  console.log(environment.logs.queryLogger);
}
