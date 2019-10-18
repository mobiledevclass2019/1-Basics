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
    @State var score = 0
    @State var round = 1
    
    struct LabelStyle: ViewModifier {
        func body(content: Content) -> some View {
            content
                .modifier(Shadow())
                .foregroundColor(Color.white)
                .font(.custom("Arial Rounded MT Bold", size: 18))
        }
    }
    
    struct ValueStyle: ViewModifier {
        func body(content: Content) -> some View {
            content
                .modifier(Shadow())
                .foregroundColor(Color.yellow)
                .font(.custom("Arial Rounded MT Bold", size: 24))
        }
    }
    
    struct Shadow: ViewModifier {
        func body(content: Content) -> some View {
            content
                .shadow(color: .black, radius: 5, x: 2, y: 2)
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            // Target row
            HStack {
                Text("Drag the slider as close as you can to:").modifier(LabelStyle())
                Text("\(target)").modifier(ValueStyle())
            }
            Spacer()
            // Slider row
            HStack {
                Text("1").modifier(LabelStyle())
                Slider(value: $sliderValue, in: 1...100)
                Text("100").modifier(LabelStyle())
            }
            Spacer()
            // Button row
            VStack {
                
                Button(action: {
                    self.alertIsVisable = true
                    self.score = self.score + self.pointsForCurrentRound()
                }) {
                    Text(/*@START_MENU_TOKEN@*/"Hit Me!"/*@END_MENU_TOKEN@*/)
                }
                .alert(isPresented: $alertIsVisable) { () -> Alert in
                    return Alert(title: Text(alertTitle()),
                                 message: Text("The slider value is \(sliderValueRounded())\n" +
                                    "You scored \(pointsForCurrentRound()) points this round."),
                                 dismissButton: .default(Text("Awesome!")) {
                                    self.target = Int.random(in: 1...100)
                                    self.round += 1
                        })
                }
            }
            Spacer()
            // Score row
            HStack {
                Button(action: {
                    self.reset()
                }) {
                    Text("Start Over")
                }
                Spacer()
                Text("Score:").modifier(LabelStyle())
                Text("\(score)").modifier(ValueStyle())
                Spacer()
                Text("Round:").modifier(LabelStyle())
                Text("\(round)").modifier(ValueStyle())
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("Info")
                }
            }
            .padding(.bottom, 20)
        }
        .background(Image("Background"), alignment: .center)
    }
    
    func sliderValueRounded() -> Int {
        Int(self.sliderValue.rounded())
    }
    
    func amountOff() -> Int {
        abs(self.target - sliderValueRounded())
    }
    
    func pointsForCurrentRound() -> Int {
        let maximumScore = 100
        let diffenence = amountOff()
        let score = maximumScore - diffenence
        let bonus: Int
        if diffenence == 0 {
            bonus = 100
        } else if diffenence < 50 {
            bonus = 50
        } else {
            bonus = 0
        }
        return score + bonus
    }
    
    func alertTitle() -> String {
        let difference = amountOff()
        let title: String
        if difference == 0 {
            title = "Perfect!"
        } else if difference < 5 {
            title = "Almost!"
        } else if difference < 10 {
            title = "Not bad!"
        } else {
            title = "Not even close!"
        }
        return title
    }
    
    func reset() {
        sliderValue = 50.0
        target = Int.random(in: 1...100)
        score = 0
        round = 1
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewLayout(.fixed(width: 896, height: 414))
    }
}
