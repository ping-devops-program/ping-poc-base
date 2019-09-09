# Creating PingDirectory
Use the `./apply -u fullstack -n <namesapece>` to run the fullstack, of which PingDirectory is a part of.

> Note: You can add the parameter `-n <namespace>` to each of the kubectl commands below to limit work to your namespace.

# 1. Accessing PingDataConsole
  1. Obtain the external hostname (EXTERNAL_IP) for the DataConsole and the PingDirectory.
    
      PingDataConsole 
        ```
        kubectl get service/pingdataconsole-service
        ```
    
      PingDirectory
        ```
        kubectl get service/ds-load-balancer
        ```

  2. Got to that url in your browser with following server and loging credentials
  
     ```
          url: http://<PingDataConsole Hostname>
       server: <PingDirectory Hostname>
     username: administrator
     password: 2FederateM0re
     ```

  # 2. Logging into PingDirectory pods
  This is an example of logging into instance `ds-0`

    kubectl exec -it ds-0 /bin/sh

  # 3. Access PingDirectory from LDAP Client

  Use the following criteria to access from an LDAP Client (i.e. Apache Directry Studio)

        hostname: <PingDirectory Hostname>
            port: 636
         use SSL: Yes
          bindDN: cn=administrator
        passworD: 2FederateM0re

  You can view any objects off the subtreee `o=intuit`
  