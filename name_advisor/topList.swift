//
//  ViewController.swift
//  name_advisor
//
//  Created by Carl Jonsson on 2018-06-08.
//  Copyright © 2018 Carl Jonsson. All rights reserved.
//

import UIKit

class topList: UIViewController {
    
    // Button to move on with next segue and gender is selected
    @IBOutlet var l1: UILabel!
    @IBOutlet var l2: UILabel!
    @IBOutlet var l3: UILabel!
    @IBOutlet var l4: UILabel!
    @IBOutlet var l5: UILabel!
    @IBOutlet var l6: UILabel!
    @IBOutlet var l7: UILabel!
    @IBOutlet var l8: UILabel!
    @IBOutlet var l9: UILabel!
    @IBOutlet var l10: UILabel!
    
    var printList = ["","","","","","","","","","",""]
    
    
    override func viewDidLoad() {
        
        let match = nameViewController().male_match(ref: varObject.mpref)
        var taken = [CGFloat](repeating: 0, count: 492)
        
        for i in 0...9 {
            
            var temp_diff = CGFloat(10000)
            var next_name = 0
            
            
            for j in 0...491 {
                
                var liked_name = 1
                
                for k in 0...nameSelectController.n_names-1 {
                    if ViewController.mnames[j].lowercased() == nameSelectController.example_names[k].lowercased() {
                        if nameSelectController.example_likes[k] == 0 {
                            liked_name = 0
                        }
                    }
                }
                
                if liked_name == 1 {
                
                    if varObject.matchVector[j] < temp_diff {
                        if taken[j] == 0 {
                            temp_diff = varObject.matchVector[j]
                            next_name = j
                        }
                    }
                }
            }
            
            printList[i] = (ViewController.mnames[next_name])
            taken[next_name] = 1
            
            
        }
        
        l1.text = "1.  " + printList[0]
        l2.text = "2.  " + printList[1]
        l3.text = "3.  " + printList[2]
        l4.text = "4.  " + printList[3]
        l5.text = "5.  " + printList[4]
        l6.text = "6.  " + printList[5]
        l7.text = "7.  " + printList[6]
        l8.text = "8.  " + printList[7]
        l9.text = "9.  " + printList[8]
        l10.text = "10. " + printList[9]
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

