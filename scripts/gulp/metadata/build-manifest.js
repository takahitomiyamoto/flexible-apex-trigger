/**
 * @name build-manifest.js
 */
import {
  buildManifest,
  readFileSyncUtf8,
  writeFileSyncUtf8
} from '../common/lib';
import { URL_SERVICE_SOAP_METADATA, getEnvironment } from '../common/utils';

/**
 * @description build manifest
 */
export default async function _buildManifest() {
  const environment = getEnvironment();
  const instanceUrl = `https://${environment.secrets.myDomain}.${URL_SERVICE_SOAP_METADATA}/${environment.secrets.asOfVersion}`;

  // login
  const loginResultString = readFileSyncUtf8(environment.logs.loginJwt);
  const loginResult = JSON.parse(loginResultString);

  // buildManifest
  const authorization = {
    accessToken: loginResult.accessToken,
    instanceUrl: instanceUrl,
    options: {
      asOfVersion: environment.secrets.asOfVersion,
      wsdl: {
        metadata: environment.assets.wsdl.metadata
      }
    }
  };
  const config = {
    metadataTypesNoFolder: environment.logs.metadataTypesNoFolder,
    metadataTypesInFolder: environment.logs.metadataTypesInFolder,
    metadataTypesFolder: environment.logs.metadataTypesFolder,
    root: environment.logs.root,
    manifest: environment.logs.manifest,
    asOfVersion: environment.secrets.asOfVersion,
    prefix: {
      metadataTypeMembers: environment.logs.prefix.metadataTypeMembers,
      listMetadata: environment.logs.prefix.listMetadata
    }
  };
  const buildManifestResult = await buildManifest(authorization, config);

  // archive
  writeFileSyncUtf8(environment.logs.manifest, buildManifestResult);
  console.log(environment.logs.manifest);
}
