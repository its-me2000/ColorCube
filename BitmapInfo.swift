//
//  BitmapInfo.swift
//  ColorCube
//
//  Created by Eugenijus Margalikas on 18/11/2016.
//  Copyright © 2016 Eugenijus Margalikas. All rights reserved.
//

class BitmapInfo{
    enum ColorMode {
        case RGBA
        case ARGB
    }
    let bpc:Int = 8888
    let colorMode:ColorMode = .RGBA
    let width:Int
    let height:Int
    
    init(width:Int, height:Int){
        self.width  = width
        self.height = height
    }
    
}
