//
//  AddNewTaskView.swift
//  HealthyMind
//
//  Created by Eva Herson on 28/12/2023.
//

import SwiftUI
import CoreData

struct AddNewTaskView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var title = ""
    @State var colorForm = "task1"
    @State var iconForm = ""
    @State var contains : [TaskContain] = []
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
            ScrollView{
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
                    .padding(.bottom)
                    
                    HStack(spacing: 10){
                        Button {
                            addNewTaskContainText()
                        } label:{
                            Text("Add Text Form")
                                .font(.custom("ChalkboardSE-Light", size: 17))
                                .foregroundColor(Color("font"))
                                .padding(15)
                                .background(Color("background"))
                                .cornerRadius(10)
                        }
                        
                        Button {
                            addNewTaskContainIcon()
                        } label:{
                            Text("Add Image Form")
                                .font(.custom("ChalkboardSE-Light", size: 17))
                                .foregroundColor(Color("font"))
                                .padding(15)
                                .background(Color("background"))
                                .cornerRadius(10)
                        }
                    }
                    .padding(.bottom)
                    
                    ForEach(contains, id: \.self) { contain in
                        VStack{
                            Text(contain.isText ? "Text Form" : "Image Form")
                                .padding(.top)
                                .textCase(.uppercase)
                                .font(.custom("ChalkboardSE-Light", size: 20))
                            HStack{
                                TextField("Title", text: Binding(
                                    get: { contain.title ?? "" },
                                    set: { newText in
                                        contain.title = newText }))
                                .textCase(.uppercase)
                                .font(.custom("ChalkboardSE-Light", size: 20))
                                .padding(10)
                                
                                
                                
                                Spacer()
                            }
                            
                            if contain.isIcon {
                                ListIconNewFormView(contain: contain, width: 50)
                                
                            }
                        }
                        .foregroundColor(Color("font"))
                        .background(Color("background"))
                        .cornerRadius(10)
                        .padding(.bottom)
                        
                        
                    }
                    
                    Spacer()
                }
                
            }
            .padding(25)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(colorForm))
            .cornerRadius(20)
            
            

            
        }
        .padding()
        .background(Color("background"))
    }
    
    func addNewTaskContainText(){
        let contain = TaskContain(context: viewContext)
        contain.isText = true
        contains.append(contain)
        do {
            try viewContext.save()
        }
        catch {
            
        }
    }
    
    func addNewTaskContainIcon(){
        let contain = TaskContain(context: viewContext)
        contain.isIcon = true
        contain.listIcons = TaskContain.listIconOne
        contains.append(contain)
        do {
            try viewContext.save()
        }
        catch {
            
        }
    }
}

struct ListIconNewFormView: View  {
    @ObservedObject var contain : TaskContain
    var width : Double
    var icons : [Int]
    
    init(contain: TaskContain, width: Double){
        self.contain = contain
        self.width = width
        icons = TaskContain.listIconOne
        contain.listIcons = []
    }
    
    
    
    
    var body: some View {
        
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(minimum: 20, maximum: width), spacing: 5, alignment: .center), count: 4)) {
                ForEach(icons, id: \.self) { icon in
                    Image("humeur\(icon)")
                        .resizable()
                        .scaledToFit()
                        .opacity(contain.listIcons!.contains(icon) ? 1 : 0.5)
                        .scaleEffect(contain.listIcons!.contains(icon) ? 1.1 : 1)
                        .animation(.easeIn, value: contain.listIcons!.contains(icon) ? 1.1 : 1)
                        .onTapGesture {
                            if(contain.listIcons!.contains(icon)){
                                contain.listIcons = contain.listIcons!.filter(){$0 != icon}
                            }
                            else {
                                contain.listIcons!.append(icon)
                            }
                        }
                        
                    }
            }

    }
}


#Preview {
    AddNewTaskView()
}
