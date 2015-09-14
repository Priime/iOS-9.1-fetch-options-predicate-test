# iOS-9.1-fetch-options-predicate-test
An app to demonstrate a crash with using title in NSPredicate as option with PHAssetCollection.fetchAssetCollectionsWithType() in iOS 9.1

Run this app, grant photos permissions, it will crash with:
> 2015-09-14 13:36:37.495 Predicate Test[579:494452] *** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: 'Unsupported predicate in fetch options: title == "Priime"'

Filed radar://22690748
