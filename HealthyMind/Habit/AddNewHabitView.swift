//
//  AddNewHabitView.swift
//  HealthyMind
//
//  Created by Eva Herson on 08/01/2024.
//

import SwiftUI
import CoreData

struct AddNewHabitView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var title = ""
    @State var colorForm = "task1"
    @State var numberDay = 1
    @State var numberDayString = "1"
    @State var errorText = false
    @Binding var isPresented : Bool
    
    @FetchRequest( sortDescriptors: [], animation: .default)
    private var counter: FetchedResults<CounterId>
    
    
    private let colors : [String] = ["task1","task2","task3","task4","task5"]
    
    var body: some View {
        GeometryReader { geo in
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
                    Text("ADD NEW TASK :")
                        .font(.custom("Ubuntu-Medium", size: 25))
                        .foregroundColor(Color("font"))
                    Spacer()
                    
                }
                ScrollView{
                    VStack{
                        TextField("Name of the habit", text: $title)
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
                        
                        Spacer()
                        
                        HStack{
                            
                            TextField("0", text: $numberDayString)
                                .font(.custom("ChalkboardSE-Light", size: 25))
                                .foregroundColor(Color("background"))
                                .frame(maxWidth: geo.size.width/10)
                                
                            
                            VStack{
                                Spacer()
                                Button{
                                    addNumberDay(i : 1)
                                } label:{
                                    
                                    Image(systemName: "arrowtriangle.up.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(Color("background"))
                                }
                                
                                Button{
                                    addNumberDay(i : -1)
                                } label: {
                                    Image(systemName: "arrowtriangle.down.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(Color("background"))
                                }
                            }
                            .frame(height: 60)
                            
                            
                            Spacer()
                        }
                        
                        .padding(30)
                        
                        Button {
                            if(verify()){
                                addNewHabit()
                                isPresented = false
                            }
                        } label:{
                            Text("ADD NEW HABIT")
                                .font(.custom("ChalkboardSE-Light", size: 17))
                                .foregroundColor(Color("font"))
                                .padding(15)
                                .background(Color("background"))
                                .cornerRadius(10)
                            
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
    
    func addNumberDay(i : Int){
        if(numberDay + i > 0){
            numberDay += i
            numberDayString = String(numberDay)
        }
    }
    
    func verify() -> Bool{
        if let number = Int(numberDayString){
            if(number>0){
                if(title != ""){
                    numberDay = number
                    return true
                }
            }
        }
        return false
    }
    
    func addNewHabit(){
        let newHabit = Habit(context: viewContext)
        newHabit.title = title
        newHabit.color = colorForm
        newHabit.numberNow = Int64(numberDay)
        newHabit.numberDay = Int64(numberDay)
        newHabit.id = counter.first!.idHabits
        counter.first!.idHabits += 1
        
        do{
            try viewContext.save()
        }
        catch {
            fatalError("Error : \(error)")
        }
    }
    
}
    

