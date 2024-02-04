//
//  AddViewTuto.swift
//  HealthyMind
//
//  Created by Eva Herson on 01/02/2024.
//

import SwiftUI

struct AddViewTuto: View {
    
    @Binding var step : Int
    @Binding var tuto : Bool
    @State private var text = "Hi ! My name is Koly. Im here to help you understand this app."
    @State private var image = 1
    @State private var direction : ChatBubbleTestView.Direction = ChatBubbleTestView.Direction.left
    
    
    var body: some View {
        GeometryReader { geo in
            VStack{
                Spacer()
                HStack {
                    if(direction == ChatBubbleTestView.Direction.left){
                        Spacer()
                    }
                    ZStack{
                        ChatBubbleTestView(width: geo.size.width/2, height: geo.size.height/5, color: Color("font2"), direction: direction)
                        Text(text)
                            .font(.custom("ChalkboardSE-Light", size: 18))
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.leading)
                            .padding(15)
                            .frame(maxWidth: geo.size.width/2)
                            
                    }
                    if(direction == ChatBubbleTestView.Direction.right){
                        Spacer()
                    }
                    
                }
                .padding()

                HStack{
                    if(direction == ChatBubbleTestView.Direction.right){
                        Spacer()
                    }
                    Image("hummingbird\(image)")
                       .resizable()
                       .scaledToFit()
                       .frame(width: geo.size.width/2)
                    if(direction == ChatBubbleTestView.Direction.left){
                        Spacer()
                    }
                }

            }
            .padding()
        }
        .background(Color.white.opacity(0.1))
        .onTapGesture {
            switch(step){
                case 0 : text = "Here you can fill form to help you feel better"; image = 4
                case 1 : text = "I've already made form for you. You can fill those as much as you need"; image = 1
                case 2 : text = "And you can also add your own form"; image = 3; direction = ChatBubbleTestView.Direction.right
                case 3 : text = "Here you can add habits you want to achieve"; image = 2; direction = ChatBubbleTestView.Direction.left
                case 4 : text = "For exemple, if you want to drink 5 times water you can add it"
                case 5 : text = "After you drank one time you can click here"; image = 4;
                case 6 : text = "Habits will return every morning and you can remake it"; image = 1;
                case 7 : text = "You can get the history of every form you fill here"; image = 3; direction = ChatBubbleTestView.Direction.right
                case 8 : text = "You can also change the calendar and see the history of your habits"; image = 5;
                case 9 : text = "I let you explore the rest of the app ! Bye ^^"; image = 3
                default : text = "Something went wrong"; tuto = false
            }
            step += 1
            
        }
    }

}

