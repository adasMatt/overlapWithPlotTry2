//
//  ContentView.swift
//  Shared
//
//  Created by Matthew Adas on 3/5/21.
//  working on calculating and displaying error in gui at least, still nothing on plots yet

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var overlap = overlapIntegralClass()

    @State var howFarInput: String = "0.0"
    @State var guesses: String = "0.0"
    @State var meanValueOutput: String = "1.0"
    @State var analyticResult: String = "1.0"
    @State var error: String = "0.0"
    @State var isChecked:Bool = false

    var body: some View {
        
        VStack{
      /*
            CorePlot(dataForPlot: $plotDataModel.plotData, changingPlotParameters: $plotDataModel.changingPlotParameters)
                .setPlotPadding(left: 10)
                .setPlotPadding(right: 10)
                .setPlotPadding(top: 10)
                .setPlotPadding(bottom: 10)
                .padding()
            
            Divider()
         */
            HStack{
                
                HStack(alignment: .center) {
                    Text("How far are your protons:")
                        .font(.callout)
                        .bold()
                    TextField("R", text: $howFarInput)
                        .padding()
                }.padding()
                
                HStack(alignment: .center) {
                    Text("How many guesses:")
                        .font(.callout)
                        .bold()
                    TextField("N", text: $guesses)
                        .padding()
                }.padding()
                
                HStack(alignment: .center) {
                    Text("mean:")
                        .font(.callout)
                        .bold()
                    TextField("mean", text: $meanValueOutput)
                        .padding()
                }.padding()
                
                /*Toggle(isOn: $isChecked) {
                            Text("Display Error")
                        }
                .padding()*/
                
                
            }
            
            HStack{
                
                HStack(alignment: .center) {
                    Text("Expected:")
                        .font(.callout)
                        .bold()
                    TextField("Expected:", text: $analyticResult)
                        .padding()
                }.padding()
                
                HStack(alignment: .center) {
                    Text("Error:")
                        .font(.callout)
                        .bold()
                    TextField("Error", text: $error)
                        .padding()
                }.padding()
               
            }
            
            HStack{
                Button("Calculate mean value", action: {self.meanValueAndErrorCalculation()} )
                .padding()
                
            }
        }
    }
    
    func meanValueAndErrorCalculation() {
        
        meanValueOutput = "\(overlap.overlapMeanFunc(howManyTimes: Double(guesses)!, howFarAreTheProtons: Double(howFarInput)!).0)"
        error = "\(overlap.overlapMeanFunc(howManyTimes: Double(guesses)!, howFarAreTheProtons: Double(howFarInput)!).1)"
        analyticResult = "\(overlap.analyticResultFunc(howFarAreTheProtons: Double(howFarInput)!))"
        
    }
    
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
