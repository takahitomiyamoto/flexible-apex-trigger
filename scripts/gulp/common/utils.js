/**
 * @name utils.js
 * @description utilities
 */
import { path } from './lib';

const ENVIRONMENT = '.secrets/environment.json';
const URL_SERVICE_SOAP_METADATA = 'my.salesforce.com/services/Soap/m';

/**
 * @description get environment file
 */
const getEnvironment = () => {
  const environment = require(path.join(
    __dirname,
    path.relative(__dirname, ENVIRONMENT)
  ));

  return environment;
};

export { getEnvironment, URL_SERVICE_SOAP_METADATA };
