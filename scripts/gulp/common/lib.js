/**
 * @name lib.js
 * @description libraries
 */
import gulp from 'gulp';
import shell from 'gulp-shell';
import path from 'path';
import {
  loginJwt,
  query,
  readFileSyncUtf8,
  writeFileSyncUtf8
} from 'heat-sfdx-common';

const execute = (command) => {
  return gulp.src('.').pipe(
    shell(command, {
      verbose: true,
      ignoreErrors: false
    })
  );
};

export { path, loginJwt, query, readFileSyncUtf8, writeFileSyncUtf8, execute };
