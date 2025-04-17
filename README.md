# Hotel Management Quick Start App using Couchbase Lite Swift SDK + Swift UI + Capella App Services

## Introduction
[Couchbase Mobile](https://docs.couchbase.com/home/mobile.html) brings the power of NoSQL to the edge with offline-first data sync. It is comprised of three components:

- [Couchbase Lite](https://docs.couchbase.com/home/mobile.html), local-first,  embedded, NoSQL JSON Document database for your mobile, desktop and embedded apps
- Sync Gateway, an internet-facing component mechanism that securely syncs data between Couchbase Lite clients and Couchbase server, and
- Couchbase Server, a highly scalable, distributed NoSQL database platform backing data store

Couchbase Server and Sync Gateway can be deployed in a self-managed configuration or developers can leverage **Capella**, Couchbase's fully managed Couchbase Server offering. This tutorial uses Capella App Services as backend data store and sync for Couchbase Lite App. Conveniently, Capella offers a [**free tier**](https://docs.couchbase.com/cloud/get-started/intro.html) which allows developers to get started for free to be able to explore the core features of Couchbase.

## App Overview
This iOS sample app demonstrates how to build a simple offline-first SwiftUI application using Couchbase Lite and Capella App Services, fully managed version of Sync gateway and Couchbase Server. The app presents a basic hotel listing interface powered by data from the `travel-sample` dataset, which is hosted in Couchbase Capella and synced locally to the device.

The project serves as a quickstart to developers building mobile apps that require embedded database functionality with support for local reads/writes, flexible querying, and real-time synchronization with the cloud.

It covers the essentials of:

- Basics of App Services and configuring it for remote sync 
- Couchbase Lite database setup and integration on iOS using the Swift SDK  
- Performing basic create, read, update, and delete (CRUD) operations
- Basic Query anf Full Text Search (FTS)
- Syncing documents from a remote Capella cluster using App Services
- Connecting a SwiftUI interface to local database content

This sample is ideal example of how developers can build apps that must remain usable without a network connection and synchronize data reliably once connectivity is restored.

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
- Database: Couchbase Lite Swift SDK (3.2.1)


## Installation Instructions

### Capella Cluster Setup

Sign up for Capella Free Tier and follow the steps to deploy a free tier cluster.

When you create a free tier cluster, it will automatically import a **travel-sample** bucket with datasets that we will use in this app.  If you deleted the travel-sample bucket, you can reimport it from Data Tools-> Import tab.
<< TODO: INSERT IMAGE>>

### Create a new App Service

Follow [instructions](https://docs.couchbase.com/cloud/get-started/create-account.html#app-services) to create a free tier App Services that links to the free tier cluster created in previous step

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

We will use the default access control and data validation function, so no changes required there. By default, all documents in a collection are assigned to a channel with name associated with that collection. You can view the default function by navigating to the **Access Control & Data Validation** tab. 

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

- Navigate to the `ios-swift-quickstart` folder where the repo was closed 
- Open the `ios-swift-quickstart.xcodeproj` file  
  > This should launch Xcode with the project loaded

### Configure the app

Inside the Project Navigator in Xcode:

- Locate the `Config.swift` file inside the `ios-swift-quickstart` folder
- Open the file and provide the following configuration values:

  - **Remote Capella endpoint URL** – Paste the "Public URL" from the Connect page of App Services (discussed earlier)
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

<img src="https://github.com/user-attachments/assets/4e249514-2c3d-4c20-b112-bdbbf4a59378" alt="Simulator Screenshot - iPhone 16 Pro" height="650"/>

### ⚠️ Warning

Before running the app, make sure that **Swift Package Manager** has finished downloading the Couchbase SDK.

- In the Project Navigator, scroll to the **Package Dependencies** section  
- If you see a spinner icon next to the dependency, it’s still loading  
- Wait for it to finish before launching the app

### Try it Out

After running the app successfully, explore the following key features. Each feature below is supported by code inside the `DatabaseManager.swift` class and demonstrates how Couchbase Lite powers this offline-first experience.

#### Database and Replication Operations

**Description**:  
On launch, the app initializes a local Couchbase Lite database and sets up continuous replication with Capella App Services. The `hotel` collection from the `inventory` scope is synced down from the remote cluster.

```swift
database = try Database(name: "travel-sample")
collection = try database?.createCollection(name: "hotel", scope: "inventory")

...

let targetEndpoint = URLEndpoint(url: configuration.capellaEndpointURL)
var replConfig = ReplicatorConfiguration(target: targetEndpoint)
replConfig.continuous = true
replConfig.authenticator = BasicAuthenticator(username: configuration.username, password: configuration.password)
replConfig.addCollection(collection)
replicator = Replicator(config: replConfig)
replicator?.start()
```

Learn more:  
- [Database Initialization](https://docs.couchbase.com/couchbase-lite/current/swift/database.html#open-db)  
- [Replication](https://docs.couchbase.com/couchbase-lite/current/swift/replication.html)

#### Document CRUD Operations

**Description**:  
You can add, update, and delete hotel documents from the local database using simple methods.

**Add a hotel document:**
```swift
let doc = MutableDocument()
let encodedHotel = try JSONEncoder().encode(hotel)
let jsonString = String(data: encodedHotel, encoding: .utf8)!
try doc.setJSON(jsonString)
try collection.save(document: doc)
```

**Update a hotel document:**
```swift
let query = try database?.createQuery("SELECT META().id FROM inventory.hotel WHERE type = 'hotel' AND id = \(hotel.id)")
let results = try query?.execute()
for result in results {
    let docid = result.toDictionary()["id"] as? String
    let doc = try collection.document(id: docid!)
    let mutableDoc = doc?.toMutable()
    let jsonString = String(data: try JSONEncoder().encode(hotel), encoding: .utf8)!
    try mutableDoc?.setJSON(jsonString)
    try collection.save(document: mutableDoc!)
}
```

**Delete a hotel document:**
```swift
let query = try database?.createQuery("SELECT META().id FROM inventory.hotel WHERE type = 'hotel' AND id = \(hotel.id)")
let results = try query?.execute()
for result in results {
    let docid = result.toDictionary()["id"] as? String
    let doc = try collection.document(id: docid!)
    try collection.delete(document: doc!)
}
```

Learn more: [Working with Documents](https://docs.couchbase.com/couchbase-lite/current/swift/document.html)

#### Query & Live Query Updates

**Description**:  
The app performs flexible queries using SQL-like syntax (N1QL). A live query listener updates the UI whenever matching data changes in real time.

```swift
let query = try database?.createQuery("SELECT * FROM inventory.hotel WHERE type = 'hotel' ORDER BY name ASC")
lastQueryToken = query?.addChangeListener { change in
    guard let results = change.results else { return }
    var hotels: [Hotel] = []
    for result in results {
        let hotelDoc = try? JSONDecoder().decode(hotelDocumentModel.self, from: Data(result.toJSON().utf8))
        if let hotel = hotelDoc?.hotel {
            hotels.append(hotel)
        }
    }
    self.queryUpdatesSubject.send(hotels)
}
```

Learn more:  
- [SQL++ Queries](https://docs.couchbase.com/couchbase-lite/current/swift/query-n1ql-mobile.html)  
- [Live Queries](https://docs.couchbase.com/couchbase-lite/current/swift/query-live.html)

---

#### Full-Text Search

**Description**:  
You can search hotel names using Couchbase Lite’s built-in Full Text Search (FTS). This is enabled via an index created on the `name` field.

**Index creation:**
```swift
let indexConfig = FullTextIndexConfiguration(["name"], language: "en")
try collection?.createIndex(withName: "hotelNameIndex", config: indexConfig)
```

**Search query:**
```swift
let query = try database?.createQuery("SELECT * FROM inventory.hotel WHERE MATCH(hotelNameIndex, '\(textSearch!)') AND type = 'hotel'")
```

Learn more: [Full Text Search](https://docs.couchbase.com/couchbase-lite/current/swift/fts.html)

#### Offline-First Sync

**Description**:  
Even if you disconnect from the network or Capella App Services go offline, the app continues working with the local database. Any local changes will sync automatically when the connection is restored.

**Try this:**

1. Disable your network or pause the Capella App Endpoint.
2. Add, edit, or delete a hotel in the app.
3. Reconnect to the network and watch the changes sync automatically.
4. Or — try modifying a document in the Capella UI and see it show up in the app.

Learn more: [Offline-First Architecture](https://www.couchbase.com/blog/couchbase-offline-first-app-use-cases/)


## Learn more

To learn more about Couchbase Lite and the Capacitor plugin, look at the following resources:
- [Couchbase lite on swift](#https://docs.couchbase.com/couchbase-lite/current/swift/quickstart.html)
- [App Services](https://docs.couchbase.com/cloud/app-services/index.html)
- [App Services Access Control Concepts- Channels](https://docs.couchbase.com/cloud/app-services/channels/channels.html)
- [App Services Access Control Concepts- Access Control & Data Validation](https://docs.couchbase.com/cloud/app-services/deployment/access-control-data-validation.html)

## Getting Help
You can reach out to use on the Github repo or join our community of developers 

- [Discord community](https://bit.ly/3NbK5vg): Chat with Couchbase developers and ask questions.
- [Stack Overflow community](https://stackoverflow.com/tags/couchbase/info/): Ask questions.
- [Developer Portal](https://www.couchbase.com/developer): more information including tutorials and learning paths.


