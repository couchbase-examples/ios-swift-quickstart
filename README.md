# Hotel Management Quick Start App (Couchbase Lite Swift SDK + Swift UI + Capella)

## Introduction

This iOS sample app demonstrates how to build a simple offline-first SwiftUI application using Couchbase Lite and Capella App Services. The app presents a basic hotel listing interface powered by data from the `travel-sample` dataset, which is hosted in Couchbase Capella and synced locally to the device.

The project serves as a quickstart example for building mobile apps that require embedded database functionality with support for local reads/writes, flexible querying, and real-time synchronization with the cloud.

It covers the essentials of:

- Couchbase Lite database setup and integration on iOS using the Swift SDK  
- Performing basic create, read, update, and delete (CRUD) operations  
- Syncing documents from a remote Capella cluster using App Services and access control  
- Configuring secure app users and channels for collection-based sync  
- Connecting a SwiftUI interface to local database content

This sample is ideal for building apps that must remain usable without a network connection and synchronize data reliably once connectivity is restored.

## Setup and Technology Stack

<img width="700" alt="Screenshot 2025-04-07 at 20 23 39" src="https://github.com/user-attachments/assets/8c040698-1e9b-4507-b2f0-345a32a7725a" />

- Capella / Capella App Services
- Couchbase Lite Swift SDK
- Quick Start iOS Swift App

## Features

- Offline-first data access with Couchbase Lite  
- SwiftUI interface listing hotels from Capella  
- Secure data sync using App Services  
- Syncs with hotel collection from `travel-sample` dataset  
- Basic app user authentication  
- Unit and UI tests with XCTest

## Project Requirements

- Xcode: 15.0+  
- iOS: 16+  
- Framework: SwiftUI  
- Dependency Management: Swift Package Manager (SPM)  
- Testing: XCTest (Unit + UI Tests)  
- Database: Couchbase Lite Swift SDK (3.2.1+)


## Installation Instructions

### Log into your Capella Free-Tier account

A listing of operational clusters should appear. Click on your demo-cluster in the list. This should bring up the Home page for your cluster.

### Create a new App Service

On the Home tab under the **Explore your cluster** section, find the section **Try App Services** and click on the link **Deploy App Services**.

On the App Services page, click the **Create App Service** button. The Create App Services page should appear.

On the Create App Services page:

- Enter a name for your app service (e.g. `demo-app-service`)
- Under the **Linked Cluster** section, select your demo-cluster from the drop-down list
- Click the **Create App Service** button

> It may take between 5 and 25 minutes for the new App Service to be created.

### Create a new App Endpoint

Once the App Service is created and its status is listed as `Healthy`, click on the App Service name you just created.

On the App Endpoints screen, click the **Create App Endpoint** button.

On the Create App Endpoint page:

- Enter a name (e.g. `hotels`) in the **App Endpoint Name** field
- For **Bucket**, select `travel-sample`
- For **Scope**, select `inventory`

Under **Choose collections to link**:

- Enable the `hotel` collection by switching the Link toggle to On

Click the **Create App Endpoint** button. You’ll be redirected to the App Endpoints list.

<img width="1694" alt="Screenshot 2025-04-07 at 20 03 30" src="https://github.com/user-attachments/assets/66e0a312-dc80-44a9-8ef9-ab46866d3f8c" />

### Set up App Endpoint security

Click on the newly created endpoint (e.g. `hotels`) to view the App Endpoint details.

On the **Security** tab:

- If a message appears stating that the App Endpoint is paused, click the **Resume app endpoint** link  
  > This may take a few seconds.

We will use the default access control and data validation scripts.

Click on the **App Users** tab in the left-hand navigation menu.

Click the **Create App User** button.

On the Create App User page:

- Enter a username and password for the new user  
  *(Be sure to save these credentials — you’ll need them for the app configuration)*

Click the **Configure Access Grants** link to expand the section.

Under **Assign Channels**:

- Locate the `hotel` collection under **Linked Collections**
- Enter the Admin Channel name `hotel` and hit the Enter key  
  > It should appear as a chip or tag.
  
![Screenshot 2025-02-27 at 4 13 50 PM](https://github.com/user-attachments/assets/6837854b-d8bc-4735-851d-e000953bedcf)

Click the **Create App User** button.

### Get the App Endpoint URL

Click on the **Connect** tab in the navigation header.

The **Connect** page will appear, showing the Public Connection string.

- Click the **copy icon** next to the URL to copy the App Endpoint URL to your clipboard  
  > You’ll need this in the app configuration file.

### Pull down the code

Use the terminal to clone the GitHub repository:

```bash
git clone https://github.com/DominikBrozioKruko/ios-swift-quickstart
```

### Open the project in Xcode

- Navigate to the `ios-swift-quickstart` folder  
- Double-click the `ios-swift-quickstart.xcodeproj` file  
  > This should launch Xcode with the project loaded

### Configure the app

Inside the Project Navigator in Xcode:

- Locate the `Config.swift` file inside the `ios-swift-quickstart` folder
- Open the file and provide the following configuration values:

  - **Remote Capella endpoint URL** – Paste the URL copied from the Connect page  
  - **Authentication / Username** – Enter the App User username  
  - **Authentication / Password** – Enter the App User password

### ⚠️ Caution

If you do not fill out the configuration file, the app **will not sync** with your Capella cluster or endpoint.

### Run the app

To run the app:

- In Xcode, select the device or simulator you'd like to use  
  *(Top bar → change “Any iOS Device” to a listed simulator)*  
- Click the **Run** button or press `Cmd + R`

You should see the Hotels Management App show up in an emulator with the travel-sample hotels list populated.

![Simulator Screenshot - iPhone 16 Pro - 2025-04-07 at 20 28 36](https://github.com/user-attachments/assets/4e249514-2c3d-4c20-b112-bdbbf4a59378)


### ⚠️ Warning

Before running the app, make sure that **Swift Package Manager** has finished downloading the Couchbase SDK.

- In the Project Navigator, scroll to the **Package Dependencies** section  
- If you see a spinner icon next to the dependency, it’s still loading  
- Wait for it to finish before launching the app

## Learn more

To learn more about Couchbase Lite and the Capacitor plugin, look at the following resources:
- [Couchbase lite on swift](#https://docs.couchbase.com/couchbase-lite/current/swift/quickstart.html)

Join our community of developers 

- [Discord community](https://bit.ly/3NbK5vg): Chat with Couchbase developers and ask questions.
- [Stack Overflow community](https://stackoverflow.com/tags/couchbase/info/): Ask questions.
- [Developer Portal](https://www.couchbase.com/developer): more information including tutorials and learning paths.


