===============================================
Create ACR secret for using Kaniko whith help of  'kanikoacr' file
=========================================
=======================secret=================
The commands below are taken from the Azure Container Registry documentation about authentication7.

First, lets setup some values that are not derived from something.

EMAIL=consultsachin15@example.com
SERVICE_PRINCIPAL_NAME=acr-service-principal
ACR_NAME=acr4borealis


Second, we fetch the basic information about the registry we have. We need this information for the other commands.

ACR_LOGIN_SERVER=$(az acr show --name $ACR_NAME --query loginServer --output tsv)
ACR_REGISTRY_ID=$(az acr show --name $ACR_NAME --query id --output tsv)
echo $ACR_LOGIN_SERVER
echo $ACR_REGISTRY_ID

Now we can create a ServicePrinciple with just the rights we need8. In the case of Kaniko, we need Push and Pull rights, which are both captured in the role acrpush.

SP_PASSWD=$(az ad sp create-for-rbac --name http://$SERVICE_PRINCIPAL_NAME --role acrpush --scopes $ACR_REGISTRY_ID --query password --output tsv)
CLIENT_ID=$(az ad sp show --id http://$SERVICE_PRINCIPAL_NAME --query appId --output tsv)
echo $SP_PASSWD
echo $CLIENT_ID


kubectl create secret docker-registry registry-credentialsacr4 --docker-server ${ACR_LOGIN_SERVER} --docker-username ${CLIENT_ID} --docker-password ${SP_PASSWD} --docker-email ${EMAIL}
