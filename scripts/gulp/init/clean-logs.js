/**
 * @name clean-logs.js
 * @description clean .logs
 */
import { execute } from '../common/lib';

/**
 * @description clean logs
 */
export default function _cleanLogs() {
  const commands = [];
  commands.push('rm -rf .logs/');
  commands.push('&&');
  commands.push('mkdir .logs');

  return execute(commands.join(' '));
}
