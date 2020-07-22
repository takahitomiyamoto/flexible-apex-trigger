/**
 * @name gulpfile.babel.js
 * @description gulpfile
 */
import { series } from 'gulp';

// init
import upgradeDependencies from './scripts/gulp/init/upgrade-dependencies';
import cleanCache from './scripts/gulp/init/clean-cache';
import cleanLogs from './scripts/gulp/init/clean-logs';

// gulp tasks
exports.init = series(cleanCache, upgradeDependencies, cleanLogs);
