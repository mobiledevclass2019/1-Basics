//
//  ContentView.swift
//  Bullseye
//
//  Created by 李超逸 on 2019/10/17.
//  Copyright © 2019 李超逸. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var alertIsVisable: Bool = false
    @State var whosThereIsVisable: Bool = false
    
    var body: some View {
        VStack {
            VStack {
                Text("Welcome to my first app!")
                    .fontWeight(.semibold)
                    .foregroundColor(Color.green)
                Button(action: {
                    self.alertIsVisable = true
                }) {
                    Text(/*@START_MENU_TOKEN@*/"Hit Me!"/*@END_MENU_TOKEN@*/)
                }
                .alert(isPresented: $alertIsVisable) { () -> Alert in
                    return Alert(title: Text("Hello there!"),
                                 message: Text("This is my first pop-up!"),
                                 dismissButton: .default(Text("Awesome!")))
                }
                Button(action: {
                    self.whosThereIsVisable = true
                }) {
                    Text("Knock, Knock!")
                }
                .alert(isPresented: $whosThereIsVisable) { () -> Alert in
                    return Alert(title: Text("Who's there? "),
                                 message: Text("Little old lady."),
                                 dismissButton: .default(Text("Little old lady who?")))
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
