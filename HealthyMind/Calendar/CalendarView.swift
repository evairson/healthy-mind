//
//  CalendarView.swift
//  mentalHealth
//
//  Created by Eva Herson on 07/12/2023.
//

import CoreData
import SwiftUI

struct CalendarView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var calendar = CalendarCreate(date: Date())
    @State var calendarMode : Int
    @State var habitSelected : Habit?

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Habit.id, ascending: true)],
        animation: .default)
    private var habits: FetchedResults<Habit>
    
    var body: some View {
        GeometryReader { geo in
                VStack{
                    ScrollView {
                    HStack {
                        Spacer()
                        Button{
                            calendar.change(newdate: Date.from(month: calendar.monthSelected == 1 ? 12 : calendar.monthSelected-1, day: 1, year: calendar.monthSelected == 1 ? calendar.yearSelected-1 : calendar.yearSelected))
                        } label: {
                            Image(systemName: "arrowtriangle.backward.fill")
                                .foregroundColor(Color("font"))
                        }
                        Spacer()
                        
                            Text("\(calendar.MonthToString()) \(calendar.yearSelected)")
                            
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundColor(Color("font"))

                        
                        Spacer()
                        Button{
                            calendar.change(newdate: Date.from(month: calendar.monthSelected == 12 ? 1 : calendar.monthSelected+1, day: 1, year: calendar.monthSelected == 12 ? calendar.yearSelected+1 : calendar.yearSelected))
                        } label: {
                            Image(systemName: "arrowtriangle.forward.fill")
                                .foregroundColor(Color("font"))
                        }
                        Spacer()
                    }
                    .padding(.top)
                        
                        HStack {
                            if(!calendar.dateSelected.isDate(date: Date())){
                                Button {
                                    calendar.change(newdate: Date())
                                } label: {
                                    Text("Today")
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color("font2"))
                                        .underline()
                                        .padding(.leading, 30)
                                }
                            }
                            Spacer()
                            Menu {
                                Button {
                                    calendarMode = 0
                                    habitSelected = nil
                                } label: {
                                    Label("Form", image: "taskImage1")
                                }
                                ForEach(habits) { habit in
                                    Button {
                                        calendarMode = 1
                                        habitSelected = habit
                                    } label: {
                                        Text(habit.title!)
                                            .background(Color(habit.color ?? "task1"))
                                    }
                                }
                                        
                            } label: {
                                HStack{
                                    Text((calendarMode == 0 || habitSelected?.title == nil) ? "Form" : "\(habitSelected!.title!)")
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color("font2"))
                                    Image(systemName: "arrowtriangle.down.fill")
                                        .foregroundColor(Color("font2"))
                                }
                            }
                            
                            Spacer()
                            if(!calendar.dateSelected.isDate(date: Date())){
                                Spacer()
                            }
                        }
                        
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.fixed((geo.size.width-30)/7), spacing: 0, alignment: .center), count: 7), spacing: 0) {
                        ForEach(calendar.dayList) { day in
                            if(calendarMode == 0 || habitSelected?.title == nil){
                                DayView(calendar: calendar, day: day, height: geo.size.height, width: geo.size.width)
                            }
                            else {
                                DayHabitView(calendar: calendar, day: day, habit: habitSelected!, height: geo.size.height, width: geo.size.width)
                            }
                        }
                        
                        
                        
                    }
                    .frame(height: 2*geo.size.height/3)
                    .frame(width: abs(geo.size.width-30))
                    .frame(maxWidth: 1000)
                    .background(Color(red: 0.973, green: 0.988, blue: 1))
                    .border(Color("background"),width: 1)
                    .cornerRadius(20)
                    .shadow(color: Color("background2"),radius: 5)
                    .padding([.leading, .trailing], 15)
                    
                    
                    Spacer()
                        
                    
                    if(calendarMode == 0 || habitSelected?.title == nil){
                        DayTaskView(calendar: calendar, height: geo.size.height, width: geo.size.width)
                    }
                    
                    
                    
                }
            }
                .background(Color("background"))
        }
    }
}

struct DayTaskView : View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var calendar: CalendarCreate
    @State var height: Double
    @State var width: Double
  
    @FetchRequest var results: FetchedResults<Answer>
    
    init(calendar: CalendarCreate, height: Double, width: Double) {
        self.calendar = calendar
        let day = calendar.daySelected
        self._height = State(initialValue: height)
        self._width = State(initialValue: width)
        

       let predicate = NSPredicate(format: "month == %i AND year == %i AND day == %i", day.date.getMonth(), day.date.getYear(), day.date.getDay())



        self._results = FetchRequest(sortDescriptors: [], predicate: predicate)
    }
    
    var body: some View {
        
        VStack {
            ForEach(results){ answer in
                contentDayTaskView(answer: answer, height: height, width: width)
            }
            }
    }
    
}

struct contentDayTaskView : View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var answer : Answer
    @State var height: Double
    @State var width: Double
    @State var pos = CGSize.zero
    
    var body: some View {
        ZStack {
            HStack {
                Spacer()
                VStack{
                    Spacer()
                    Image(systemName: "trash.fill")
                        .foregroundColor(Color("background"))
                    Text("DELETE")
                        .foregroundColor(Color("background"))
                    Spacer()
                    
                }
                
                .padding()
            }
            .padding()
            
            .frame(maxWidth: .infinity)
            
            .background(Color(answer.color ?? "task1").opacity(0.5))
            .cornerRadius(20)
            .padding([.leading, .top, .trailing])
            
            
            HStack{
                VStack{
                    Text(answer.title ?? "no title")
                        .textCase(.uppercase)
                        .font(.custom("ChalkboardSE-Light", size: 15))
                        .foregroundColor(Color("background"))
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                    Image(answer.icon ?? "taskImage1")
                        .resizable()
                        .scaledToFit()
                    Spacer()
                }
                .frame(maxWidth: width/6)
                
                VStack{
                    DayTaskContainView(taskAnswer: answer, height: height, width: width)
                }
                .padding(.leading)
                
            }
            .padding()
            
            .frame(maxWidth: .infinity)
            
            .background(Color(answer.color ?? "task1"))
            .cornerRadius(20)
            .padding([.leading, .top, .trailing])
            .offset(x: pos.width)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        if gesture.translation.width < 0 {
                            pos = gesture.translation
                        }
                    }
                    .onEnded { _ in
                        if pos.width < -width/3 {
                            deleteAnswer()
                        }
                        pos = .zero
                    }
            )
        }
    }
    
    func deleteAnswer(){
        withAnimation {
            viewContext.delete(answer)

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

struct DayTaskContainView : View {
    
    @ObservedObject var taskAnswer : Answer
    var containsArray : [TaskContain]
    @State var height: Double
    @State var width: Double
    
    init(taskAnswer: Answer, height: Double, width: Double) {
        self.taskAnswer = taskAnswer
        self._height = State(initialValue: height)
        self._width = State(initialValue: width)
        
        if let containsSet = taskAnswer.contains as? Set<TaskContain> {
            containsArray = Array(containsSet).sorted { $0.num < $1.num }
        } else {
            containsArray = []
        }
    }
    
    var body: some View {
        ForEach(containsArray){ contain in
            if(contain.isIcon){
                HStack{
                    Text("\(contain.title!)")
                        .textCase(.uppercase)
                        .font(.custom("ChalkboardSE-Light", size: 15))
                        .foregroundColor(Color("background"))
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Image("\(contain.iconAnswer ?? "")")
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: width/10)

                    Spacer()
                }
            }
            
            if(contain.isText){
                HStack{
                    Text("\(contain.title!)")
                        .textCase(.uppercase)
                        .font(.custom("ChalkboardSE-Light", size: 15))
                        .foregroundColor(Color("background"))
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer()
                }
                HStack{
                    Text("\(contain.textAnswer ?? "nothing")")
                        .font(.custom("ChalkboardSE-Light", size: 15))
                        .foregroundColor(Color("background"))
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer()
                    
                }
                .padding(.leading, 20)
                
                Spacer()
            }
        
        }
    }
}

struct DayHabitView : View {
    @ObservedObject var habit : Habit
    @ObservedObject var calendar: CalendarCreate
    @State var height: Double
    @State var width: Double
    
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var day: Day
    @FetchRequest var result: FetchedResults<HabitHistory>
    


    init(calendar : CalendarCreate, day : Day, habit : Habit, height: Double, width: Double) {
        
        self.habit = habit
        self.day = day
        self.calendar = calendar
        self._height = State(initialValue: height)
        self._width = State(initialValue: width)
        
        let predicate = NSPredicate(format: "month == %i AND year == %i AND day == %i AND habit == %@", day.date.getMonth(), day.date.getYear(), day.date.getDay(), habit)


        self._result = FetchRequest(sortDescriptors: [], predicate: predicate)
    }
    
    var body: some View{
        Button {
            calendar.change(newdate: Date.from(month: day.date.getMonth(), day: day.date.getDay(), year: day.date.getYear()))
        } label: {
            
            ZStack{
                VStack{
                    if(result.first?.numberDone != habit.numberDay){
                        Spacer()
                    }
                    Rectangle()
                        .fill(Color(habit.color ?? "task1"))
                        .frame(height: calendar.dayList.count == 42 ? (Double(result.first?.numberDone ?? Int64(0.0) )*height)/(9*Double(habit.numberDay)) : (Double(result.first?.numberDone ?? Int64(0.0) )*2*height)/(15*Double(habit.numberDay)))
                        .frame(maxWidth: .infinity)
                }
                
                VStack(){
                    HStack(){
                        Text("\(day.date.getDay())")
                            .font(.system(size: 12, weight: .regular, design: .rounded))
                            .foregroundColor(day.notInMonth ? Color("font").opacity(0.5) : Color("font"))
                        Spacer()
                        }
                        .padding(.init(top: 8, leading: 8, bottom: 0, trailing: 8))
                        Spacer()
                    }
                    
                
            }
        }
        .frame(height: calendar.dayList.count == 42 ?  height/9 : 2*height/15)
        .frame(width: (width-30)/7)
        .border(Color("font"), width : day.isSelected ? 3 : 1)
        
    }
        
}

struct DayView : View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var calendar: CalendarCreate
    @ObservedObject var day: Day
    @State var height: Double
    @State var width: Double
    
    @FetchRequest var results: FetchedResults<Answer>
    


    init(calendar: CalendarCreate, day: Day, height: Double, width: Double) {
        self.calendar = calendar
        self.day = day
        self._height = State(initialValue: height)
        self._width = State(initialValue: width)
        

       let predicate = NSPredicate(format: "month == %i AND year == %i AND day == %i", day.date.getMonth(), day.date.getYear(), day.date.getDay())


        self._results = FetchRequest(sortDescriptors: [], predicate: predicate)
    }
    
    var body: some View {
        Button {
            calendar.change(newdate: Date.from(month: day.date.getMonth(), day: day.date.getDay(), year: day.date.getYear()))
        } label: {
            VStack(){
                HStack(){
                    Text("\(day.date.getDay())")
                        .font(.system(size: 12, weight: .regular, design: .rounded))
                        .foregroundColor(day.notInMonth ? Color("font2").opacity(0.5) : Color("font2"))
                    Spacer()
                }
                .padding(.init(top: 8, leading: 8, bottom: 0, trailing: 8))
                LazyVGrid(columns: [GridItem(.flexible(), spacing: 4), GridItem(.flexible())], spacing: 4) {
                    ForEach(Array(results.prefix(4)), id: \.self){ answer in

                        HStack{
                            Image(answer.icon ?? "taskImage1")
                                .resizable()
                                .scaledToFit()
                        }
                        .padding(2)
                        .background(Color(answer.color ?? "task1"))
                        .cornerRadius(4)
                                
                        
                        
                        
                    }
                }
                .padding([.leading, .trailing], 7)

                Spacer()
            }

           
        }
        .frame(height: calendar.dayList.count == 42 ?  height/9 : 2*height/15)
        .frame(maxWidth: (width-30)/7)
        .border(Color("font2"), width : day.isSelected ? 3 : 1)
    }
    

}


#Preview {
    CalendarView(calendarMode: 0)
}
