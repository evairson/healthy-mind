//
//  SettingsView.swift
//  HealthyMind
//
//  Created by Eva Herson on 31/01/2024.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest( sortDescriptors: [], animation: .default)
    private var infoUser: FetchedResults<InfoUser>
    
    @State var isOn = false
    var body: some View {
        NavigationView {
            List {
                
                Section {
                    Toggle(isOn: $isOn) {
                        Text("Accept Notification")
                    }
                    .listRowBackground(Color("background"))
                    if(isOn){
                        NavigationLink(destination: Text("ok")){
                            Text("When do you want to have the notification ?")
                        }
                        .listRowBackground(Color("background"))
                    }
                    
                } header: {
                    Text("Notification")
                }
                
                Section {
                    Button {
                        tuto()
                        
                    } label: {
                        Text("Restart Tutoriel")
                            .foregroundColor(.black)
                    }
                    .listRowBackground(Color("background"))
                    NavigationLink(destination: Text("ok")){
                        Text("About")
                    }
                    .listRowBackground(Color("background"))
                    NavigationLink(destination: Text("ok")){
                        Text("Terms of Use")
                    }
                    .listRowBackground(Color("background"))
                    NavigationLink(destination: Text("ok")){
                        Text("Privacy Policy")
                    }
                    .listRowBackground(Color("background"))
                    NavigationLink(destination: Text("ok")){
                        Text("License")
                    }
                    .listRowBackground(Color("background"))
                    HStack{
                        Text("Version")
                        Spacer()
                        Text("1.0.0")
                    }
                    .listRowBackground(Color("background"))
                    
                } header: {
                    Text("About")
                }
                Button {
                    
                } label: {
                    Text("réinitialiser")
                        .foregroundColor(Color("font2"))
                }
                .listRowBackground(Color("background"))
                Button {
                    
                } label: {
                    Text("réinitialiser formulaire")
                        .foregroundColor(Color("font2"))
                }
                .listRowBackground(Color("background"))
            }
            .listStyle(.grouped)
            .scrollContentBackground(.hidden)
            .background(Color("background"))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
    }
    
    private func tuto(){
        infoUser.first!.tuto = true
        do {
            
            try viewContext.save()
        }
        catch {
        fatalError("Error : \(error)")
        }
    }
}

#Preview {
    SettingsView()
}
