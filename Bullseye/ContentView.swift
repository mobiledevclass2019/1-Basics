//
//  ContentView.swift
//  Bullseye
//
//  Created by 李超逸 on 2019/10/17.
//  Copyright © 2019 李超逸. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var alertIsVisable = false
    @State var sliderValue = 50.0
    @State var target = Int.random(in: 1...100)
    
    var body: some View {
        VStack {
            Spacer()
            // Target row
            HStack {
                Text("Drag the slider as close as you can to:")
                Text("\(target)")
            }
            Spacer()
            // Slider row
            HStack {
                Text("1")
                Slider(value: $sliderValue, in: 1...100)
                Text("100")
            }
            Spacer()
            // Button row
            VStack {
                
                Button(action: {
                    self.alertIsVisable = true
                }) {
                    Text(/*@START_MENU_TOKEN@*/"Hit Me!"/*@END_MENU_TOKEN@*/)
                }
                .alert(isPresented: $alertIsVisable) { () -> Alert in
                    return Alert(title: Text("Hello there!"),
                                 message: Text("The slider value is \(sliderValueRounded())\n" +
                                    "You scored \(pointsForCurrentRound()) points this round."),
                                 dismissButton: .default(Text("Awesome!")))
                }
            }
            Spacer()
            // Score row
            HStack {
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("Start Over")
                }
                Spacer()
                Text("Score:")
                Text("99999")
                Spacer()
                Text("Round:")
                Text("999")
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("Info")
                }
            }
            .padding(.bottom, 20)
        }
    }
    
    func sliderValueRounded() -> Int {
        Int(self.sliderValue.rounded())
    }
    
    func pointsForCurrentRound() -> Int {
        let difference = abs(self.target - sliderValueRounded())
        let score = 100 - difference
        return score
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewLayout(.fixed(width: 896, height: 414))
    }
}
