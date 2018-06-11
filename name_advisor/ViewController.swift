//
//  ViewController.swift
//  name_advisor
//
//  Created by Carl Jonsson on 2018-06-08.
//  Copyright © 2018 Carl Jonsson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    static var gender = 0

    @IBAction func male(_ sender: Any) {
        ViewController.gender = 1
    }
    @IBAction func female(_ sender: Any) {
        ViewController.gender = 0
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

