//
//  ViewController.swift
//  name_advisor
//
//  Created by Carl Jonsson on 2018-06-08.
//  Copyright © 2018 Carl Jonsson. All rights reserved.
//

import UIKit

class nameSelectController: UIViewController {
    
    static var n_names = 0
    var n = CGFloat(0)
    
    @IBOutlet var top_icon: UIImageView!
    
    // Function to get number of vowels for name
    
    func count_vowels(str:String) -> CGFloat {
        
        var n_vowels = CGFloat(0)
        
        for i in str.characters {
            
            if i == "a" || i == "o" || i == "u" || i == "å" || i == "e" || i == "i" || i == "y" || i == "ä" || i == "ö" {
                n_vowels = n_vowels+1
            }
            
            n_vowels = min(n_vowels,4) // Max four vowels
        }
        
        n_vowels = n_vowels/4 // Normalising data by /4
        
        return(n_vowels)
        
        
    }
    
    // Function get hardness of name ("Hard" letters / total letters)
    
    func get_hardness(str:String) -> CGFloat {
        
        var hardness = CGFloat(0)
        var nhard = CGFloat(0)
        var nsoft = CGFloat(0)
        
        for i in str.characters {
            
            if i == "a" || i == "o" || i == "u" || i == "å" || i == "e" || i == "i" || i == "y" || i == "ä" || i == "ö" || i == "b" || i == "d" || i == "g" || i == "h" || i == "j" || i == "l" || i == "m" || i == "n" || i == "r" || i == "v"  {
                nsoft = nsoft+1 // Soft letters
            }
            else {
                nhard = nhard+1 // Hard letters
            }
        }
        
        hardness = nhard / (nhard+nsoft)
        
        return(hardness)
        
    }
    
    // Function to check newly input name and classify it by variables
    
    func get_name_data(name: String, like: Bool) {
        
        var add_vector = [CGFloat](repeating: 0, count: 9) // Vector to add
        var get_match = 0
        var n_chars = 0
        let beta = CGFloat(-0.2) // How much negative impact for downvoted names vs +1 for upvoted
        
        for i in 0...ViewController.mnames.count-1 {
            if name == ViewController.mnames[i].lowercased() { // If name exists in namedata
                
                add_vector[0] = CGFloat(ViewController.mpop[i]) // Add popularity from varObject
                add_vector[1] = CGFloat(ViewController.mtrend[i]) // Add trend from varObject
                
                if ViewController.murs[i] == 0 { // From varObject
                    add_vector[2] = 1 // Add name origin 1 if swedish, 0 otherwise
                }
                else if ViewController.murs[i] == 1 {
                    add_vector[3] = 1 // Add name origin 1 if western europe, 0 otherwise
                }
                else {
                    add_vector[4] = 1 // Add name origin 1 if non of above
                }
                
                
                add_vector[5] = count_vowels(str: name) // Vowels counted by function
                add_vector[6] = get_hardness(str: name) // Hardness counted by function
                
                for _ in ViewController.mnames[i].characters { // Count number of characters in name (max 10)
                    n_chars = min(n_chars+1,10)
                }
                
                add_vector[7] = CGFloat(n_chars)/10 // Normalise by /10
                
                if like { // If name was liked
                    add_vector[8] = 1 // positive impact 1
                }
                else { add_vector[8] = beta } // Otherwise negative impact Beta
                
                get_match = 1 // Notify that name was matched
                
            }
        }
        
        if get_match == 0 { // If name was not matched
            add_vector[0] = CGFloat(0) // Popularity considered to be 0
            add_vector[1] = CGFloat(-0.1) // Trend considered to be -0.1
            add_vector[2] = CGFloat(0.33) // 0.33 at Swedish origin
            add_vector[3] = CGFloat(0.33) // 0.33 at Western Europe origin
            add_vector[4] = CGFloat(0.33) // 0.33 at Other origin
            add_vector[5] = count_vowels(str: name) // Vowels counted by function
            add_vector[6] = get_hardness(str: name) // Hardness counted by function
            
            for _ in name.characters { // Count number of characters in name (max 10)
                n_chars = min(n_chars+1,10)
            }
            
            add_vector[7] = CGFloat(n_chars)/10 // Normalise by /10
            
            if like { // If name was liked
                add_vector[8] = 1 // positive impact 1
            }
            else { add_vector[8] = beta } // Otherwise negative impact Beta
            
        }
        
        varObject.mpref.append(add_vector) // Add name information to information vector for comparison
        
    }
    

    
    static var example_names = [String]() // Names that has been inputed
    static var example_likes = [Int]() // Like no like

    
    @IBOutlet var n_chosen_text: UILabel!
    @IBOutlet var inputName: UITextField!
    @IBOutlet var addName: UIButton!

    @IBAction func addNewName(_ sender: Any) { // Add three first names
        
        var name = inputName.text?.lowercased()
        name = name?.replacingOccurrences(of: " ", with: "")
        
        if name != nil && name != "" { // No empty names
            
            inputName.text = "" // Reset input text
            nameSelectController.n_names = nameSelectController.n_names + 1
            
            n_chosen_text.text = String(nameSelectController.n_names) + "/3 namn inlagda"
            
            nameSelectController.example_names.append(name!) // Add names
            nameSelectController.example_likes.append(1) // Add like
            
            // Get name data
            
            get_name_data(name: name!, like: true) // Calculate name vector from names
            
        }
        

        
        if nameSelectController.n_names == 3 {
            performSegue(withIdentifier: "nameSegue", sender: nil) // Move on after 3 names
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameSelectController.n_names=0
        nameSelectController.example_names = [String]() // Names that has been inputed
        nameSelectController.example_likes = [Int]() // Like no like
        varObject.mpref = [[CGFloat](repeating: 0, count: 9)]
        varObject.matchVector = [CGFloat](repeating: 0, count: 492)
        
        if ViewController.gender == 1 {
            top_icon.image = UIImage(named: "female.png") // Change picture on gender
        }

    }
    
    
}

