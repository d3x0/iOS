//
//  ViewController.swift
//  exampleCoreData
//
//  Created by Adrian Nugraha on 1/22/15.
//  Copyright (c) 2015 d3x0 Labs. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        doPrepareData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    
    
    func doPrepareData()
    {
        println("preparing data..")
        /*
        doSaveData("adrian")
        doSaveData("will")
        doSaveData("seth")
        doSaveData("nick")
        */
        doViewData()
    }
    
    
    
    
    func doSaveData(name: String)
    {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        
        
        
        let entity = NSEntityDescription.entityForName("Person", inManagedObjectContext: managedContext)
        let person = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        
        
        person.setValue(name, forKey: "name")
        
        var error: NSError?
        
        if(!managedContext.save(&error))
        {
            println("failed to save name=\(name) with error=\(error?.userInfo)")
        }
    }
    
    
    func doViewData()
    {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        
        
        let fetchRequest = NSFetchRequest(entityName: "Person")
        
        
        var error: NSError?
        
        let fetchResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as [NSManagedObject]?
        
        if let results = fetchResults
        {
            for aResult in results
            {
                let aName = aResult.valueForKey("name") as String
                
                println("name=\(aName)")
            }
        }
        else
        {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
        
    }
    
    
}

