/**
 * @name clean-cache.js
 * @description clean cache
 */
import { execute } from '../common/lib';

/**
 * @name _cleanCache
 */
export default function _cleanCache() {
  const commands = [];
  commands.push('rm -rf node_modules/');
  commands.push('&&');
  commands.push('echo y');
  commands.push('|');
  commands.push('rm yarn.lock');
  commands.push('&&');
  commands.push('yarn cache clean');

  return execute(commands.join(' '));
}
