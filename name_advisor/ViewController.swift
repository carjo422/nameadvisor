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
    
    static var mnames = [String]()
    static var mpop = [CGFloat]()
    static var mtrend = [CGFloat]()
    static var mstav = [CGFloat]()
    static var mhard = [CGFloat]()
    static var murs = [CGFloat]()
    
    // Button to move on with next segue and gender is selected
    
    @IBAction func male(_ sender: Any) {
        ViewController.gender = 1
        
        ViewController.mnames = varObject.fnames
        ViewController.mpop = varObject.fpop
        ViewController.mtrend = varObject.ftrend
        ViewController.mstav = varObject.fstav
        ViewController.mhard = varObject.fhard
        ViewController.murs = varObject.furs
        
    }
    @IBAction func female(_ sender: Any) {
        ViewController.gender = 0
        
        ViewController.mnames = varObject.mnames
        ViewController.mpop = varObject.mpop
        ViewController.mtrend = varObject.mtrend
        ViewController.mstav = varObject.mstav
        ViewController.mhard = varObject.mhard
        ViewController.murs = varObject.murs
        
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

