//
//  ContentView.swift
//  BrainGame
//
//  Created by bharat venna on 22/08/23.
//

import SwiftUI

struct ContentView: View {
    
    var options = ["🪨", "📃", "✂️"]
    @State private var botChoice = Int.random(in: 0...2)
    @State private var alertToggle = false
    @State private var alertTitle = ""
    @State private var score = 0
    @State private var alertButton = ""
    @State private var questions = 10
    @State private var alertMessage = ""
    
    func optionTapped(number: Int) {
        if(options[botChoice] == options[number])
        {
            alertTitle = "Tie"
        }else if(options[botChoice] == "🪨" && options[number] == "📃"){
            alertTitle = "Won"
            score += 1
        }else if(options[botChoice] == "🪨" && options[number] == "✂️"){
            alertTitle = "lose"
        }else if(options[botChoice] == "📃" && options[number] == "🪨"){
            alertTitle = "lose"
        }else if(options[botChoice] == "📃" && options[number] == "✂️"){
            alertTitle = "Won"
            score += 1
        }else if(options[botChoice] == "✂️" && options[number] == "📃"){
            alertTitle = "lose"
        }else {
            alertTitle = "Won"
            score += 1
        }
//        alertButton = "Next Question"
        
        if(alertTitle == "Won"){
            alertMessage = "Your score is: \(score)"
        }else {
            alertMessage = "\(options[botChoice]) 💥 \(options[number])"
        }
        
        if(questions <= 1){
            alertButton = "New Game"
            newGame()
        } else {
            alertButton = "Next Question"
//            newQuestion()
            questions -= 1 // keeping track of number of questions
        }
        
       
        alertToggle = true // Alert toggle
        
    }
    
    func newGame(){
        botChoice = Int.random(in: 0...2)
        score = 0
        questions = 10
    }
    
    func newQuestion(){
        botChoice = Int.random(in: 0...2)
        
    }
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.indigo, .black]), startPoint: .top, endPoint: .bottom) // Creating background
            
            VStack{
//                Text("bot choice is: \(options[botChoice])") // Displaying bot choice for testing
                Text("Select right option")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding()
                    .background(.ultraThinMaterial)
                    .clipShape(Capsule())
                
                ForEach(0..<3) { number in
                    Button{
                        optionTapped(number: number)// option tapped
                    }label: {
                        Text("\(options[number])")
                            .padding()
                            .font(.custom("option", size: 75))
                    }
                    .alert(alertTitle, isPresented: $alertToggle){
                        Button("\(alertButton)", action: newQuestion)
                    }message: {
                        Text("\(alertMessage)")
                    }
                }
            }
        }
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
