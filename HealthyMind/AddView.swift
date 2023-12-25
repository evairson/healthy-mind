//
//  AddView.swift
//  mentalHealth
//
//  Created by Eva Herson on 08/12/2023.
//

import SwiftUI
import CoreData

struct AddView: View {
    
    @State private var isTaskOpen : [Int64 : Bool] = [:]
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Task.id, ascending: true)],
        animation: .default)
    private var tasks: FetchedResults<Task>



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
                Spacer()
                HStack{
                    ScrollView(.horizontal){

                        LazyHGrid(rows: [GridItem(.fixed(geo.size.height/5), spacing: 10),GridItem(.fixed(geo.size.height/5))], spacing: 10) {
                            
                            
                            ForEach(tasks) { task in
                                
                                    Button {
                                        isTaskOpen[task.id] = true
                                    } label: {
                                        VStack{
                                            Text("\(task.title ?? "No Title")")
                                                .font(.custom("HiraMaruProN-W4", size: 22))
                                                .foregroundColor(Color("background"))
                                            Image(task.icon ?? "taskImage1")
                                                .resizable()
                                                .scaledToFit()
                                        }
                                        
                                    }
                                    
                                    .padding()
                                    .frame(width: (2*geo.size.width/7), height: geo.size.height/5)
                                    .background(Color(task.color!))
                                    .cornerRadius(20)
                                    
                                
                                .sheet(isPresented: Binding<Bool>(
                                    get: { isTaskOpen[task.id] ?? false },
                                    set: { isTaskOpen[task.id] = $0 }
                                ),  onDismiss: didDismiss) {
                                    TaskView(task: task, presented: Binding<Bool>(
                                        get: { isTaskOpen[task.id] ?? false },
                                        set: { isTaskOpen[task.id] = $0 }
                                    ))
                                    }
                                
                                
                            
                            }
                            Button{
                                
                            } label: {
                                Image(systemName: "plus")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(Color("font2"))
                            }
                                .frame(maxWidth: (geo.size.width/5), maxHeight: geo.size.height/5)
                        }
                    }
                    .padding(2)
                }
                
                
                Spacer()
                
                HStack{
                    Spacer()
                    VStack{
                        
                        Image("avatar1")
                            .resizable()
                            .scaledToFit()
                        Text("Prenom Nom")
                            .font(.custom("futura-bold", size: 25))
                    }
                    .frame(height: 2*geo.size.height/5)
                    .foregroundColor(Color("font"))
                    Spacer()
                    
                }
            }
            .padding()
            .background(Color("background"))
            
        }
        .onAppear {
                if isTaskOpen.isEmpty {
                    for task in tasks {
                        isTaskOpen[task.id] = false
                    }
                }
            
            }
    }
    
    func didDismiss() {
        
    }
    

        
}

#Preview {
    AddView()
}
