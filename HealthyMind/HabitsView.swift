//
//  HabitsView.swift
//  HealthyMind
//
//  Created by Eva Herson on 02/01/2024.
//

import SwiftUI

struct HabitsView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Habit.id, ascending: true)],
        animation: .default)
    private var habits: FetchedResults<Habit>
    
    @FetchRequest( sortDescriptors: [], animation: .default)
    var counter: FetchedResults<CounterId>
    
    @State var isAddNewHabit = false;
    @State var trashMode = false

    
    var body: some View {
        GeometryReader { geo in
            VStack{
                HStack{
                    Button{
                        isAddNewHabit = true
                    } label:{
                        Image(systemName: "plus")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: geo.size.width/15)
                            .foregroundColor(Color("font"))
                    }
                    .padding(.leading)
                    .sheet(isPresented: $isAddNewHabit) {
                        AddNewHabitView(isPresented: $isAddNewHabit)
                    }
                    
                    Spacer()
                    Text("YOUR HABITS")
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
                .padding()
                
                if(noHabit()){
                    Text("You already did all your habits today. Come back tomorrow or add new habits")
                        .font(.custom("ChalkboardSE-Light", size: 18))
                        .padding(20)
                }
                
                ForEach(habits) { habit in
                    if(habit.numberNow > 0){
                        habitView(habit: habit, width: geo.size.width, trashMode: $trashMode)
                    }
                    
                }
                
                
                Spacer()
            }
            .background(Color("background"))
            .onAppear {
                if(counter.first != nil){
                    if(counter.first!.taskDay!.getMonth() != Date().getMonth() || counter.first!.taskDay!.getYear() != Date().getYear() ||
                       counter.first!.taskDay!.getDay() != Date().getDay()){
                        for habit in habits {
                            habit.numberNow = habit.numberDay
                        }
                        counter.first!.taskDay = Date()
                        do {try viewContext.save()}
                        catch {fatalError("Error : \(error)")}
                    }
                }
            }
        }
    }
    
    func noHabit() -> Bool {
        if(habits.isEmpty){
            return true
        }
        for habit in habits {
            if(habit.numberNow > 0){
                return false
            }
        }
        return true
    }
}

struct habitView : View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var habit : Habit
    @State var width: Double
    @Binding var trashMode : Bool
    
    var body: some View {
            
        
            Button {
                if(trashMode){
                    deleteHabit()
                }
                else {
                    habit.numberNow -= 1
                }
                do {
                    try viewContext.save()
                } catch {
                    fatalError("Error : \(error)")
                }
            } label: {
                ZStack{
                    
                    if(trashMode){
                         Image(systemName: "trash")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(Color("background"))
                            .frame(maxWidth: width/12)
                    }
                    
                    HStack {
                        Text(habit.title ?? "No title")
                            .font(.custom("ChalkboardSE-Light", size: 25))
                            .foregroundColor(Color("background"))
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                        Spacer()
                        Text("\(habit.numberNow)")
                            .font(.custom("ChalkboardSE-Light", size: 25))
                            .foregroundColor(Color("background"))
                    }
                    
                }
                
                
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color(habit.color ?? "font2").opacity(trashMode ? 0.5 : 1.0))
            .cornerRadius(10)
            .padding([.leading, .trailing])
        
    }
    
    func deleteHabit(){
        withAnimation {
            viewContext.delete(habit)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}


#Preview {
    HabitsView()
}
