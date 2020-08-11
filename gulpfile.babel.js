/**
 * @name gulpfile.babel.js
 * @description gulpfile
 */
import { series } from 'gulp';

// auth
import loginJwt from './scripts/gulp/auth/login-jwt';

// init
import upgradeDependencies from './scripts/gulp/init/upgrade-dependencies';
import cleanCache from './scripts/gulp/init/clean-cache';
import cleanLogs from './scripts/gulp/init/clean-logs';

// rest
import queryLogger from './scripts/gulp/query/query-logger';

// metadata
import buildManifest from './scripts/gulp/metadata/build-manifest';

// gulp tasks
exports.init = series(cleanCache, upgradeDependencies, cleanLogs);
exports.queryLogger = series(cleanLogs, loginJwt, queryLogger);
exports.manifestCreate = series(cleanLogs, loginJwt, buildManifest);
