//
//  CalendarView.swift
//  mentalHealth
//
//  Created by Eva Herson on 07/12/2023.
//

import CoreData
import SwiftUI

struct CalendarView: View {
    @ObservedObject var calendar = CalendarCreate(date: Date())

    var body: some View {
        GeometryReader { geo in
                VStack{
                    ScrollView {
                    HStack{
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
                    .padding(.bottom)
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.fixed((geo.size.width-30)/7), spacing: 0, alignment: .center), count: 7), spacing: 0) {
                        ForEach(calendar.dayList) { day in
                            DayView(calendar: calendar, day: day, height: geo.size.height, width: geo.size.width)
                            
                        }
                        
                        
                        
                    }
                    .frame(height: 2*geo.size.height/3)
                    .frame(width: abs(geo.size.width-30))
                    .frame(maxWidth: 1000)
                    .background(Color(red: 0.973, green: 0.988, blue: 1))
                    .border(Color("background"),width: 1)
                    .cornerRadius(20)
                    
                    
                    
                    
                    .padding(.leading, 15)
                    .padding(.trailing, 15)
                    
                    
                    Spacer()
                    
                    DayTaskView(calendar: calendar, height: geo.size.height, width: geo.size.width)
                    
                    
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
    CalendarView()
}
