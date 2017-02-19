//
//  CustomCell.swift
//  SwipeToDelete
//
//  Created by Alessandro Musto on 2/19/17.
//  Copyright © 2017 Lmusto. All rights reserved.
//

import UIKit

class CustomCell: UICollectionViewCell {


  var cellLabel: UILabel!
  var pan: UIPanGestureRecognizer!

  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()


  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

    commonInit()

  }

  private func commonInit() {
    self.contentView.backgroundColor = UIColor.gray

    cellLabel = UILabel()
    self.contentView.addSubview(cellLabel)

    cellLabel.translatesAutoresizingMaskIntoConstraints = false
    cellLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
    cellLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
    cellLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
    cellLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true

    pan = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
    pan.isEnabled = true
    self.addGestureRecognizer(pan)


  }

  override func layoutSubviews() {
    super.layoutSubviews()

    if (pan.state == UIGestureRecognizerState.changed) {
     let p: CGPoint = pan.translation(in: self)
      let width = self.contentView.frame.width
      let height = self.contentView.frame.height
      self.contentView.frame = CGRect(x: p.x,y: 0, width: width, height: height);
    }

  }


  func onPan(_ pan: UIPanGestureRecognizer) {

    if pan.state == UIGestureRecognizerState.began {

    } else if pan.state == UIGestureRecognizerState.changed {
      self.setNeedsLayout()
    } else {
      if abs(pan.velocity(in: self).x) > 500 {
        let collectionView: UICollectionView = self.superview as! UICollectionView
        let indexPath: IndexPath = collectionView.indexPathForItem(at: self.center)!

        collectionView.delegate?.collectionView!(collectionView, performAction: #selector(onPan(_:)), forItemAt: indexPath, withSender: nil)

      } else {
        UIView.animate(withDuration: 0.2, animations: {
          self.setNeedsLayout()
          self.layoutIfNeeded()
        })
      }
    }

  }

  
}



