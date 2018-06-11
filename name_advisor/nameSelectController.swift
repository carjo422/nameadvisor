//
//  ViewController.swift
//  name_advisor
//
//  Created by Carl Jonsson on 2018-06-08.
//  Copyright © 2018 Carl Jonsson. All rights reserved.
//

import UIKit

class nameSelectController: UIViewController {
    
    var n_names = 0
    var n = CGFloat(0)
    
    @IBOutlet var top_icon: UIImageView!
    
    func count_vowels(str:String) -> CGFloat {
        
        var n_vowels = CGFloat(0)
        
        for i in str.characters {
            
            if i == "a" || i == "o" || i == "u" || i == "å" || i == "e" || i == "i" || i == "y" || i == "ä" || i == "ö" {
                n_vowels = n_vowels+1
            }
        }
        
        return(n_vowels)
        
        
    }
    
    func get_hardness(str:String) -> CGFloat {
        
        var hardness = CGFloat(0)
        var nhard = CGFloat(0)
        var nsoft = CGFloat(0)
        
        for i in str.characters {
            
            if i == "a" || i == "o" || i == "u" || i == "å" || i == "e" || i == "i" || i == "y" || i == "ä" || i == "ö" || i == "b" || i == "d" || i == "g" || i == "h" || i == "j" || i == "l" || i == "m" || i == "n" || i == "r" || i == "v"  {
                nsoft = nsoft+1
            }
            else {
                nhard = nhard+1
            }
        }
        
        hardness = nhard / (nhard+nsoft)
        
        return(hardness)
        
    }
    
    
    func get_name_data(name: String) {
        
        var pop = CGFloat(0)
        var trend = CGFloat(0)
        var urs = CGFloat(1)
        var stav = CGFloat(2)
        var hard = CGFloat(0.3)
        
        var get_match = 0
        
        for i in 0...varObject.mnames.count-1 {
            if name == varObject.mnames[i].lowercased() {
                pop = CGFloat(varObject.mpop[i])
                trend = CGFloat(varObject.mtrend[i])
                urs = CGFloat(varObject.murs[i])
                stav = CGFloat(varObject.mstav[i])
                hard = CGFloat(varObject.mhard[i])
                
                get_match = 1
                
            }
        }
        
        if get_match == 0 {
            pop = CGFloat(0)
            trend = CGFloat(-0.5)
            urs = CGFloat(1)
            stav = count_vowels(str: name)
            hard = get_hardness(str: name)
        }
        
        varObject.mpreffull[0] = varObject.mpreffull[0] + pop
        varObject.mpreffull[1] = varObject.mpreffull[1] + trend
        varObject.mpreffull[2] = varObject.mpreffull[2] + stav
        varObject.mpreffull[3] = varObject.mpreffull[3] + hard
        
        if urs == 0 {
            varObject.mpreffull[4] = varObject.mpreffull[4] + 1
        }
        else if urs == 1 {
            varObject.mpreffull[5] = varObject.mpreffull[5] + 1
        }
        else {
            varObject.mpreffull[6] = varObject.mpreffull[6] + 1
        }
        
        n = CGFloat(nameSelectController.example_names_like.count)
        
        for i in 0...6 {
            varObject.mpref[i] = varObject.mpreffull[i]/n
        }
        
    }

    
    static var example_names = [String]()
    static var example_names_like = [Int]()
    
    @IBOutlet var n_chosen_text: UILabel!
    @IBOutlet var inputName: UITextField!
    @IBOutlet var addName: UIButton!

    @IBAction func addNewName(_ sender: Any) {
        
        var name = inputName.text?.lowercased()
        name = name?.replacingOccurrences(of: " ", with: "")
        
        if name != nil && name != "" {
            
            var name_check = 0
            
            inputName.text = ""
            n_names = n_names + 1
            
            n_chosen_text.text = String(n_names) + "/3 namn inlagda"
            nameSelectController.example_names.append(name!)
            nameSelectController.example_names_like.append(1)
            
            
            
            // Get name data
            
            get_name_data(name: name!)
            
        }
        

        
        if n_names == 3 {
            performSegue(withIdentifier: "nameSegue", sender: nil)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if ViewController.gender == 1 {
            top_icon.image = UIImage(named: "female.png")
        }
        
        varObject.mpref = [CGFloat](repeating: 0, count: 7)
        varObject.mpreffull = [CGFloat](repeating: 0, count: 7)
        nameSelectController.example_names_like = []
        

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}

