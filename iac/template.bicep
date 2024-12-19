param sites_fagarminsync_name string = 'fagarminsync'
param vaults_kv_garminsync_name string = 'kv-garminsync'
param components_fagarminsync_name string = 'fagarminsync'
param storageAccounts_sagarminsync_name string = 'sagarminsync'
param serverfarms_ASP_rggarminsync_ae9f_name string = 'ASP-rggarminsync-ae9f'
param actionGroups_Application_Insights_Smart_Detection_name string = 'Application Insights Smart Detection'
param workspaces_DefaultWorkspace_a7151d11_0f24_45b6_bda9_6a3b6ce06ede_ITN_externalid string = '/subscriptions/a7151d11-0f24-45b6-bda9-6a3b6ce06ede/resourceGroups/DefaultResourceGroup-ITN/providers/Microsoft.OperationalInsights/workspaces/DefaultWorkspace-a7151d11-0f24-45b6-bda9-6a3b6ce06ede-ITN'

resource actionGroups_Application_Insights_Smart_Detection_name_resource 'microsoft.insights/actionGroups@2023-09-01-preview' = {
  name: actionGroups_Application_Insights_Smart_Detection_name
  location: 'Global'
  properties: {
    groupShortName: 'SmartDetect'
    enabled: true
    emailReceivers: []
    smsReceivers: []
    webhookReceivers: []
    eventHubReceivers: []
    itsmReceivers: []
    azureAppPushReceivers: []
    automationRunbookReceivers: []
    voiceReceivers: []
    logicAppReceivers: []
    azureFunctionReceivers: []
    armRoleReceivers: [
      {
        name: 'Monitoring Contributor'
        roleId: '749f88d5-cbae-40b8-bcfc-e573ddc772fa'
        useCommonAlertSchema: true
      }
      {
        name: 'Monitoring Reader'
        roleId: '43d0d8ad-25c7-4714-9337-8ba259a9fe05'
        useCommonAlertSchema: true
      }
    ]
  }
}

resource components_fagarminsync_name_resource 'microsoft.insights/components@2020-02-02' = {
  name: components_fagarminsync_name
  location: 'italynorth'
  kind: 'web'
  properties: {
    Application_Type: 'web'
    Flow_Type: 'Redfield'
    Request_Source: 'IbizaAIExtensionEnablementBlade'
    RetentionInDays: 90
    WorkspaceResourceId: workspaces_DefaultWorkspace_a7151d11_0f24_45b6_bda9_6a3b6ce06ede_ITN_externalid
    IngestionMode: 'LogAnalytics'
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
  }
}

resource vaults_kv_garminsync_name_resource 'Microsoft.KeyVault/vaults@2024-04-01-preview' = {
  name: vaults_kv_garminsync_name
  location: 'italynorth'
  properties: {
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: 'b11058b3-09a2-493f-8d8a-e236fc1eb323'
    networkAcls: {
      bypass: 'None'
      defaultAction: 'Allow'
      ipRules: []
      virtualNetworkRules: []
    }
    accessPolicies: []
    enabledForDeployment: false
    enabledForDiskEncryption: false
    enabledForTemplateDeployment: false
    enableSoftDelete: true
    softDeleteRetentionInDays: 90
    enableRbacAuthorization: true
    vaultUri: 'https://${vaults_kv_garminsync_name}.vault.azure.net/'
    provisioningState: 'Succeeded'
    publicNetworkAccess: 'Enabled'
  }
}

resource storageAccounts_sagarminsync_name_resource 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: storageAccounts_sagarminsync_name
  location: 'italynorth'
  tags: {
    responsible: 'mila'
  }
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  kind: 'StorageV2'
  properties: {
    dnsEndpointType: 'Standard'
    defaultToOAuthAuthentication: false
    publicNetworkAccess: 'Enabled'
    allowCrossTenantReplication: false
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: false
    allowSharedKeyAccess: true
    largeFileSharesState: 'Enabled'
    networkAcls: {
      bypass: 'AzureServices'
      virtualNetworkRules: []
      ipRules: []
      defaultAction: 'Allow'
    }
    supportsHttpsTrafficOnly: true
    encryption: {
      requireInfrastructureEncryption: false
      services: {
        file: {
          keyType: 'Account'
          enabled: true
        }
        blob: {
          keyType: 'Account'
          enabled: true
        }
      }
      keySource: 'Microsoft.Storage'
    }
    accessTier: 'Hot'
  }
}

resource serverfarms_ASP_rggarminsync_ae9f_name_resource 'Microsoft.Web/serverfarms@2023-12-01' = {
  name: serverfarms_ASP_rggarminsync_ae9f_name
  location: 'Italy North'
  tags: {
    responsible: 'mila'
  }
  sku: {
    name: 'Y1'
    tier: 'Dynamic'
    size: 'Y1'
    family: 'Y'
    capacity: 0
  }
  kind: 'functionapp'
  properties: {
    perSiteScaling: false
    elasticScaleEnabled: false
    maximumElasticWorkerCount: 1
    isSpot: false
    reserved: false
    isXenon: false
    hyperV: false
    targetWorkerCount: 0
    targetWorkerSizeId: 0
    zoneRedundant: false
  }
}

resource components_fagarminsync_name_degradationindependencyduration 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_fagarminsync_name_resource
  name: 'degradationindependencyduration'
  location: 'italynorth'
  properties: {
    RuleDefinitions: {
      Name: 'degradationindependencyduration'
      DisplayName: 'Degradation in dependency duration'
      Description: 'Smart Detection rules notify you of performance anomaly issues.'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_fagarminsync_name_degradationinserverresponsetime 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_fagarminsync_name_resource
  name: 'degradationinserverresponsetime'
  location: 'italynorth'
  properties: {
    RuleDefinitions: {
      Name: 'degradationinserverresponsetime'
      DisplayName: 'Degradation in server response time'
      Description: 'Smart Detection rules notify you of performance anomaly issues.'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_fagarminsync_name_digestMailConfiguration 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_fagarminsync_name_resource
  name: 'digestMailConfiguration'
  location: 'italynorth'
  properties: {
    RuleDefinitions: {
      Name: 'digestMailConfiguration'
      DisplayName: 'Digest Mail Configuration'
      Description: 'This rule describes the digest mail preferences'
      HelpUrl: 'www.homail.com'
      IsHidden: true
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_fagarminsync_name_extension_billingdatavolumedailyspikeextension 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_fagarminsync_name_resource
  name: 'extension_billingdatavolumedailyspikeextension'
  location: 'italynorth'
  properties: {
    RuleDefinitions: {
      Name: 'extension_billingdatavolumedailyspikeextension'
      DisplayName: 'Abnormal rise in daily data volume (preview)'
      Description: 'This detection rule automatically analyzes the billing data generated by your application, and can warn you about an unusual increase in your application\'s billing costs'
      HelpUrl: 'https://github.com/Microsoft/ApplicationInsights-Home/tree/master/SmartDetection/billing-data-volume-daily-spike.md'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_fagarminsync_name_extension_canaryextension 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_fagarminsync_name_resource
  name: 'extension_canaryextension'
  location: 'italynorth'
  properties: {
    RuleDefinitions: {
      Name: 'extension_canaryextension'
      DisplayName: 'Canary extension'
      Description: 'Canary extension'
      HelpUrl: 'https://github.com/Microsoft/ApplicationInsights-Home/blob/master/SmartDetection/'
      IsHidden: true
      IsEnabledByDefault: true
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_fagarminsync_name_extension_exceptionchangeextension 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_fagarminsync_name_resource
  name: 'extension_exceptionchangeextension'
  location: 'italynorth'
  properties: {
    RuleDefinitions: {
      Name: 'extension_exceptionchangeextension'
      DisplayName: 'Abnormal rise in exception volume (preview)'
      Description: 'This detection rule automatically analyzes the exceptions thrown in your application, and can warn you about unusual patterns in your exception telemetry.'
      HelpUrl: 'https://github.com/Microsoft/ApplicationInsights-Home/blob/master/SmartDetection/abnormal-rise-in-exception-volume.md'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_fagarminsync_name_extension_memoryleakextension 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_fagarminsync_name_resource
  name: 'extension_memoryleakextension'
  location: 'italynorth'
  properties: {
    RuleDefinitions: {
      Name: 'extension_memoryleakextension'
      DisplayName: 'Potential memory leak detected (preview)'
      Description: 'This detection rule automatically analyzes the memory consumption of each process in your application, and can warn you about potential memory leaks or increased memory consumption.'
      HelpUrl: 'https://github.com/Microsoft/ApplicationInsights-Home/tree/master/SmartDetection/memory-leak.md'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_fagarminsync_name_extension_securityextensionspackage 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_fagarminsync_name_resource
  name: 'extension_securityextensionspackage'
  location: 'italynorth'
  properties: {
    RuleDefinitions: {
      Name: 'extension_securityextensionspackage'
      DisplayName: 'Potential security issue detected (preview)'
      Description: 'This detection rule automatically analyzes the telemetry generated by your application and detects potential security issues.'
      HelpUrl: 'https://github.com/Microsoft/ApplicationInsights-Home/blob/master/SmartDetection/application-security-detection-pack.md'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_fagarminsync_name_extension_traceseveritydetector 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_fagarminsync_name_resource
  name: 'extension_traceseveritydetector'
  location: 'italynorth'
  properties: {
    RuleDefinitions: {
      Name: 'extension_traceseveritydetector'
      DisplayName: 'Degradation in trace severity ratio (preview)'
      Description: 'This detection rule automatically analyzes the trace logs emitted from your application, and can warn you about unusual patterns in the severity of your trace telemetry.'
      HelpUrl: 'https://github.com/Microsoft/ApplicationInsights-Home/blob/master/SmartDetection/degradation-in-trace-severity-ratio.md'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_fagarminsync_name_longdependencyduration 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_fagarminsync_name_resource
  name: 'longdependencyduration'
  location: 'italynorth'
  properties: {
    RuleDefinitions: {
      Name: 'longdependencyduration'
      DisplayName: 'Long dependency duration'
      Description: 'Smart Detection rules notify you of performance anomaly issues.'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_fagarminsync_name_migrationToAlertRulesCompleted 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_fagarminsync_name_resource
  name: 'migrationToAlertRulesCompleted'
  location: 'italynorth'
  properties: {
    RuleDefinitions: {
      Name: 'migrationToAlertRulesCompleted'
      DisplayName: 'Migration To Alert Rules Completed'
      Description: 'A configuration that controls the migration state of Smart Detection to Smart Alerts'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: true
      IsEnabledByDefault: false
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    Enabled: false
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_fagarminsync_name_slowpageloadtime 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_fagarminsync_name_resource
  name: 'slowpageloadtime'
  location: 'italynorth'
  properties: {
    RuleDefinitions: {
      Name: 'slowpageloadtime'
      DisplayName: 'Slow page load time'
      Description: 'Smart Detection rules notify you of performance anomaly issues.'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_fagarminsync_name_slowserverresponsetime 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_fagarminsync_name_resource
  name: 'slowserverresponsetime'
  location: 'italynorth'
  properties: {
    RuleDefinitions: {
      Name: 'slowserverresponsetime'
      DisplayName: 'Slow server response time'
      Description: 'Smart Detection rules notify you of performance anomaly issues.'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource vaults_kv_garminsync_name_garmin_connect_password 'Microsoft.KeyVault/vaults/secrets@2024-04-01-preview' = {
  parent: vaults_kv_garminsync_name_resource
  name: 'garmin-connect-password'
  location: 'italynorth'
  properties: {
    contentType: 'password'
    attributes: {
      enabled: true
    }
  }
}

resource vaults_kv_garminsync_name_garmin_connect_user 'Microsoft.KeyVault/vaults/secrets@2024-04-01-preview' = {
  parent: vaults_kv_garminsync_name_resource
  name: 'garmin-connect-user'
  location: 'italynorth'
  properties: {
    contentType: 'email'
    attributes: {
      enabled: true
    }
  }
}

resource vaults_kv_garminsync_name_sa_garminsync_shared_key 'Microsoft.KeyVault/vaults/secrets@2024-04-01-preview' = {
  parent: vaults_kv_garminsync_name_resource
  name: 'sa-garminsync-shared-key'
  location: 'italynorth'
  properties: {
    contentType: 'shared key'
    attributes: {
      enabled: true
    }
  }
}

resource storageAccounts_sagarminsync_name_default 'Microsoft.Storage/storageAccounts/blobServices@2023-05-01' = {
  parent: storageAccounts_sagarminsync_name_resource
  name: 'default'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  properties: {
    containerDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
    cors: {
      corsRules: []
    }
    deleteRetentionPolicy: {
      allowPermanentDelete: false
      enabled: true
      days: 7
    }
  }
}

resource Microsoft_Storage_storageAccounts_fileServices_storageAccounts_sagarminsync_name_default 'Microsoft.Storage/storageAccounts/fileServices@2023-05-01' = {
  parent: storageAccounts_sagarminsync_name_resource
  name: 'default'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  properties: {
    protocolSettings: {
      smb: {}
    }
    cors: {
      corsRules: []
    }
    shareDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
  }
}

resource Microsoft_Storage_storageAccounts_queueServices_storageAccounts_sagarminsync_name_default 'Microsoft.Storage/storageAccounts/queueServices@2023-05-01' = {
  parent: storageAccounts_sagarminsync_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource Microsoft_Storage_storageAccounts_tableServices_storageAccounts_sagarminsync_name_default 'Microsoft.Storage/storageAccounts/tableServices@2023-05-01' = {
  parent: storageAccounts_sagarminsync_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource sites_fagarminsync_name_resource 'Microsoft.Web/sites@2023-12-01' = {
  name: sites_fagarminsync_name
  location: 'Italy North'
  tags: {
    responsible: 'mila'
    'hidden-link: /app-insights-resource-id': '/subscriptions/a7151d11-0f24-45b6-bda9-6a3b6ce06ede/resourceGroups/rg-garmin-sync/providers/microsoft.insights/components/fagarminsync'
    'hidden-link: /app-insights-instrumentation-key': '89f5ebbf-8a47-494b-b142-bac85a8dec34'
    'hidden-link: /app-insights-conn-string': 'InstrumentationKey=89f5ebbf-8a47-494b-b142-bac85a8dec34;IngestionEndpoint=https://italynorth-0.in.applicationinsights.azure.com/;LiveEndpoint=https://italynorth.livediagnostics.monitor.azure.com/;ApplicationId=f99ac1d6-a77f-4251-a50c-cc5c30c647bb'
  }
  kind: 'functionapp'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    enabled: true
    hostNameSslStates: [
      {
        name: '${sites_fagarminsync_name}.azurewebsites.net'
        sslState: 'Disabled'
        hostType: 'Standard'
      }
      {
        name: '${sites_fagarminsync_name}.scm.azurewebsites.net'
        sslState: 'Disabled'
        hostType: 'Repository'
      }
    ]
    serverFarmId: serverfarms_ASP_rggarminsync_ae9f_name_resource.id
    reserved: false
    isXenon: false
    hyperV: false
    dnsConfiguration: {}
    vnetRouteAllEnabled: false
    vnetImagePullEnabled: false
    vnetContentShareEnabled: false
    siteConfig: {
      numberOfWorkers: 1
      acrUseManagedIdentityCreds: false
      alwaysOn: false
      http20Enabled: false
      functionAppScaleLimit: 200
      minimumElasticInstanceCount: 1
    }
    scmSiteAlsoStopped: false
    clientAffinityEnabled: false
    clientCertEnabled: false
    clientCertMode: 'Required'
    hostNamesDisabled: false
    vnetBackupRestoreEnabled: false
    customDomainVerificationId: 'F1467B26BD3BFC1B4E5818DED99A757D8743A1E6ACBB5948798192A2337D52A1'
    containerSize: 1536
    dailyMemoryTimeQuota: 0
    httpsOnly: true
    redundancyMode: 'None'
    publicNetworkAccess: 'Enabled'
    storageAccountRequired: false
    keyVaultReferenceIdentity: 'SystemAssigned'
  }
}

resource sites_fagarminsync_name_ftp 'Microsoft.Web/sites/basicPublishingCredentialsPolicies@2023-12-01' = {
  parent: sites_fagarminsync_name_resource
  name: 'ftp'
  location: 'Italy North'
  tags: {
    responsible: 'mila'
    'hidden-link: /app-insights-resource-id': '/subscriptions/a7151d11-0f24-45b6-bda9-6a3b6ce06ede/resourceGroups/rg-garmin-sync/providers/microsoft.insights/components/fagarminsync'
    'hidden-link: /app-insights-instrumentation-key': '89f5ebbf-8a47-494b-b142-bac85a8dec34'
    'hidden-link: /app-insights-conn-string': 'InstrumentationKey=89f5ebbf-8a47-494b-b142-bac85a8dec34;IngestionEndpoint=https://italynorth-0.in.applicationinsights.azure.com/;LiveEndpoint=https://italynorth.livediagnostics.monitor.azure.com/;ApplicationId=f99ac1d6-a77f-4251-a50c-cc5c30c647bb'
  }
  properties: {
    allow: false
  }
}

resource sites_fagarminsync_name_scm 'Microsoft.Web/sites/basicPublishingCredentialsPolicies@2023-12-01' = {
  parent: sites_fagarminsync_name_resource
  name: 'scm'
  location: 'Italy North'
  tags: {
    responsible: 'mila'
    'hidden-link: /app-insights-resource-id': '/subscriptions/a7151d11-0f24-45b6-bda9-6a3b6ce06ede/resourceGroups/rg-garmin-sync/providers/microsoft.insights/components/fagarminsync'
    'hidden-link: /app-insights-instrumentation-key': '89f5ebbf-8a47-494b-b142-bac85a8dec34'
    'hidden-link: /app-insights-conn-string': 'InstrumentationKey=89f5ebbf-8a47-494b-b142-bac85a8dec34;IngestionEndpoint=https://italynorth-0.in.applicationinsights.azure.com/;LiveEndpoint=https://italynorth.livediagnostics.monitor.azure.com/;ApplicationId=f99ac1d6-a77f-4251-a50c-cc5c30c647bb'
  }
  properties: {
    allow: false
  }
}

resource sites_fagarminsync_name_web 'Microsoft.Web/sites/config@2023-12-01' = {
  parent: sites_fagarminsync_name_resource
  name: 'web'
  location: 'Italy North'
  tags: {
    responsible: 'mila'
    'hidden-link: /app-insights-resource-id': '/subscriptions/a7151d11-0f24-45b6-bda9-6a3b6ce06ede/resourceGroups/rg-garmin-sync/providers/microsoft.insights/components/fagarminsync'
    'hidden-link: /app-insights-instrumentation-key': '89f5ebbf-8a47-494b-b142-bac85a8dec34'
    'hidden-link: /app-insights-conn-string': 'InstrumentationKey=89f5ebbf-8a47-494b-b142-bac85a8dec34;IngestionEndpoint=https://italynorth-0.in.applicationinsights.azure.com/;LiveEndpoint=https://italynorth.livediagnostics.monitor.azure.com/;ApplicationId=f99ac1d6-a77f-4251-a50c-cc5c30c647bb'
  }
  properties: {
    numberOfWorkers: 1
    defaultDocuments: [
      'Default.htm'
      'Default.html'
      'Default.asp'
      'index.htm'
      'index.html'
      'iisstart.htm'
      'default.aspx'
      'index.php'
    ]
    netFrameworkVersion: 'v9.0'
    requestTracingEnabled: false
    remoteDebuggingEnabled: false
    remoteDebuggingVersion: 'VS2022'
    httpLoggingEnabled: false
    acrUseManagedIdentityCreds: false
    logsDirectorySizeLimit: 35
    detailedErrorLoggingEnabled: false
    publishingUsername: 'REDACTED'
    scmType: 'None'
    use32BitWorkerProcess: false
    webSocketsEnabled: false
    alwaysOn: false
    managedPipelineMode: 'Integrated'
    virtualApplications: [
      {
        virtualPath: '/'
        physicalPath: 'site\\wwwroot'
        preloadEnabled: false
      }
    ]
    loadBalancing: 'LeastRequests'
    experiments: {
      rampUpRules: []
    }
    autoHealEnabled: false
    vnetRouteAllEnabled: false
    vnetPrivatePortsCount: 0
    publicNetworkAccess: 'Enabled'
    cors: {
      allowedOrigins: [
        'https://portal.azure.com'
      ]
      supportCredentials: false
    }
    localMySqlEnabled: false
    managedServiceIdentityId: 3524
    ipSecurityRestrictions: [
      {
        ipAddress: 'Any'
        action: 'Allow'
        priority: 2147483647
        name: 'Allow all'
        description: 'Allow all access'
      }
    ]
    scmIpSecurityRestrictions: [
      {
        ipAddress: 'Any'
        action: 'Allow'
        priority: 2147483647
        name: 'Allow all'
        description: 'Allow all access'
      }
    ]
    scmIpSecurityRestrictionsUseMain: false
    http20Enabled: false
    minTlsVersion: '1.2'
    scmMinTlsVersion: '1.2'
    ftpsState: 'FtpsOnly'
    preWarmedInstanceCount: 0
    functionAppScaleLimit: 200
    functionsRuntimeScaleMonitoringEnabled: false
    minimumElasticInstanceCount: 1
    azureStorageAccounts: {}
  }
}

resource sites_fagarminsync_name_ea896eb0bbf746e5a0e11b82015f3af8 'Microsoft.Web/sites/deployments@2023-12-01' = {
  parent: sites_fagarminsync_name_resource
  name: 'ea896eb0bbf746e5a0e11b82015f3af8'
  location: 'Italy North'
  properties: {
    status: 4
    author_email: 'N/A'
    author: 'N/A'
    deployer: 'ZipDeploy'
    message: 'Created via a push deployment'
    start_time: '2024-12-11T21:55:49.3154207Z'
    end_time: '2024-12-11T21:55:55.0534191Z'
    active: true
  }
}

resource sites_fagarminsync_name_DownloadStepsData 'Microsoft.Web/sites/functions@2023-12-01' = {
  parent: sites_fagarminsync_name_resource
  name: 'DownloadStepsData'
  location: 'Italy North'
  properties: {
    script_root_path_href: 'https://fagarminsync.azurewebsites.net/admin/vfs/site/wwwroot/DownloadStepsData/'
    script_href: 'https://fagarminsync.azurewebsites.net/admin/vfs/site/wwwroot/GarminSync.API.dll'
    config_href: 'https://fagarminsync.azurewebsites.net/admin/vfs/site/wwwroot/DownloadStepsData/function.json'
    test_data_href: 'https://fagarminsync.azurewebsites.net/admin/vfs/data/Functions/sampledata/DownloadStepsData.dat'
    href: 'https://fagarminsync.azurewebsites.net/admin/functions/DownloadStepsData'
    config: {
      name: 'DownloadStepsData'
      entryPoint: 'GarminSync.API.DownloadStepsData.Run'
      scriptFile: 'GarminSync.API.dll'
      language: 'DOTNET-ISOLATED'
      functionDirectory: ''
      bindings: [
        {
          name: 'myTimer'
          type: 'timerTrigger'
          direction: 'In'
          schedule: '0 0 */1 * * *'
          runOnStartup: true
        }
      ]
    }
    test_data: '{"body":"","headers":[],"method":"post","queryStringParams":[]}'
    language: 'DOTNET-ISOLATED'
    isDisabled: false
  }
}

resource sites_fagarminsync_name_sites_fagarminsync_name_azurewebsites_net 'Microsoft.Web/sites/hostNameBindings@2023-12-01' = {
  parent: sites_fagarminsync_name_resource
  name: '${sites_fagarminsync_name}.azurewebsites.net'
  location: 'Italy North'
  properties: {
    siteName: 'fagarminsync'
    hostNameType: 'Verified'
  }
}

resource storageAccounts_sagarminsync_name_default_azure_webjobs_hosts 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-05-01' = {
  parent: storageAccounts_sagarminsync_name_default
  name: 'azure-webjobs-hosts'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_sagarminsync_name_resource
  ]
}

resource storageAccounts_sagarminsync_name_default_azure_webjobs_secrets 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-05-01' = {
  parent: storageAccounts_sagarminsync_name_default
  name: 'azure-webjobs-secrets'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_sagarminsync_name_resource
  ]
}

resource storageAccounts_sagarminsync_name_default_fagarminsync9c91 'Microsoft.Storage/storageAccounts/fileServices/shares@2023-05-01' = {
  parent: Microsoft_Storage_storageAccounts_fileServices_storageAccounts_sagarminsync_name_default
  name: 'fagarminsync9c91'
  properties: {
    accessTier: 'TransactionOptimized'
    shareQuota: 102400
    enabledProtocols: 'SMB'
  }
  dependsOn: [
    storageAccounts_sagarminsync_name_resource
  ]
}

resource storageAccounts_sagarminsync_name_default_AzureFunctionsDiagnosticEvents202412 'Microsoft.Storage/storageAccounts/tableServices/tables@2023-05-01' = {
  parent: Microsoft_Storage_storageAccounts_tableServices_storageAccounts_sagarminsync_name_default
  name: 'AzureFunctionsDiagnosticEvents202412'
  properties: {}
  dependsOn: [
    storageAccounts_sagarminsync_name_resource
  ]
}

resource storageAccounts_sagarminsync_name_default_usersteps 'Microsoft.Storage/storageAccounts/tableServices/tables@2023-05-01' = {
  parent: Microsoft_Storage_storageAccounts_tableServices_storageAccounts_sagarminsync_name_default
  name: 'usersteps'
  properties: {}
  dependsOn: [
    storageAccounts_sagarminsync_name_resource
  ]
}
