//
//  ViewController.swift
//  name_advisor
//
//  Created by Carl Jonsson on 2018-06-08.
//  Copyright © 2018 Carl Jonsson. All rights reserved.
//

import UIKit

class nameViewController: UIViewController {
    
    static var min_name = 0
    
    @IBOutlet var button1: UIButton!
    @IBOutlet var nameText: UILabel!
    
    
    @IBAction func bressButton1(_ sender: Any) {
        
        
        
    }
    
    @IBAction func bressButton2(_ sender: Any) {
        

        nameSelectController.example_names.append(varObject.mnames[nameViewController.min_name].lowercased())
        nameSelectController.example_names_like.append(1)
        
        nameSelectController().get_name_data(name: varObject.mnames[nameViewController.min_name].lowercased())
        
        
        var match = male_match(ref: varObject.mpref)
        nameViewController.min_name = find_min_match(match:match)
        
        nameText.text = varObject.mnames[nameViewController.min_name]
        
    }
    
    func male_match(ref : Array<CGFloat>) -> [CGFloat] {
        
        var mmatch = [CGFloat](repeating: 0, count: 492)
        
        for i in 0...491 {
            mmatch[i] = 0
            
            mmatch[i] = mmatch[i]+(CGFloat(varObject.mpop[i])-ref[0])*(CGFloat(varObject.mpop[i])-ref[0])*2.5
            mmatch[i] = mmatch[i]+(CGFloat(varObject.mtrend[i])-ref[1])*(CGFloat(varObject.mtrend[i])-ref[1])
            mmatch[i] = mmatch[i]+(CGFloat(varObject.mstav[i])-ref[2])*(CGFloat(varObject.mstav[i])-ref[2])/4
            mmatch[i] = mmatch[i]+(CGFloat(varObject.mhard[i])-ref[3])*(CGFloat(varObject.mhard[i])-ref[3])*2
            
            var urs_vektor = [CGFloat(0),CGFloat(0),CGFloat(0)]
            
            urs_vektor[varObject.murs[i]] = 1
            
            mmatch[i] = mmatch[i]+(urs_vektor[0]-ref[4])*(urs_vektor[0]-ref[4])
            mmatch[i] = mmatch[i]+(urs_vektor[1]-ref[5])*(urs_vektor[1]-ref[5])
            mmatch[i] = mmatch[i]+(urs_vektor[2]-ref[6])*(urs_vektor[2]-ref[6])
            
            
        }
        
        return mmatch
    }
    
    func find_min_match(match : Array<CGFloat>) -> Int {
        
        var t=0
        var temp_v = CGFloat(500)
        
        for i in 0...491 {
            if temp_v > match[i] {

                var add = 1
                
                for j in 0...nameSelectController.example_names.count-1 {
                    
                    if varObject.mnames[i].lowercased() == nameSelectController.example_names[j].lowercased() {
                        add = 0
                    }
                    
                }
                
                if add == 1 {
                
                    temp_v = match[i]
                    t = i
                }
            }
        }
        return t
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var match = male_match(ref: varObject.mpref)
        nameViewController.min_name = find_min_match(match:match)
        //print(nameViewController.min_name)
        
        nameText.text = varObject.mnames[nameViewController.min_name]
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

