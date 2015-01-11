//
//  ViewController.swift
//  chatScreen
//
//  Created by Adrian Nugraha on 1/10/15.
//  Copyright (c) 2015 d3x0 Labs. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        tvChat.delegate = self
        tvChat.dataSource = self
        
        txtChat.delegate = self
        
        doRegisterObserver()
        
        tvChat.estimatedRowHeight = 50
        tvChat.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    var tempChat: [String] = ["one message wouldn't hurt", "two line might hurt a little, but let's see how it works", "three lines is probably a pain in the ass and this cell should have nice height and we do have three lines here", "four", "five", "six", "seven", "eight", "nine", "ten", "Now, I’m not an auto-layout master. I’ve seldom used it before. So it took a bit of trial and error to get the layout set up correctly. The crucial thing was to make sure there were no constraints limiting the height of my labels, since I want them to resize themselves to fit whatever text goes in them."]
    
    
    
    @IBOutlet weak var viewTop: UIView!
    
    @IBOutlet weak var svChat: UIScrollView!
    @IBOutlet weak var tvChat: UITableView!
    @IBOutlet weak var viewChat: UIView!
    
    @IBOutlet weak var txtChat: UITextField!
    
    
    var theCell: ViewChatCell!
    
    
    @IBAction func btnClose(sender: AnyObject) {
        txtChat.resignFirstResponder()
    }

/*

Apple WWDC 2014 told us to use these two methods:
    tvChat.estimatedRowHeight = 50
    tvChat.rowHeight = UITableViewAutomaticDimension
    
instead to these two (commented) functions below:
    
*/
/*
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 50
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if(theCell == nil)
        {
            theCell = tvChat.dequeueReusableCellWithIdentifier("ChatCell") as ViewChatCell
        }
        
        theCell.lblTimeStamp.text = "2015-01-10T11:51:00Z"
        theCell.lblTimeStamp.font = UIFont(name: "Helvetica Neue", size: 12)

        theCell.lblChat.text = tempChat[indexPath.row]
        theCell.lblChat.font = UIFont(name: "Helvetica Neue", size: 17)
        
        theCell.layoutIfNeeded()
        
        var theCellSize: CGSize = theCell.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
        
        println("cell #\(indexPath.row) height = \(theCellSize.height)")
        
        return theCellSize.height + 1
    }
*/

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var theCell: ViewChatCell = tvChat.dequeueReusableCellWithIdentifier("ChatCell") as ViewChatCell
        
        theCell.lblTimeStamp.text = "2015-01-10T11:51:00Z"
        //theCell.lblTimeStamp.font = UIFont(name: "Helvetica Neue", size: 12)
        
        theCell.lblChat.text = tempChat[indexPath.row]
        //theCell.lblChat.font = UIFont(name: "Helvetica Neue", size: 17)
        
        return theCell as UITableViewCell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempChat.count
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {

        if(textField == txtChat)
        {
            tempChat.append(txtChat.text)
            txtChat.text = ""
            
            tvChat.reloadData()
            
            return false
        }
        
        return true
    }
    
    func doRegisterObserver()
    {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func doUnregisterObserver()
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification)
    {
        var keyboardSize: CGFloat = ((notification.userInfo as NSDictionary!).objectForKey(UIKeyboardFrameBeginUserInfoKey)?.CGRectValue() as CGRect!).size.height
        
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            var tvChatContentInsets: UIEdgeInsets = UIEdgeInsetsMake(keyboardSize, 0, 0, 0)
            self.tvChat.contentInset = tvChatContentInsets
            self.tvChat.scrollIndicatorInsets = tvChatContentInsets
            
            var svChatContentOffset: CGPoint = CGPointMake(0, keyboardSize)
            self.svChat.contentOffset = svChatContentOffset
            
            self.view.layoutIfNeeded()
        })
    }
    
    func keyboardWillHide(notification: NSNotification)
    {
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            var tvChatContentInsets: UIEdgeInsets = UIEdgeInsetsZero
            self.tvChat.contentInset = tvChatContentInsets
            self.tvChat.scrollIndicatorInsets = tvChatContentInsets
            
            var svMainContentOffset: CGPoint = CGPointMake(0, 0)
            self.svChat.contentOffset = svMainContentOffset
            
            self.view.layoutIfNeeded()
        })
    }
    

}

