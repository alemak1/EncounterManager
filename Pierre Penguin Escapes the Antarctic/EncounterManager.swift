//
//  EncounterManager.swift
//  Pierre Penguin Escapes the Antarctic
//
//  Created by Aleksander Makedonski on 3/3/17.
//  Copyright © 2017 JoyfulGames.io. All rights reserved.
//

import Foundation
import SpriteKit


class EncounterManager{
    
    let encounterNames: [String] = [
        "EncounterBats",
        "EncounterBees",
        "EncounterMadFlies"
    ]
    
    var encounters: [SKNode] = []

    func addEncountersToWorld(world: SKNode){
        for index in 0...encounters.count-1{
            encounters[index].position = CGPoint(x: -2000, y: index*1000)
            world.addChild(encounters[index])
        }
        
    }
    
    init(){
        
        for fileName in encounterNames{
            let encounter = SKNode()
            
            if let scene = SKScene(fileNamed: fileName){
             
                for childNode in scene.children{
                    
                    if let skNode = childNode as? SKNode{
                        
                        switch(skNode.name!){
                        case "Bat":
                            let bat = Bat();
                            bat.position = skNode.position
                            bat.move(toParent: encounter)
                            break
                        case "MadFly":
                            let madFly = MadFly();
                            madFly.position = skNode.position
                            madFly.move(toParent: encounter)
                            break
                        case "Bee":
                            let bee = Bee();
                            bee.position = skNode.position
                            bee.move(toParent: encounter)
                            break
                        case "Blade":
                            let blade = Blade();
                            blade.move(toParent: encounter)
                            break
                        case "GoldCoin":
                            let coin = Coin()
                            coin.position = skNode.position
                            coin.move(toParent: encounter)
                            coin.turnToGold()
                            break
                        case "BronzeCoin":
                            let coin = Coin()
                            coin.position = skNode.position
                            coin.move(toParent: encounter)
                            break
                        default:
                            print("Name error: \(skNode.name)")
                            
                        }
                    }
                    
                }
                
                encounters.append(encounter)
                
                
            }
        }
        
    }
    
}
