//
//  AddViewTuto.swift
//  HealthyMind
//
//  Created by Eva Herson on 01/02/2024.
//

import SwiftUI

struct AddViewTuto: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @Binding var step : Int
    @State private var text = "Hi! My name is Koly. I'm here to help you understand this app"
    @State private var image = 1
    @State private var direction : ChatBubbleTestView.Direction = ChatBubbleTestView.Direction.left
    @State private var height : CGFloat = 155
    
    @FetchRequest( sortDescriptors: [], animation: .default)
    private var infoUser: FetchedResults<InfoUser>
    
    
    var body: some View {
        GeometryReader { geo in
            VStack{
                Spacer()
                HStack {
                    if(direction == ChatBubbleTestView.Direction.left){
                        Spacer()
                    }
                    ZStack{
                        ChatBubbleTestView(width: 200, height: height, color: Color("font2"), direction: direction)
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
                case 0: text = "Here you can fill out forms to help you feel better"; image = 4; height = 120
                case 1: text = "I've already created forms for you. You can fill these out as often as you need"; image = 1; height = 135
                case 2: text = "And you can also add your own forms"; image = 3; direction = ChatBubbleTestView.Direction.right; height = 110
                case 3: text = "Here you can add habits you want to achieve"; image = 2; direction = ChatBubbleTestView.Direction.left
                case 4: text = "For example, if you want to drink water 5 times, you can add it"; height = 135
                case 5: text = "After you've drunk once, you can click here"; image = 4; height = 120
                case 6: text = "Habits will reset every morning and you can redo them"; image = 1;
                case 7: text = "You can access the history of every form you've filled out here"; image = 3; direction = ChatBubbleTestView.Direction.right
                case 8: text = "You can also change the calendar and view the history of your habits"; image = 5; height = 155
                case 9: text = "I'll let you explore the rest of the app! Bye ^^"; image = 3; height = 135
                default: text = "Bye ^^"; tutoEnd()
            }
            step += 1
            
        }
    }
    
    func tutoEnd(){
        infoUser.first!.tuto = false
        
        do {
            try viewContext.save()
        }
        catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }

}

