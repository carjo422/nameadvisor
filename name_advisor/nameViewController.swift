//
//  ViewController.swift
//  name_advisor
//
//  Created by Carl Jonsson on 2018-06-08.
//  Copyright © 2018 Carl Jonsson. All rights reserved.
//

import UIKit

class nameViewController: UIViewController {
    
    var min_name = 0 // Which name has the least variance vs name vector
    var n_likes = 0 // Number of names total
    
    @IBOutlet var button1: UIButton!
    @IBOutlet var nameText: UILabel!
    
    
    // LIKE BUTTON
    
    @IBAction func bressButton1(_ sender: Any) {
        
            nameSelectController.example_names.append(ViewController.mnames[min_name].lowercased()) // Add name to vector
            nameSelectController.example_likes.append(1) // Add like
        
            nameSelectController.n_names = nameSelectController.n_names + 1
            n_likes = n_likes + 1
        
            nameSelectController().get_name_data(name: ViewController.mnames[min_name].lowercased(), like: true) // Add variable data for name including LIKE
        
            varObject.matchVector = male_match(ref: varObject.mpref) // Match current vector with other names to find smallet variance
            min_name = find_min_match(match:varObject.matchVector) // Get the name
            nameText.text = ViewController.mnames[min_name] // Present the name
        
    }
    
    
    // DISLIKE BUTTON
    
    @IBAction func bressButton2(_ sender: Any) {
            
            nameSelectController.example_names.append(ViewController.mnames[min_name].lowercased()) // Add name to vector showing it was presented and clicked
            nameSelectController.example_likes.append(0) // Add dislike
        
            nameSelectController.n_names = nameSelectController.n_names + 1
            
            nameSelectController().get_name_data(name: ViewController.mnames[min_name].lowercased(), like: false) // Add variable data for name including DISLIKE
        
            varObject.matchVector = male_match(ref: varObject.mpref) // Match current vector with other names to find smallet variance
            min_name = find_min_match(match:varObject.matchVector) // Get the name
            nameText.text = ViewController.mnames[min_name] // Present the name

        
    }
    
    func male_match(ref : [[CGFloat]]) -> [CGFloat] {
        
        var mmatch = [CGFloat](repeating: 0, count: 492)
        
        var mn = [CGFloat](repeating: 0, count: 8)
        var stv = [CGFloat](repeating: 0, count: 8)
        
        let norm: [CGFloat] = [2, 4, 0.5, 0.5, 0.5, 0.25, 1, 0.5]
        var weight = [CGFloat](repeating: 1, count: 8)
        
        for k in 0...7 {
            for j in 1...nameSelectController.n_names {
                if ref[j][8] == 1 {
                    mn[k] = mn[k] + ref[j][k]/CGFloat(n_likes)
                }
            }
            
            for j in 1...nameSelectController.n_names {
                if ref[j][8] == 1 {
                    stv[k] = stv[k] + (abs(ref[j][k]-mn[k]))/sqrt(CGFloat(n_likes))
                }
                
                weight[k] = (1-stv[k])
                
            }
            
        }
        
        for i in 0...491 {
            
            mmatch[i] = 0
            
            for j in 1...nameSelectController.n_names {
                
                var diff = [CGFloat](repeating: 0, count: 8)
            
                diff[0] = (ViewController.mpop[i]-ref[j][0])*(ViewController.mpop[i]-ref[j][0])
                diff[1] = (ViewController.mtrend[i]-ref[j][1])*(ViewController.mtrend[i]-ref[j][1])
                
                var urs_vektor: [CGFloat] = [0,0,0]
                
                urs_vektor[Int(ViewController.murs[i])] = 1
                
                diff[2] = (urs_vektor[0]-ref[j][2])*(urs_vektor[0]-ref[j][2])
                diff[3] = (urs_vektor[1]-ref[j][3])*(urs_vektor[1]-ref[j][3])
                diff[4] = (urs_vektor[2]-ref[j][4])*(urs_vektor[2]-ref[j][4])
                
                diff[5] = (ViewController.mstav[i]-ref[j][5])*(ViewController.mstav[i]-ref[j][5])
                diff[6] = (ViewController.mhard[i]-ref[j][6])*(ViewController.mhard[i]-ref[j][6])
                
                var n_chars = CGFloat(0)
                
                for _ in ViewController.mnames[i].characters {
                    n_chars = min(n_chars+0.1,1)
                    
                }
                
                
                diff[7] = (n_chars-ref[j][7])*(n_chars-ref[j][7])*ref[j][8]
                
                for k in 0...7 {
                    mmatch[i] = mmatch[i] + diff[k]*norm[k]*norm[k]*weight[k]*ref[j][8]
                }
            }
            
        }
        
        return mmatch
    }
    
    func find_min_match(match : Array<CGFloat>) -> Int {
        
        var t=0
        var temp_v = CGFloat(500000000)
        
        for i in 0...491 {
            if temp_v > match[i] {

                var add = 1
                
                for j in 0...nameSelectController.example_names.count-1 {
                    
                    if ViewController.mnames[i].lowercased() == nameSelectController.example_names[j].lowercased() {
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
        
        n_likes = 0
        
        for i in 0...nameSelectController.n_names-1 {
            if varObject.mpref[i+1][8] == 1 {
                n_likes = n_likes + 1
            }
        }
        
        varObject.matchVector = male_match(ref: varObject.mpref)
        min_name = find_min_match(match:varObject.matchVector)
        
        nameText.text = ViewController.mnames[min_name]
    }
    
}

