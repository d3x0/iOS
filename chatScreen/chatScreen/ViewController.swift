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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    var tempChat: [String] = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten"]
    
    
    
    @IBOutlet weak var viewTop: UIView!
    
    @IBOutlet weak var svChat: UIScrollView!
    @IBOutlet weak var tvChat: UITableView!
    @IBOutlet weak var viewChat: UIView!
    
    @IBOutlet weak var txtChat: UITextField!
    
    
    @IBAction func btnClose(sender: AnyObject) {
        txtChat.resignFirstResponder()
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var theCell: ViewChatCell = tvChat.dequeueReusableCellWithIdentifier("ChatCell") as ViewChatCell
        
        theCell.lblTimeStamp.text = "2015-01-10T11:51:00Z"
        theCell.lblChat.text = tempChat[indexPath.row]
        
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

