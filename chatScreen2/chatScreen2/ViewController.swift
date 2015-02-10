//
//  ViewController.swift
//  chatScreen2
//
//  Created by Adrian Nugraha on 2/10/15.
//  Copyright (c) 2015 d3x0 Labs. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var tvChat: UITableView!
    @IBOutlet weak var viewBottom: UIView!
    @IBOutlet weak var txtChat: UITextField!
    
    
    var tempChat: [String] = ["one", "two", "three"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        tvChat.dataSource = self
        tvChat.delegate = self
        
        
        txtChat.autocorrectionType = UITextAutocorrectionType.No
        
        
        doRegisterObserver()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
        tvChatCGR = tvChat.frame
        viewBottomCGR = viewBottom.frame
        
        
        var indexPath: NSIndexPath = NSIndexPath(forRow: tempChat.count - 1, inSection: 0)
        tvChat.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var theCell: MyTableViewCell = tvChat.dequeueReusableCellWithIdentifier("DefaultCell", forIndexPath: indexPath) as MyTableViewCell
        
        theCell.lblChat.text = tempChat[indexPath.row]
        
        return theCell as UITableViewCell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tempChat.count
    }
    
    
    
    
    
    
    var notificationCenter: NSNotificationCenter = NSNotificationCenter.defaultCenter()
    
    func doRegisterObserver()
    {
        notificationCenter.addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: "keyboardWillChangeFrame:", name: UIKeyboardWillChangeFrameNotification, object: nil)
    }
    
    func doUnregisterObserver()
    {
        notificationCenter.removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        notificationCenter.removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillChangeFrame(notification: NSNotification)
    {
        var keyboardSize: CGFloat = ((notification.userInfo as NSDictionary!).objectForKey(UIKeyboardFrameBeginUserInfoKey)?.CGRectValue() as CGRect!).size.height
        
        println("keyboardSize=\(keyboardSize)")
    }
    
    
    
    
    var tvChatCGR: CGRect!
    var viewBottomCGR: CGRect!
    
    
    func keyboardWillShow(notification: NSNotification)
    {
        var keyboardSize: CGFloat = ((notification.userInfo as NSDictionary!).objectForKey(UIKeyboardFrameBeginUserInfoKey)?.CGRectValue() as CGRect!).size.height
        
        var tvChatCGRNew: CGRect = CGRectMake(tvChatCGR.origin.x, tvChatCGR.origin.y, tvChatCGR.size.width, tvChatCGR.size.height - keyboardSize)
        var viewBottomCGRNew: CGRect = CGRectMake(viewBottomCGR.origin.x, viewBottomCGR.origin.y - keyboardSize, viewBottomCGR.size.width, viewBottomCGR.size.height)
        
        
        
        println(tvChatCGR)
        println(tvChatCGRNew)
        
        tvChat.setTranslatesAutoresizingMaskIntoConstraints(true)
        viewBottom.setTranslatesAutoresizingMaskIntoConstraints(true)
        
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            
            self.tvChat.frame = tvChatCGRNew
            self.viewBottom.frame = viewBottomCGRNew
        })
        
        var indexPath: NSIndexPath = NSIndexPath(forRow: tempChat.count - 1, inSection: 0)
        tvChat.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
    }
    
    func keyboardWillHide(notification: NSNotification)
    {
        tvChat.setTranslatesAutoresizingMaskIntoConstraints(true)
        viewBottom.setTranslatesAutoresizingMaskIntoConstraints(true)
        
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            
            self.tvChat.frame = self.tvChatCGR
            self.viewBottom.frame = self.viewBottomCGR
        })
        
        var indexPath: NSIndexPath = NSIndexPath(forRow: tempChat.count - 1, inSection: 0)
        tvChat.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
    }
    
    
    
    @IBAction func btnSend(sender: AnyObject) {
        
        txtChat.resignFirstResponder()
        
        if(txtChat.text != "")
        {
            tempChat.append(txtChat.text)
            txtChat.text = ""
            
            tvChat.reloadData()
        }
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

}

