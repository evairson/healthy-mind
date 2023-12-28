//
//  AddNewTaskView.swift
//  HealthyMind
//
//  Created by Eva Herson on 28/12/2023.
//

import SwiftUI
import CoreData

struct AddNewTaskView: View {
    
    @State var title = ""
    @State var colorForm = "task1"
    @State var iconForm = ""
    private let colors : [String] = ["task1","task2","task3","task4","task5"]
    private let icons : [String] = ["taskImage1","taskImage2","taskImage3","taskImage4"]
    
    var body: some View {
        VStack{
            
            HStack{
                Spacer()
                Text("ADD NEW FORM :")
                    .font(.custom("Ubuntu-Medium", size: 25))
                    .foregroundColor(Color("font"))
                Spacer()
            }
            VStack{
                    TextField("Name of the form", text: $title)
                        .font(.custom("ChalkboardSE-Light", size: 25))
                        .foregroundColor(Color("background"))
                
                ScrollView(.horizontal) {
                    HStack{
                        Text("Select Color : ")
                            .font(.custom("ChalkboardSE-Light", size: 20))
                            .foregroundColor(Color("background"))
                        Spacer()
                    }
                    
                    HStack {
                        ForEach(colors, id: \.self) { color in
                            Circle()
                                .foregroundColor(Color(color))
                                .frame(width:45, height: 45)
                                .onTapGesture {
                                    colorForm = color
                                }
                        }
                    }
                }
                .padding()
                
                ScrollView(.horizontal) {
                    HStack{
                        Text("Select Icon : ")
                            .font(.custom("ChalkboardSE-Light", size: 20))
                            .foregroundColor(Color("background"))
                        Spacer()
                    }
                    
                    HStack {
                        ForEach(icons, id: \.self) { icon in
                            
                            Image(icon)
                                .resizable()
                                .scaledToFit()
                                .frame(width:45, height: 45)
                                .opacity(icon == iconForm ? 1 : 0.5)
                                .scaleEffect(icon == iconForm ? 1.1 : 1)
                                .animation(.easeIn, value: icon == iconForm ? 1.1 : 1)
                                .onTapGesture {
                                    iconForm = icon
                                }
                        }
                    }
                }
                .padding()
                Spacer()
                
            }
            .padding(25)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(colorForm))
            .cornerRadius(20)
            
            

            
        }
        .padding()
        .background(Color("background"))
    }
}

#Preview {
    AddNewTaskView()
}
