//
//  TaskView.swift
//  mentalHealth
//
//  Created by Eva Herson on 09/12/2023.
//

import SwiftUI

struct TaskView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var task : Task
    var containsArray : [TaskContain]
    @State var empty = false
    @Binding var isPresented: Bool


    var body: some View {
        GeometryReader { geo in
            VStack{
                
                HStack{
                    Spacer()
                    Text("ADD ABOUT YOU")
                        .font(.custom("Ubuntu-Medium", size: 25))
                        .foregroundColor(Color("font"))
                    Spacer()
                }
                VStack{
                    ScrollView {
                        HStack{
                            VStack{
                                Button {
                                    isPresented = false
                                } label: {
                                    Image(systemName: "xmark.circle")
                                        .foregroundColor(Color("background"))
                                }
                                Spacer()
                            }

                            Spacer()
                            Text("\(task.title ?? "No title")")
                                .textCase(.uppercase)
                                .font(.custom("ChalkboardSE-Light", size: 25))
                                .foregroundColor(Color("background"))
                                .padding(.bottom)
                            
                            Spacer()
                        }
                        
                            ForEach(containsArray, id: \.self) { contain in
                                HStack{
                                    Text("\(contain.title ?? "No title" )")
                                        .textCase(.uppercase)
                                        .font(.custom("ChalkboardSE-Light", size: 25))
                                        .foregroundColor(Color("background"))
                                        .multilineTextAlignment(.leading)
                                        .fixedSize(horizontal: false, vertical: true)
                                    Spacer()
                                }
                                
                                
                                if contain.isText {
                                    TextField("", text: Binding(
                                        get: { contain.textAnswer ?? "" },
                                        set: { newText in
                                            contain.textAnswer = newText }))
                                        .padding()
                                        .font(.custom("ChalkboardSE-Light", size: 20))
                                        .background(Color("background"))
                                        .foregroundColor(Color("font"))
                                        .cornerRadius(10)
                                        .padding(.bottom)
                                }
                                
                                
                                if contain.isIcon {
                                    ListIconView(contain: contain, width: 50)
                                    
                                }
                                
                            }
                            Spacer()
                        
                        Button {
                            if FormVerify() {
                                empty = false
                                addItem()
                                resetTask()
                                isPresented = false
                                
                            }
                            else {
                                empty = true
                            }
                        } label: {
                            Text("ADD FORM")
                                .foregroundColor(Color("font"))
                                .font(.custom("Ubuntu-Medium", size: 20))
                                .padding()
                                .background(Color("background"))
                                .cornerRadius(10)
                        }
                        
                        if empty {
                            Text("You didn't answer all the question")
                                .foregroundColor(Color("background"))
                        }
                    }
                  
                }
                .padding(25)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(task.color!))
                .cornerRadius(20)
                
            }
            .padding()
            .background(Color("background"))
            
        }
    }
    
    init(task: Task, presented : Binding<Bool>) {
        self._isPresented = presented
        self.task = task
        
        if let containsSet = task.contains as? Set<TaskContain> {
            containsArray = Array(containsSet).sorted { $0.num < $1.num }
        } else {
            containsArray = []
        }
        
        
        
    }
    
    private func addItem() {
        withAnimation {
            let newTaskAnwer = Answer(context: viewContext)
            newTaskAnwer.day = Int64(Date().getDay())
            newTaskAnwer.month = Int64(Date().getMonth())
            newTaskAnwer.year = Int64(Date().getYear())
            newTaskAnwer.title = task.title
            newTaskAnwer.color = task.color
            newTaskAnwer.icon = task.icon
            for contain in task.contains! {
                if let taskContain = contain as? TaskContain {
                    newTaskAnwer.addToContains(taskContain.copy(context: viewContext))
                } else {
                    print("error : Contain isn't a TaskContain")
                }
            }

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func FormVerify() -> Bool {
        if !containsArray.isEmpty {
            for contain in containsArray {
                if(contain.isText && contain.textAnswer == nil || contain.textAnswer == ""){
                    return false
                }
                if(contain.isIcon && contain.iconAnswer == nil){
                    return false
                }
            }
            return true
        }
        return false
    }
    
    private func resetTask(){
        for contain in containsArray {
            contain.textAnswer = nil
            contain.iconAnswer = nil
        }
        do {
            
            try viewContext.save()
        } catch {
        let nsError = error as NSError
        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
    }
}

struct ListIconView: View  {
    @ObservedObject var contain : TaskContain
    var width : Double
    var icons : [Int]
    
    init(contain: TaskContain, width: Double){
        self.contain = contain
        self.width = width
        icons = contain.icons!.icon!
    }
    
    
    
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(minimum: 20, maximum: width), spacing: 5, alignment: .center), count: 4)) {
            ForEach(icons, id: \.self) { icon in
                    Button {
                        contain.iconAnswer = "humeur\(icon)"
                    } label: {
                        Image(contain.iconAnswer == "humeur\(icon)" ? ("humeur\(icon)" + "N") : "humeur\(icon)")
                            .resizable()
                            .scaledToFit()
                    }
                }
        }
    }
}

