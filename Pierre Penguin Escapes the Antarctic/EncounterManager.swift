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
    
    var currentEncounterIndex: Int? 
    var previousEncounterIndex: Int?
    
    var encounters: [SKNode] = []
    
    func placeNextEncounter(currentXPos: CGFloat){
        let encounterCount = UInt32(encounters.count)
        
        if(encounterCount < 3) { return }
        
        var nextEncounterIndex: Int?
        var trulyNew: Bool?
        
        
        while(trulyNew == false || trulyNew == nil){
            nextEncounterIndex = Int(arc4random_uniform(encounterCount))
            trulyNew = true
            
            if let currentIndex = currentEncounterIndex{
                if(nextEncounterIndex == currentIndex){
                    trulyNew = false
                }
            }
            
            if let previousIndex = previousEncounterIndex{
                if(nextEncounterIndex == previousIndex){
                    trulyNew = false
                }
            }
        }
        
        previousEncounterIndex = currentEncounterIndex
        currentEncounterIndex = nextEncounterIndex
        
        let encounter = encounters[currentEncounterIndex!]
        encounter.position = CGPoint(x: currentXPos + 1000.0, y: 0.0)
        resetSpritePositions(node: encounter)
        
    }
    
    func addEncountersToWorld(world: SKNode){
        for index in 0...encounters.count-1{
            encounters[index].position = CGPoint(x: -2000, y: index*1000)
            world.addChild(encounters[index])
        }
        
    }
    
    func saveSpritePositions(node: SKNode){
        for sprite in node.children{
            if let spriteNode = sprite as? SKSpriteNode{
                let initialPositionValue = NSValue(cgPoint: spriteNode.position)
                spriteNode.userData = ["initialPosition": initialPositionValue]
                saveSpritePositions(node: spriteNode)
                
            }
        }
    
    }
    
    func resetSpritePositions(node: SKNode){
        for sprite in node.children{
            if let spriteNode = sprite as? SKSpriteNode{
                spriteNode.zRotation = 0
                spriteNode.physicsBody?.angularVelocity = 0
                spriteNode.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                if let initialPositionValue = spriteNode.userData?.value(forKey: "initialPosition") as? NSValue{
                    spriteNode.position = initialPositionValue.cgPointValue
                }
                
                resetSpritePositions(node: spriteNode)
            }
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
                saveSpritePositions(node: encounter)
                
            }
        }
        
    }
    
}
