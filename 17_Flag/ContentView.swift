//
//  ContentView.swift
//  17_Flag
//
//  Created by mac on 04.11.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["UK", "USA", "Bangladesh", "Germany", "Argentina", "Brazil", "Canada", "Greece", "Russia", "Sweden"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.black, .white]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)//заливает верхнюю и нижнюю область
            VStack(spacing: 30) /*расстояние между флагами*/ {
                VStack {
                    Text("Выбери флаг")
                        .foregroundColor(.white)//цвет букв
                        .font(.headline)//шрифт
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                ForEach(0..<3) {number in
                    Button(action: {
                        self.flagTapped(number)
                        self.showingScore = true
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .frame(width: 250, height: 125)//рамка
                            .clipShape(Capsule())//овал
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1))// рамка
                            .shadow(color: .black, radius: 2)//тень
                    }
                }
                Text("Общий счет: \(score)")
                    .font(.largeTitle)
                    .fontWeight(.black)
                
                Spacer()
            }
        }.alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Общий счет: \(score)"), dismissButton: .default(Text("Продолжить")){
                self.askQuestion()
            })
        }
    }
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
    }
    
    func flagTapped(_ number:Int) {
        if number == correctAnswer {
            scoreTitle = "Правильный ответ!"
            score += 1
        } else {
            scoreTitle = "Неправильно! Это флаг \(countries[number ])"
            score -= 1
        }
    }
    
}






















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
