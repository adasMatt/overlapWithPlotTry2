//
//  overlapIntegral.swift
//  overlapWithPlot
//
//  Created by Matthew Adas on 3/1/21.
//


//  originally from psiOverlap.swift, the psi functions work with the test functions in that project
//  overlapClass.swift
//  psiOverlap
//
//  Created by Matthew Adas on 2/26/21.
//


import Foundation
import SwiftUI

// overlap integral, usable for <1s|1s> and <2p|1s>
class overlapIntegralClass: ObservableObject {
    
    typealias equationHandler = (Double, Double, Double) -> Double
    
    let a = 0.529177210903   // real Bohr radius in angstroms
    let xMin = -5.0         // bounding box values
    let xMax = 5.0
    let yMin = -5.0
    let yMax = 5.0
    let zMin = -5.0
    let zMax = 5.0
    let box = BoundingBox()
    
    
    // this function takes arguments for n = 1, 2 for gs and fe state
    func psi1sFunc(x: Double, y: Double, z: Double) -> Double {
        
        var psi = 0.0
        let rInCart = sqrt(x*x + y*y + z*z)
        
        psi = pow(Double.pi * a * a * a, -0.5) * exp(-rInCart/a) // r -> rFromAvgLoop
        
        return psi
    }
    
    func psi2pFunc(x: Double, y: Double, z: Double) -> Double {
        
        var psi2p = 0.0
        let rInCart = sqrt(x*x + y*y + z*z)
        
        psi2p = pow(32.0 * Double.pi * a * a * a, -0.5) * (z/a) * exp(-0.5*rInCart/a) // r -> rFromAvgLoop
        
        return psi2p
    }
    
    // computational result of overlap
    // howManyTimes = 50,000
    // calculate overlap at random x,y,z, check result and store points for plotting
    // excluding point storage for now but still using "point" tuple, might belong in DrawingView struct but for now just going to define the function in this class
    func overlapMeanFunc(howManyTimes: Double, howFarAreTheProtons: Double) -> (Double, Double) {
        
        var psiTimesPsi = 0.0
        var psiByPsiSum = 0.0
        var overlapMeanValue = 0.0
        let R = Double(howFarAreTheProtons)
        let howManyTimesDouble = Double(howManyTimes)
        
        // define analytic result (aka true integral value)
        let analyticResultDouble = analyticResultFunc(howFarAreTheProtons: howFarAreTheProtons)
        var logOfError = 0.0
        
        var numberOfGuesses = 0.0
        //var pointsInRadius = 0.0
        var point = (xPoint: 0.0, yPoint: 0.0, zPoint: 0.0)
        //var newInsidePoints : [(xPoint: Double, yPoint: Double, zPoint: Double)] = []
        //var newOutsidePoints : [(xPoint: Double, yPoint: Double, zPoint: Double)] = []
        
        // calculate volume
        let volume = box.calculateCubeAreaAndVolume(passedLength: (xMax-xMin), passedWidth: (yMax-yMin), passedHeight: (zMax-zMin))
        
        // loop psiTimesPsi and plot good points
        while numberOfGuesses < howManyTimes {
            
            point.xPoint = Double.random(in: xMin...xMax)
            point.yPoint = Double.random(in: yMin...yMax)
            point.zPoint = Double.random(in: zMin...zMax)
            
            let x = point.xPoint
            let y = point.yPoint
            let z = point.zPoint
            
            //shift z by +/-R/2 for psi functions
            psiTimesPsi = psi1sFunc(x: x, y: y, z: z+(0.5*R)) * psi1sFunc(x: x, y: y, z: z-(0.5*R))
            /*
             // more point storage stuff for DrawingView
            // check if psiTimesPsi <= analyticResultDouble
            if psiTimesPsi <= analyticResultDouble {
                
                pointsInRadius += 1.0
                
                newInsidePoints.append(point)
            }
            else {
                newOutsidePoints.append(point)
            } */
            
            psiByPsiSum += psiTimesPsi
            numberOfGuesses += 1
            
        }
        
        // divide psiByPsiSum by howManyTimes to return the mean integral value
        overlapMeanValue = psiByPsiSum/howManyTimesDouble * volume
        
        // where does the error go
        logOfError = log10(abs(overlapMeanValue - analyticResultDouble)/analyticResultDouble)
        
        return (overlapMeanValue, logOfError)
        
    }
    
    
    // compare to true value
    /* analytical result of Overlap Integral
              _                _   _    _
         -R  |                |     | 2  |
         --- |       R     1  |  R  |    |
          a  |  1 + --- + --- | --- |    |  = I
       e     |       a     3  |  a  |    |
             |_               |_   _|   _|
    */
    func analyticResultFunc(howFarAreTheProtons: Double) -> Double {
        
        let R = Double(howFarAreTheProtons)
        var trueResult = 0.0
        let exponentialTerm = exp(-R/a)
        let secondOrderTerm = 1.0 + R/a + (1.0/3.0) * pow((R/a), 2.0)
        
        trueResult = exponentialTerm * secondOrderTerm
        
        // check these results elsewhere
        return trueResult
    }
    
    
    
    
    
    
    //let rPrime = sqrt(r*r + R*R - 2.0*r*R*cosine)  // fake, held off from changing r -> rFromAvgLoop here because I think is r * Cos(theta) = z??

    
    // convert polar to cartesian
    // theta [0, 2Pi]; phi [0, 2Pi]
    // r^2 = x^2 + y^2 + z^2
    // x = r*sin(phi)*cos(theta)
    // y = r*sin(phi)*sin(theta)
    // z = r*cos(phi)

}

