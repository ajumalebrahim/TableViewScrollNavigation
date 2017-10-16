//
//  ViewController.swift
//  TableViewScrollNavigation
//
//  Created by Ajumal Ebrahim on 10/16/17.
//  Copyright © 2017 Ajumal Ebrahim. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    static let TopMinSpace : CGFloat = 20
    static let TopMaxSpace : CGFloat = 64
    static let ActMaxHeight : CGFloat = 155
    static let ActMinHeight : CGFloat = 100
    
    var previousScrollViewYOffset : CGFloat?
    
    @IBOutlet weak var lcVwTopT: NSLayoutConstraint!
    @IBOutlet weak var lvVwH: NSLayoutConstraint!
    var ee :CGFloat = 64.0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.previousScrollViewYOffset = 0
        self.navigationItem.title = "sdsd"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var frame = self.navigationController?.navigationBar.frame;
        let size = (frame?.size.height)! - 21;
        let framePercentageHidden = ((20 - (frame?.origin.y)!) / ((frame?.size.height)! - 1));
        let scrollOffset = scrollView.contentOffset.y;
        let scrollDiff = scrollOffset - self.previousScrollViewYOffset!;
        let scrollHeight = scrollView.frame.size.height;
        let scrollContentSizeHeight = scrollView.contentSize.height + scrollView.contentInset.bottom;
        var constantT = lcVwTopT.constant;
        var height = lvVwH.constant
        if (scrollOffset <= -scrollView.contentInset.top) {
            frame?.origin.y = 20;
            constantT = ViewController.TopMaxSpace
            height = ViewController.ActMaxHeight
        } else if ((scrollOffset + scrollHeight) >= scrollContentSizeHeight) {
            frame?.origin.y = -size;
            constantT = ViewController.TopMinSpace
            height = ViewController.ActMinHeight
        } else {
            frame?.origin.y = min(20, max(-size, (frame?.origin.y)! - scrollDiff));
            constantT = max(ViewController.TopMinSpace, min(ViewController.TopMaxSpace, constantT - scrollDiff))
            height = max(ViewController.ActMinHeight, min(ViewController.ActMaxHeight, height - scrollDiff))
        }
        lvVwH.constant = height
        lcVwTopT.constant = constantT
        self.navigationController?.navigationBar.frame = frame!
        updateBarButtonItems(alpha: (1 - framePercentageHidden))
        self.previousScrollViewYOffset = scrollOffset;
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        stoppedScrolling()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if (!decelerate) {
            //            stoppedScrolling()
            print("!dece")
        } else {
            print("dece")
        }
        let frame = self.navigationController?.navigationBar.frame;
        let fl : CGFloat = 20.0
        if ((frame?.origin.y)! < fl) {
            
        } else {
            
        }
    }
    
    func stoppedScrolling() {
        let frame = self.navigationController?.navigationBar.frame;
        let fl : CGFloat = 20.0
        if ((frame?.origin.y)! < fl) {
            animateNavBarTo(y: -((frame?.size.height)! - 21))
        }
    }
    
    func updateBarButtonItems(alpha : CGFloat) {
        self.navigationItem.leftBarButtonItems?.forEach { item in
            item.customView?.alpha = alpha
        }
        self.navigationItem.rightBarButtonItems?.forEach { item in
            item.customView?.alpha = alpha
        }
        self.navigationItem.titleView?.alpha = alpha;
        self.navigationController?.navigationBar.tintColor = self.navigationController?.navigationBar.tintColor.withAlphaComponent(alpha);
        
    }
    
    func animateNavBarTo(y : CGFloat) {
        UIView.animate(withDuration: 0.2) {
            var frame = self.navigationController?.navigationBar.frame;
            let alpha = ((frame?.origin.y)! >= y ? 0 : 1);
            frame?.origin.y = y;
            
            self.navigationController?.navigationBar.frame = frame!;
            self.updateBarButtonItems(alpha: CGFloat(alpha));
        }
    }
    
    // MARK: - Table view data source
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 200
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "dsdsd"
        
        // Configure the cell...
        
        return cell
    }
    
}

