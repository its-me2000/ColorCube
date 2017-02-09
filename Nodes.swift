//
//  Nodes.swift
//  ColorCube
//
//  Created by Eugenijus Margalikas on 18/11/2016.
//  Copyright © 2016 Eugenijus Margalikas. All rights reserved.
//

protocol Nodes {
    func addColor(_ color:Color)->Bool
    func getColorNodes()->[Nodes]
    func getColorNodeFor(color:Color)->ColorCube.ColorNode?
}
