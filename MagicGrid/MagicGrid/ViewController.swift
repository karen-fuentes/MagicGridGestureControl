//
//  ViewController.swift
//  MagicGrid
//
//  Created by Karen Fuentes on 4/26/17.
//  Copyright © 2017 Karen Fuentes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
     let numberOfViews = 15
     var cells = [String:UIView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let width = view.frame.width / CGFloat(numberOfViews)
        
        for j in 0...30 {
            for i in 0...numberOfViews {
            let cellView = UIView()
            cellView.backgroundColor = randomColorGenerator()
            cellView.frame = CGRect(x: CGFloat(i) * width, y: CGFloat(j) * width, width: width, height: width)
            cellView.layer.borderWidth = 0.5
            cellView.layer.borderColor = UIColor.black.cgColor
            view.addSubview(cellView)
                
            let key = "\(i)||\(j)"
            cells[key] = cellView
        }
    }
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
}
    
    var selectedCell: UIView?
    
    func handlePan(gesture: UIPanGestureRecognizer){
        let width = view.frame.width / CGFloat(numberOfViews)
        

        let location = gesture.location(in: view)
        let i = Int(location.x/width)
        let j = Int(location.y/width)
        
        let key = "\(i)||\(j)"
        guard let cellView = cells[key] else {return}
        
        if selectedCell != cellView {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { 
                self.selectedCell?.layer.transform = CATransform3DIdentity
            }, completion: nil)
        }
        
        selectedCell = cellView
        
        view.bringSubview(toFront: cellView)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { 
            cellView.layer.transform = CATransform3DMakeScale(3, 3, 3)
        }, completion: nil)
        if gesture.state == .ended {
            UIView.animate(withDuration: 0.5, delay: 0.25, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: { 
                cellView.layer.transform = CATransform3DIdentity
            }, completion: { (_) in
                
            })
        }
    }
    func randomColorGenerator() -> UIColor {
        let red = CGFloat(drand48())
        let blue = CGFloat(drand48())
        let green = CGFloat(drand48())
        return UIColor(red: red, green: blue, blue: green, alpha: 1)
    }

}

