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
    @State var errorText = false
    
    @Binding var isPresented : Bool
    
    @FetchRequest( sortDescriptors: [], animation: .default)
    private var counter: FetchedResults<CounterId>
    
    
    private let colors : [String] = ["task1","task2","task3","task4","task5"]
    private let icons : [String] = ["taskImage1","taskImage2","taskImage3","taskImage4"]
    
    var body: some View {
        GeometryReader{ geo in
            VStack{
                HStack{
                    Button{
                        isPresented = false
                    } label: {
                        Image(systemName: "xmark.circle")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(Color("font"))
                            .frame(maxWidth: 15)
                    }
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
                                HStack{
                                    Spacer()
                                    Text(contain.isText ? "Text Form" : "Image Form")
                                        .textCase(.uppercase)
                                        .font(.custom("ChalkboardSE-Light", size: 18))
                                    Spacer()
                                    Button {
                                        if let index = contains.firstIndex(of: contain) {
                                            contains.remove(at: index)
                                        }
                                    } label: {
                                        Image(systemName: "xmark.circle")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(maxWidth: geo.size.width/20)
                                            .foregroundColor(Color("font"))
                                    }
                                }
                                .padding([.leading,.top,.trailing])
                                
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
                        
                        Button {
                            if(verify()){
                                saveNewTask()
                                isPresented = false
                            }
                            else {
                                errorText = true
                            }
                        } label:{
                            Text("ADD NEW FORM")
                                .font(.custom("ChalkboardSE-Light", size: 17))
                                .foregroundColor(Color("font"))
                                .padding(15)
                                .background(Color("background"))
                                .cornerRadius(10)
                                .opacity(verify() ? 1 : 0.5)
                            
                        }
                        
                        if(errorText){
                            Text("You need to add a title, an icon and at least one question form")
                                .font(.custom("ChalkboardSE-Light", size: 15))
                                .foregroundColor(Color("background"))
                        }
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
    }
    
    func addNewTaskContainText(){
        let contain = TaskContain(context: viewContext)
        contain.isText = true
        contains.append(contain)
        do {
            try viewContext.save()
        }
        catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
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
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func verify() -> Bool {
        if(title == "" || iconForm == ""){
            return false
        }
        if(contains.isEmpty){
            return false
        }
        else {
            return verifyContains()
        }
    }
    
    func verifyContains() -> Bool {
        for contain in contains {
            if(contain.isIcon){
                if(contain.listIcons!.isEmpty){
                    return false
                }
            }
            if(contain.title == nil || contain.title!.isEmpty){
                return false
            }  
        }
        return true
    }
    
    func saveNewTask(){
        let newTask = Task(context: viewContext)
        newTask.title = title
        newTask.color = colorForm
        newTask.icon = iconForm
        newTask.id = counter.first!.id
        counter.first!.id += 1
        
        for contain in contains {
            newTask.addToContains(contain)
        }
        
        do{
            try viewContext.save()
        }
        catch {
            fatalError("Error : \(error)")
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

