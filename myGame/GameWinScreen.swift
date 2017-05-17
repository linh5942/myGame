//
//  GameWinScreen.swift
//  myGame
//
//  Created by Hsuan Lin on 5/16/17.
//  Copyright © 2017 Hsuan Lin. All rights reserved.
//

import SpriteKit

class GameWinScreen: SKScene {
    var currentScore = 0
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let nextScene = SKScene(fileNamed: "Menu")
        nextScene?.scaleMode = .aspectFit
        self.view?.presentScene(nextScene)
    }

}
