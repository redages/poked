//
//  PokemonDetailVC.swift
//  my_pokedex
//
//  Created by user on 7/20/16.
//  Copyright © 2016 frozenlightmedia. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    
    @IBOutlet weak var namelbl: UILabel!
    @IBOutlet weak var mainimg: UIImageView!
    @IBOutlet weak var descriptionlbl: UILabel!
    
    @IBOutlet weak var typelbl: UILabel!
    @IBOutlet weak var defenselbl: UILabel!
    
    @IBOutlet weak var heightlbl: UILabel!
    
    
    @IBOutlet weak var pokedexlbl: UILabel!
    
    @IBOutlet weak var weightlbl: UILabel!
    
    @IBOutlet weak var baseattacklbl: UILabel!
    
    @IBOutlet weak var evolbl: UILabel!
    
    @IBOutlet weak var currentevoimg: UIImageView!
    @IBOutlet weak var nextevoimg: UIImageView!
    
    
    var pokemon: Pokemon!

    @IBOutlet weak var pokenmonlabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        pokenmonlabel.text = pokemon.name
        
        var img = UIImage(named: "\(pokemon.pokedexId)")
        mainimg.image = img
        currentevoimg.image = img
        
        pokemon.downloadpokemondetails { () -> () in
            //this will be called after download is done
            self.updateUI()
            
        }
        
    }
    
    func updateUI() {
        
        descriptionlbl.text = pokemon.description
        typelbl.text = pokemon.type
        defenselbl.text = pokemon.defense
        heightlbl.text = pokemon.height
        pokedexlbl.text = "\(pokemon.pokedexId)"
        weightlbl.text = pokemon.weight
        baseattacklbl.text = pokemon.attack
        
        if pokemon.nextevolutionid == "" {
            
            evolbl.text = " No Evolutions"
            nextevoimg.hidden = true
        } else {
            
            nextevoimg.hidden = false
            nextevoimg.image = UIImage(named: pokemon.nextevolutionid)
            var str = "next Evolution: \(pokemon.nextevolution)"
            
            if pokemon.nextevolutionlevel != "" {
                
                str += " - LVL \(pokemon.nextevolutionlevel)"
            }
            evolbl.text = str
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func back(sender: AnyObject) {
        
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }

}