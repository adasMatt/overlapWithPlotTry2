//
//  BoundingBox.swift
//  psiOverlap.swift
//
//  Created by Matthew Adas on 2/27/21.
//
//
import SwiftUI

class BoundingBox: ObservableObject {
    
    
    
    func calculateCubeAreaAndVolume(passedLength: Double, passedWidth: Double, passedHeight: Double) -> Double {
        //the passedLength is the same as passedRadius in the Sphere subclass, so it needs to be multiplied by 2 to get the length of one side of the bounding box
        let volume = passedWidth * passedHeight * passedLength
        //surface area of box 2 x (L x W) + 2 x (L x H) + 2 x (W X H)
        //since this box is a cube this is simplified
        
        return (volume)
    }
    
}
