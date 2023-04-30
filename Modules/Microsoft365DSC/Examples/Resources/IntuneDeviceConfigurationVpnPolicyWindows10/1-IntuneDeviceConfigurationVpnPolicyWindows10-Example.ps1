<#
This example is used to test new resources and showcase the usage of new resources being worked on.
It is not meant to use as a production baseline.
#>

Configuration Example
{
    param(
        [Parameter(Mandatory = $true)]
        [PSCredential]
        $Credscredential
    )
    Import-DscResource -ModuleName Microsoft365DSC

    node localhost
    {
        IntuneDeviceConfigurationVpnPolicyWindows10 'Example'
        {
            Assignments                                = @(
                MSFT_DeviceManagementConfigurationPolicyAssignments{
                    deviceAndAppManagementAssignmentFilterType = 'none'
                    dataType = '#microsoft.graph.allLicensedUsersAssignmentTarget'
                }
            );
            AuthenticationMethod                       = "usernameAndPassword";
            ConnectionType                             = "ciscoAnyConnect";
            Credential                                 = $Credscredential;
            DisplayName                                = "VPN";
            DnsRules                                   = @(
                MSFT_MicrosoftGraphvpnDnsRule{
                    Servers = @('10.0.1.10')
                    Name = 'NRPT rule'
                    Persistent = $True
                    AutoTrigger = $True
                }
            );
            DnsSuffixes                                = @("mydomain.com");
            EnableAlwaysOn                             = $True;
            EnableConditionalAccess                    = $True;
            EnableDnsRegistration                      = $True;
            EnableSingleSignOnWithAlternateCertificate = $False;
            EnableSplitTunneling                       = $False;
            Ensure                                     = "Present";
            Id                                         = "9f3734d4-eb1e-46dc-b668-2f13bfa572ee";
            ProfileTarget                              = "user";
            ProxyServer                                = MSFT_MicrosoftGraphwindows10VpnProxyServer{
                Port = 8080
                BypassProxyServerForLocalAddress = $True
                AutomaticConfigurationScriptUrl = ''
                Address = '10.0.10.100'
            };
            RememberUserCredentials                    = $True;
            TrafficRules                               = @(
                MSFT_MicrosoftGraphvpnTrafficRule{
                    Name = 'VPN rule'
                    AppType = 'none'
                    LocalAddressRanges = @(
                        MSFT_MicrosoftGraphIPv4Range{
                            UpperAddress = '10.0.2.240'
                            LowerAddress = '10.0.2.0'
                        }
                    )
                    RoutingPolicyType = 'forceTunnel'
                    VpnTrafficDirection = 'outbound'
                }
            );
            TrustedNetworkDomains                      = @();
        }
    }
}
