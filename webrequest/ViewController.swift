//
//  ViewController.swift
//  webrequest
//
//  Created by Mengying Feng on 12/02/2016.
//  Copyright © 2016 Mengying Feng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let urlString = "http://swapi.co/api/people/1/"
        let session = NSURLSession.sharedSession()
        
        let url = NSURL(string: urlString)!
        
        // a get request
        // gives us data, response, error
        session.dataTaskWithURL(url) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            if let responseData = data {
                // convert data to JSON
                // it might fail
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(responseData, options: .AllowFragments)
                    
                    // covert json to a dictionary
                    // might not work, use as?
                    if let dict = json as? Dictionary<String, AnyObject> {

                        // the Value in the dictionary is of type AnyObject
                        if let name = dict["name"] as? String, let height = dict["height"] as? String, let birth = dict["birth_year"] as? String, let hair = dict["hair_color"] as? String {
                            let person = SWPerson(name: name, height: height, birthYear: birth, hairColor: hair)
                            print(person.name)
                            print(person.height)
                            print(person.birthYear)
                            print(person.hairColor)
                            
                            if let films = dict["films"] as? [String] {
                                for film in films {
                                    print(film)
                                }
                            }
                        }
                    }
                    
                } catch {
                    print("could not serialize")
                }
            }
            
        }.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}

