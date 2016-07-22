//
//  PokeCell.swift
//  my_pokedex
//
//  Created by user on 7/20/16.
//  Copyright © 2016 frozenlightmedia. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    
    
    @IBOutlet weak var thumbimg: UIImageView!
    @IBOutlet weak var namelbl: UILabel!
    
    var pokemon: Pokemon!
    
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
        
    }
    
    
    func configureCell(pokemon: Pokemon) {
        
        self.pokemon = pokemon
        
        namelbl.text = self.pokemon.name.capitalizedString
        thumbimg.image = UIImage(named: "\(self.pokemon.pokedexId)")
        
    }
    
    
}
