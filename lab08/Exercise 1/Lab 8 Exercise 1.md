# Deployment and Configuration

**This is not a lab like the others** where you set an extra step from the material just discussed. "Lab" 8 is more a "click-along" - we do this one together in classroom, but it is written down here nonetheless for your reference.

## Introduction

SSIS Deployments can be automated in several ways, for example:

* Via Continuous Delivery (CI/CD, for example via Azure DevOps)
* Via PowerShell installation scripts

However, as a developer you often need to just bring your developed packages towards your dev server. This deployment can be done from within Visual Studio.

## Preparation

In order to deploy SSIS projects to your SQL Server, you need an **SSIS Catalog**. Usually, this is provided for by the database administrator, but adding one to your own server is not hard:

1. Open SSMS, connect with **localhost**
2. In the **object explorer**, open the folder **Integration Services Catalogs**. As you will see, this is empty.
3. **Right-click** on **Integration Services Catalogs**. Choose "Create Catalog..."
4. In order to use an SSIS Catalog, you need to enable *CLR integration* on SQL Server. Check the button "CLR integration"
5. All packages will be encrypted using a key stored in SQL Server. However, when SQL Server fails we need to be able to restore the SSIS catalog and recover the data. Therefor, we need to have the **encryption key**. Choose an encryption key and store it in a safe location (or, for the sake of this course: forget it directly ;-)).
6. Click "OK" to create the SSIS catalog

## Deploying packages

1. Open the solution from lab 7 exercise 1 (either your own solution, or the provided solution)
2. Right-click the project name, click **Deploy**
3. When the first page of the wizard displays, click **Next**
4. When prompted for a deployment target, choose **SSIS in SQL Server**
5. Fill in **localhost** as server name, and click **Connect**
6. Click **Browse...** in order to select a location to deploy the project towards
7. As you can see, the *OK* button is greyed out. This is because the SSIS project must be deployed inside a *folder*. Click **New folder...** and create a folder named "Lab 07"
8. Select **OK**, **Next** and **Deploy**

## Viewing and execute deployed packages

1. Open SSMS (SQL Server Management Studio). Connect to your local machine (for example "localhost")
2. Browse to **SSIS Catalogs** -> **SSISDB** -> **MyDeploymentFolder**



https://docs.microsoft.com/en-us/sql/integration-services/packages/deploy-integration-services-ssis-projects-and-packages#to-create-and-use-a-server-environment


