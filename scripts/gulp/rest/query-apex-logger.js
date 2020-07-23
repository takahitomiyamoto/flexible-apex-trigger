/**
 * @name query-apex-logger.js
 * @description queryApexLogger
 */
import { query, readFileSyncUtf8, writeFileSyncUtf8 } from '../common/lib';
import { getEnvironment } from '../common/utils';

export default async function _queryApexLogger() {
  const environment = getEnvironment();

  // login
  const loginResultString = readFileSyncUtf8(environment.logs.loginJwt);
  const loginResult = JSON.parse(loginResultString);

  let _query = [];
  _query.push('SELECT');
  _query.push('Id,');
  _query.push('Name,');
  _query.push('CreatedDate');
  _query.push('FROM');
  _query.push('ApexLogger__c');
  _query.push('WHERE');
  _query.push('Id != null');
  _query.push('ORDER BY');
  _query.push('CreatedDate DESC');
  _query.push('LIMIT');
  _query.push('50000');
  _query = _query.join('+');
  _query = _query.replace(' ', '+');
  _query = encodeURI(_query);

  // queryApexLogger
  const result = await query({
    accessToken: loginResult.accessToken,
    instanceUrl: loginResult.instanceUrl,
    options: {
      asOfVersion: environment.secrets.asOfVersion,
      q: _query
    }
  });

  writeFileSyncUtf8(environment.logs.queryApexLogger, JSON.parse(result));
  console.log(environment.logs.queryApexLogger);
}
