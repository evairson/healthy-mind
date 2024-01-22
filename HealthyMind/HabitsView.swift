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

    
    var body: some View {
        GeometryReader { geo in
            VStack{
                HStack{
                    Spacer()
                    Text("YOUR HABITS")
                        .font(.custom("Ubuntu-Medium", size: 25))
                        .foregroundColor(Color("font"))
                    Spacer()
                    Button{
                        isAddNewHabit = true
                    } label:{
                        Image(systemName: "plus")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: geo.size.width/15)
                            .foregroundColor(Color("font"))
                    }
                    .padding(.trailing)
                    .sheet(isPresented: $isAddNewHabit) {
                        AddNewHabitView(isPresented: $isAddNewHabit)
                    }
                }
                .padding()
                
                ForEach(habits) { habit in
                    if(habit.numberNow > 0){
                        Button {
                            do {
                                habit.numberNow -= 1
                                try viewContext.save()
                            } catch {
                                fatalError("Error : \(error)")
                            }
                        } label: {
                            
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
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(habit.color ?? "font2"))
                        .cornerRadius(10)
                        .padding([.leading, .trailing])
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
}

#Preview {
    HabitsView()
}
