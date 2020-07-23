/**
 * @name utils.js
 * @description utilities
 */
import { path } from './lib';

const ENVIRONMENT = '.secrets/environment.json';

/**
 * @name getEnvironment
 */
const getEnvironment = () => {
  const environment = require(path.join(
    __dirname,
    path.relative(__dirname, ENVIRONMENT)
  ));

  return environment;
};

export { getEnvironment };
