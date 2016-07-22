//
//  Pokemon.swift
//  my_pokedex
//
//  Created by user on 7/20/16.
//  Copyright © 2016 frozenlightmedia. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextevolution: String!
    private var _nextevolutionid: String!
    private var _nextevolutionlevel: String!
    private var _pokemonURL: String!
    
    
    var name: String {
        
        
        
        return _name
    }
    
    var pokedexId: Int {
        
        
        
        return _pokedexId
    }
    
    var description: String {
        
        if _description == nil {
            
            _description = ""
        }
        
        return _description
    }
    
    var type: String {
        
        if _type == nil {
            
            _type = ""
        }
        
        return _type
    }
    
    var defense: String {
        
        if _defense == nil {
            
            _defense = ""
        }
        
        return _defense
    }
    
    var height: String {
        
        if _height == nil {
            
            _height = ""
        }
        
        return _height
    }
    
    var weight: String {
        
        if _weight == nil {
            
            _weight = ""
        }
        
        return _weight
    }
    var attack: String {
        
        if _nextevolutionlevel == nil {
            
            _nextevolutionlevel = ""
        }
        
        return _attack
    }
    
    var nextevolution: String {
        
        if _nextevolution == nil {
            
            _nextevolution = ""
        }
        
        return _nextevolution
    }
    
    var nextevolutionid: String {
        
        if _nextevolutionid == nil {
            
            _nextevolutionid = ""
        }
        
        return _nextevolutionid
    }
    
    var nextevolutionlevel: String {
        
        if _nextevolutionlevel == nil {
            
            _nextevolutionlevel = ""
        }
        
        return _nextevolutionlevel
    }
    
    
    
    
    
    
    
    
    
    init(name: String, pokedexId: Int) {
        
        
        self._name = name
        self._pokedexId = pokedexId
        
        _pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self._pokedexId)/"
        
    }
    
    func downloadpokemondetails(completed: DownloadComplete) {
        
        let url = NSURL(string: _pokemonURL)!

        Alamofire.request(.GET, url).responseJSON { response in
            
            //print(response.request)  // original URL request
            //print(response.response) // URL response
            //print(response.data)     // server data
            //print(response.result)   // result of response serialization
            
            if let JSON = response.result.value  as? Dictionary<String, AnyObject> {
                
                if let weight = JSON["weight"] as? String {
                    
                    self._weight = weight
                }
                
                if let height = JSON["height"] as? String {
                    
                    self._height = height
                }
                
                if let attack = JSON["attack"] as? Int {
                    
                    self._attack = "\(attack)"
                }

                if let defense = JSON["defense"] as? Int {
                    
                    self._defense = "\(defense)"
                }
                
                if let types = JSON["types"] as? [Dictionary<String, String>] where types.count > 0 {
                    
                    if let name = types[0]["name"] {
                        self._type = name
                        
                    }
                    
                    if types.count > 1 {
                        
                        for var x = 1; x < types.count; x++ {
                            
                            if let name = types[x]["name"] {
                                self._type! += "/\(name.capitalizedString)"
                                
                            }
                            
                        }
                    }
                    
                   // print(types.debugDescription)
                } else {
                    
                    self._type = ""
                    
                    
                                    }
                
                
                
                if let descArr = JSON["descriptions"] as? [Dictionary<String, String>]
                    where descArr.count > 0 {
                    
                    if let url = descArr[0]["resource_uri"] {
                        
                        
                        let nsurl = NSURL(string: "\(URL_BASE)\(url)")!
                        Alamofire.request(.GET, nsurl).responseJSON { response in
                            
                            //let descresult = response.result
                            if let descdict = response.result.value as? Dictionary<String, AnyObject> {
                                
                                if let description = descdict["description"] as? String {
                                    
                                    self._description = description
                                    print(self._description)

                
                
                                }
                            }
                            completed()
                            
                        }
                        
                        
                        
                    }
                    
                } else {
                    
                    self._description = ""
                }
                
                

                print(self._weight)
                print(self._height)
                print(self._attack)
                print(self._defense)
                print(self._type)
                
                
                
                if let evolutions = JSON["evolutions"] as? [Dictionary<String, AnyObject>] where evolutions.count > 0 {
                    
                    if let to = evolutions[0]["to"] as? String {
                        
                        //Mega is not found
                        if to.rangeOfString("mega") == nil {
                            
                            if let uri = evolutions[0]["resource_uri"] as? String {
                                
                                let newStr = uri.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                                
                                let num = newStr.stringByReplacingOccurrencesOfString("/", withString: "")
                                
                                self._nextevolutionid = num
                                self._nextevolution = to
                                
                                if let lvl = evolutions[0]["level"] as? Int {
                                    
                                    self._nextevolutionlevel = "\(lvl)"

                                    
                                }
                            
                                
                            }
                            
                            //print(self._nextevolutionlevel)
                            print(self._nextevolution)
                            print(self._nextevolutionid)
                        }
                        
                    }
                    
                    
                    
                }
                
               
                
                    
                }
                
                //print("JSON\(JSON)")
            }

        }
    }
    
