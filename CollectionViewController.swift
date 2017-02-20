//
//  CollectionViewController.swift
//  SwipeToDelete
//
//  Created by Alessandro Musto on 2/19/17.
//  Copyright © 2017 Lmusto. All rights reserved.
//

import UIKit

private let reuseIdentifier = "customCell"

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var groceryList = ["Apples","Salad","Chicken","Steak","Bread","Milk","Eggs","Butter","OJ","Seltzer","Cheese","Spinach","Coffee","Garlic","Avacados","Tomatoes","Nuts","Syrup"]


    override func viewDidLoad() {
        super.viewDidLoad()
        // The below commented code basically tells the compiler that you do not want to use storyboard.
        // self.collectionView!.register(CustomCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }


  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let itemSize = CGSize(width: collectionView.bounds.width, height: 50)
    return itemSize
  }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
      groceryList.remove(at: indexPath.row)
      collectionView.deleteItems(at: [indexPath])
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groceryList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CustomCell
        cell.cellLabel.text = groceryList[indexPath.row]
        return cell
    }


}
