//
//  CustomCell.swift
//  SwipeToDelete
//
//  Created by Alessandro Musto on 2/19/17.
//  Copyright © 2017 Lmusto. All rights reserved.
//

import UIKit

class CustomCell: UICollectionViewCell, UIGestureRecognizerDelegate {


  var cellLabel: UILabel!
  var pan: UIPanGestureRecognizer!
  var deleteLabel1: UILabel!
  var deleteLabel2: UILabel!

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
    self.backgroundColor = UIColor.red

    cellLabel = UILabel()
    cellLabel.textColor = UIColor.white
    cellLabel.translatesAutoresizingMaskIntoConstraints = false
    self.contentView.addSubview(cellLabel)

    deleteLabel1 = UILabel()
    deleteLabel1.text = "delete"
    deleteLabel1.textColor = UIColor.white
    self.insertSubview(deleteLabel1, belowSubview: self.contentView)

    deleteLabel2 = UILabel()
    deleteLabel2.text = "delete"
    deleteLabel2.textColor = UIColor.white
    self.insertSubview(deleteLabel2, belowSubview: self.contentView)

    cellLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
    cellLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
    cellLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
    cellLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true

    pan = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
    pan.delegate = self
    
    self.addGestureRecognizer(pan)
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    if (pan.state == UIGestureRecognizerState.changed) {
      let p: CGPoint = pan.translation(in: self)
      let width = self.contentView.frame.width
      let height = self.contentView.frame.height
      self.contentView.frame = CGRect(x: p.x,y: 0, width: width, height: height);
      self.deleteLabel1.frame = CGRect(x: p.x - deleteLabel1.frame.size.width-10, y: 0, width: 100, height: height)
      self.deleteLabel2.frame = CGRect(x: p.x + width + deleteLabel2.frame.size.width, y: 0, width: 100, height: height)
    }

  }

  override func prepareForReuse() {
    self.contentView.frame = self.bounds
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

  func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
  }

  override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    return abs((pan.velocity(in: pan.view)).x) > abs((pan.velocity(in: pan.view)).y)
  }
}



