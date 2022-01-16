/**
 * @name upgrade-dependencies.js
 * @description upgrade dependencies
 */
import { execute } from '../common/lib';

/**
 * @description upgrade Dependencies
 */
export default function _upgradeDependencies() {
  const commands = [];
  commands.push('yarn add --dev --exact');
  commands.push('@babel/cli');
  commands.push('@babel/core');
  commands.push('@babel/preset-env');
  commands.push('@babel/register');
  commands.push('@prettier/plugin-xml');
  commands.push('@salesforce/eslint-config-lwc');
  commands.push('@salesforce/eslint-plugin-aura');
  commands.push('eslint');
  commands.push('gulp');
  commands.push('gulp-babel');
  commands.push('gulp-shell');
  commands.push('heat-sfdx-common');
  commands.push('heat-sfdx-metadata');
  commands.push('prettier');
  commands.push('prettier-plugin-apex');
  commands.push('glob-parent');

  return execute(commands.join(' '));
}
