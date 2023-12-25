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
    @State private var isModifyImage = false
    @State private var isModifyText = false
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
                                )) {
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
                    
                    VStack{
                        Button{
                            isModifyImage = true
                        } label:{
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: geo.size.width/12)
                                .foregroundColor(Color("font2"))
                        }
                        .sheet(isPresented: Binding<Bool>(
                            get: { isModifyImage },
                            set: { isModifyImage = $0 }
                        )) {
                            ModifyImageView(isPresented: Binding<Bool>(
                                get: { isModifyImage },
                                set: { isModifyImage = $0 }
                            ))
                            }
                        
                        Button{
                            isModifyText = true
                        } label:{
                            Image(systemName: "square.and.pencil.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: geo.size.width/12)
                                .foregroundColor(Color("font2"))
                        }
                        .sheet(isPresented: Binding<Bool>(
                            get: { isModifyText },
                            set: { isModifyText = $0 }
                        )) {
                            ModifyNameView(isPresented: Binding<Bool>(
                                get: { isModifyText },
                                set: { isModifyText = $0 }
                            ))
                            }
                    }
                    
                    
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
        
}

struct ModifyImageView: View {
    @Binding var isPresented: Bool
    var body: some View {
        Button{
            isPresented = false
        } label: {
            Image(systemName: "xmark.circle")
                .foregroundColor(Color("background"))
        }
    }
}

struct ModifyNameView: View {
    @Binding var isPresented: Bool
    var body: some View {
        VStack{
            HStack{
                Button{
                    isPresented = false
                } label: {
                    Image(systemName: "xmark.circle")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color("font"))
                        
                        
                }
                .frame(maxWidth: 30)
                Spacer()
            }
            .padding(20)
            Spacer()
            
        }
        
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("background"))
    }
}

#Preview {
    AddView()
}
