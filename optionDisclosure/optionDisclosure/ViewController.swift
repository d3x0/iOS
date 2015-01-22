//
//  ViewController.swift
//  optionDisclosure
//
//  Created by Adrian Nugraha on 1/15/15.
//  Copyright (c) 2015 d3x0 Labs. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIActionSheetDelegate {

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        txtCountry.delegate = self
        
        
        
        var errorData: NSError?
        
        var pathData: String = NSBundle.mainBundle().pathForResource("country_list", ofType: "json")!
        var jsonData: NSData = NSData(contentsOfFile: pathData, options: NSDataReadingOptions.DataReadingMappedIfSafe, error: &errorData)!
        
        if(errorData != nil)
        {
            println("errorData=\(errorData?.localizedDescription)")
        }
        else
        {
            var jsonError: NSError?
            var jsonAO: AnyObject = NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.AllowFragments, error: &jsonError)!
            
            if(jsonError != nil)
            {
                println("jsonError=\(jsonError?.localizedDescription)")
            }
            else
            {
                if let jsonDict = jsonAO as? NSDictionary
                {
                    println("JSON is now NSDictionary")
                }
                else if let jsonArr = jsonAO as? NSArray
                {
                    println("JSON is now NSArray")
                    
                    arrCountry = jsonArr
                    
                    for arrElement in jsonArr
                    {
                        println(arrElement["geoName"])
                    }
                }
                else
                {
                    println("Can't convert to neither NSDictionary or NSArray")
                }
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    var arrCountry: NSArray!
    
    
    
    @IBOutlet weak var txtCountry: UITextField!
    
    
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        if(textField == txtCountry)
        {
            txtCountry.resignFirstResponder()
            
            var asCountry: UIActionSheet = UIActionSheet(title: "Select country", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil)
            
            for theCountry in arrCountry
            {
                asCountry.addButtonWithTitle(theCountry["geoName"] as NSString)
            }
            
            asCountry.showInView(self.view)
        }
    }
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        print("click \(buttonIndex)")
        
        if(buttonIndex == 0)
        {
            println(" --> Cancel")
        }
        else
        {
            var arrCountryIndex: Int = buttonIndex - 1
            
            println(arrCountry[arrCountryIndex]["geoName"])
        }
    }

}

