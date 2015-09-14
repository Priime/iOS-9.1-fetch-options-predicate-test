//
//  AlbumViewController.swift
//  Predicate Test
//
//  Created by Andrew Ng on 9/14/15.
//  Copyright © 2015 Priime. All rights reserved.
//

import UIKit
import Photos

private let reuseIdentifier = "AlbumCollectionViewCell"

class AlbumViewController: UICollectionViewController {

  let imageManager = PHCachingImageManager()
  var assetsFetchResults: PHFetchResult?

  override func viewDidLoad() {
    super.viewDidLoad()

    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false

    // Register cell classes
    collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

    // Do any additional setup after loading the view.
    loadAlbum()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  /*
  // MARK: - Navigation

  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
  // Get the new view controller using [segue destinationViewController].
  // Pass the selected object to the new view controller.
  }
  */

  // MARK: UICollectionViewDataSource

  override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
  }


  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of items
    return assetsFetchResults?.count ?? 0
  }

  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! AlbumCollectionViewCell

    // Configure the cell
    guard let assetsFetchResults = assetsFetchResults else { return cell }
    guard let asset = assetsFetchResults.objectAtIndex(indexPath.item) as? PHAsset else { return cell }

    let imageRequestOptions = PHImageRequestOptions()
    imageRequestOptions.version = .Current
    imageRequestOptions.synchronous = false
    imageRequestOptions.networkAccessAllowed = true

    imageManager.requestImageForAsset(asset, targetSize: CGSize(width: 100, height: 100), contentMode: .AspectFill, options: imageRequestOptions) { (image, info) -> Void in
      dispatch_async(dispatch_get_main_queue(), { () -> Void in
        cell.imageView.image = image
      })
    }

    return cell
  }

  // MARK: UICollectionViewDelegate

  /*
  // Uncomment this method to specify if the specified item should be highlighted during tracking
  override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
  return true
  }
  */

  /*
  // Uncomment this method to specify if the specified item should be selected
  override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
  return true
  }
  */

  /*
  // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
  override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
  return false
  }

  override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
  return false
  }

  override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {

  }
  */

  // MARK: - Private methods

  func loadAlbum() {
    let fetchOptions = PHFetchOptions()
    fetchOptions.predicate = NSPredicate(format: "title = %@", "Priime")
    let collections = PHAssetCollection.fetchAssetCollectionsWithType(.Album, subtype: .Any, options: fetchOptions)
    guard let album = collections.firstObject as? PHAssetCollection else { return }

    let options = PHFetchOptions()
    options.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.Image.rawValue)
    assetsFetchResults = PHAsset.fetchAssetsInAssetCollection(album, options: options)
  }
}
