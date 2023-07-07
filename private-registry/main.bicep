//

module storageDeploy 'br/SampleBicepModules:storage:1.0.0' = {
  name: 'sample-storage-deployment'
  params:{
    azureRegion: 'westeurope'
    geoRedundancy: false
    namePrefix: 'dev'
    paramStorageName: 'bicepstorage6785'
  }
}
