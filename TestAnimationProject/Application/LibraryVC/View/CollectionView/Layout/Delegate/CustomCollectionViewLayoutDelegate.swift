//
//  CustomCollectionViewLayoutDelegate.swift
//  TestAnimationProject
//
//  Created by Pavel Buzdanov on 04.03.2021.
//

import UIKit

protocol CustomCollectionViewLayoutDelegate: AnyObject {
  
  func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat
  
}
