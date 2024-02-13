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
                Group {
                    Section {
                        Toggle(isOn: $isOn) {
                            Text("Accept Notification")
                        }
                        if(isOn){
                            NavigationLink(destination: Text("ok")){
                                Text("When do you want to have the notification ?")
                            }
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
                        NavigationLink(destination: AboutView()){
                            Text("About")
                        }
                        NavigationLink(destination: TermsOfUseView()){
                            Text("Terms of Use")
                        }
                        NavigationLink(destination: CreditView()){
                            Text("Credit")
                        }
                        HStack{
                            Text("Version")
                            Spacer()
                            Text("1.0.1")
                        }
                        
                    } header: {
                        Text("About")
                    }
                    Button {
                        
                    } label: {
                        Text("Reset")
                            .foregroundColor(Color("font2"))
                    }
                }
                
                .listRowBackground(Color("background2"))
                
            }
            .listStyle(.grouped)
            .scrollContentBackground(.hidden)
            .background(Color("background2"))
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
