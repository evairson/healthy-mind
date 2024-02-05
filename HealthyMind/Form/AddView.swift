//
//  AddView.swift
//  mentalHealth
//
//  Created by Eva Herson on 08/12/2023.
//

import SwiftUI
import CoreData

struct AddView: View {
    @State var tuto = true
    
    @State private var isTaskOpen : [Int64 : Bool] = [:]
    @State private var isModifyImage = false
    @State private var isModifyText = false
    @State private var isAddNewForm = false
    @State var trashMode = false
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Task.id, ascending: true)],
        animation: .default)
    private var tasks: FetchedResults<Task>
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var info: FetchedResults<InfoUser>

    var body: some View {

        GeometryReader { geo in
            VStack{
                
                HStack{
                    Spacer()
                    Spacer()
                    Text("ADD ABOUT YOU")
                        .font(.custom("Ubuntu-Medium", size: 25))
                        .foregroundColor(Color("font"))
                    Spacer()
                    Button{
                        if(trashMode){
                            trashMode = false
                        }
                        else {
                            trashMode = true
                        }
                    } label:{
                        Image(systemName: trashMode ? "checkmark.circle" : "trash")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: geo.size.width/18)
                            .foregroundColor(Color("font"))
                    }
                    .padding(.trailing)
                }
                Spacer()
                HStack{
                    ScrollView(.horizontal){

                        LazyHGrid(rows: [GridItem(.fixed(geo.size.height/5), spacing: 10),GridItem(.fixed(geo.size.height/5))], spacing: 10) {
                            
                            
                            ForEach(tasks) { task in
                                
                                ZStack{
                                    Button {
                                        if(!trashMode){
                                            isTaskOpen[task.id] = true
                                        }
                                        else {
                                            deleteTask(task: task)
                                        }
                                    } label: {
                                        ZStack{
                                            VStack{
                                                Text("\(task.title ?? "No Title")")
                                                    .font(.custom("HiraMaruProN-W4", size: 18))
                                                    .foregroundColor(Color("background"))
                                                Image(task.icon ?? "taskImage1")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .opacity(trashMode ? 0.5 : 1.0)
                                            }
                                            
                                            if(trashMode){
                                                 Image(systemName: "trash")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .foregroundColor(Color("background"))
                                                    .padding()
                                                
                                            }
                                                
                                            
                                        }
                                        
                                        
                                        
                                        
                                    }
                                    
                                    
                                    
                                }
                                    
                                .padding([.top,.leading,.trailing], 10)
                                .frame(width: (2*geo.size.width/7), height: geo.size.height/5)
                                .background(Color(task.color!).opacity(trashMode ? 0.5 : 1.0))
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
                                isAddNewForm = true
                            } label: {
                                Image(systemName: "plus")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(Color("font2"))
                            }
                                .frame(maxWidth: (geo.size.width/5), maxHeight: geo.size.height/5)
                                .sheet(isPresented: $isAddNewForm) {
                                    AddNewTaskView(isPresented: $isAddNewForm)
                                }
                        }
                    }
                    .padding(2)
                }
                
                
                Spacer()
                
                HStack{
                    Spacer()
                    Spacer()
                    VStack{
                        
                        Image("avatar\(info.first?.avatar ?? 1)")
                            .resizable()
                            .scaledToFit()
                        Text("\(info.first?.foreName ?? "Forname") \(info.first?.lastName ?? "Last Name")")
                        
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
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
                        .sheet(isPresented: $isModifyImage) {
                            ModifyImageView(isPresented: $isModifyImage)
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
                        .sheet(isPresented: $isModifyText) {
                            ModifyNameView(isPresented: $isModifyText)
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
    
    func deleteTask(task : Task){
        withAnimation {
            viewContext.delete(task)

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
        
}

struct ModifyImageView: View {
    @Binding var isPresented: Bool
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var info: FetchedResults<InfoUser>
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
            
            ScrollView {
                Text("Choose your avatar :")
                    .font(.custom("futura-bold", size: 25))
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .foregroundColor(Color("font"))
                
                Spacer()
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]) {
                    ForEach(Array(1...(info.first?.avatarList ?? 12)), id: \.self){ avatar in
                        Button{
                            changeAvatar(newAvatar: avatar)
                            isPresented = false
                        } label: {
                            Image("avatar\(avatar)")
                                .resizable()
                                .scaledToFit()
                        }
                    }
                }
                .padding()
            }

        }
        .background(Color("background"))
        
    }
    
    func changeAvatar(newAvatar : Int64){
        info.first?.avatar = newAvatar
        do{
            try viewContext.save()
        }
        catch {
            fatalError("Error : \(error)")
        }
        isPresented = false
    }
}


struct ModifyNameView: View {
    @State var newForName = ""
    @State var newLastName = ""
    @Binding var isPresented: Bool
    
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var info: FetchedResults<InfoUser>

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
            
            
            Text("\(info.first?.foreName ?? "First Name") \(info.first?.lastName ?? "Last Name")")
                .font(.custom("futura-bold", size: 25))
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
                .foregroundColor(Color("font"))
            
            Spacer()
            
            Text("New Name : ")
                .font(.custom("futura-bold", size: 25))
                .foregroundColor(Color("font"))
            
            TextField("First Name", text: Binding(
                get: { newForName },
                set: { newText in
                    newForName = newText }))
            
                .padding()
                .font(.custom("futura-bold", size: 20))
                .background(Color("background2"))
                .foregroundColor(Color("font"))
                .cornerRadius(10)
                .padding()
            
            TextField("Last Name", text: Binding(
                get: { newLastName },
                set: { newText in
                    newLastName = newText }))
                .padding()
                .font(.custom("futura-bold", size: 20))
                .background(Color("background2"))
                .foregroundColor(Color("font"))
                .disableAutocorrection(true)
                .cornerRadius(10)
                .padding()
            
            Button {
                changeName()
            } label: {
                Text("CHANGE")
                    .padding()
                    .font(.custom("futura-bold", size: 20))
                    .background(Color("font2"))
                    .foregroundColor(Color("background"))
                    .disableAutocorrection(true)
                    .cornerRadius(10)
                    .padding()
            }
            
            Spacer()
            
        }
        
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("background"))
    }
    
    func changeName(){
        info.first?.foreName = newForName
        info.first?.lastName = newLastName
        do{
            
            try viewContext.save()
        }
        catch {
            fatalError("Error : \(error)")
        }
        isPresented = false
    }
    

}

#Preview {
    AddView()
}
