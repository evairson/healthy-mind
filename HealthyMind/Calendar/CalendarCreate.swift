//
//  CalendarCreate.swift
//  mentalHealth
//
//  Created by Eva Herson on 07/12/2023.
//

import SwiftUI

class CalendarCreate : ObservableObject {
    
    static let monthThirty = [4,6,9,11]
    

    @Published var daySelected : Day
    @Published var monthSelected : Int
    @Published var yearSelected : Int
    @Published var weekdaySelected : Int
    @Published var dayDaySelected : Int
    @Published var dateSelected : Date
    @Published var dayList : [Day]
    
    init(date: Date) {

        self.daySelected = Day(date: date)
        
        self.dateSelected = date
        
        self.monthSelected = date.getMonth()
        self.weekdaySelected = date.getWeekDay()
        self.yearSelected = date.getYear()
        self.dayDaySelected = date.getDay()
        
        self.dayList = []

        
        self.daySelected.isSelected = true
        
        GenerateDayList()
        
    }
    
     func change(newdate: Date){
         self.daySelected = Day(date: newdate)
         self.daySelected.isSelected = true
         
         
         self.dateSelected = daySelected.date
         self.monthSelected = daySelected.date.getMonth()
         self.weekdaySelected = daySelected.date.getWeekDay()
         self.yearSelected = daySelected.date.getYear()
         self.dayDaySelected = daySelected.date.getDay()
         self.dayList = []
         GenerateDayList()
    }
    
    static func numberDaysinMonth(date : Date) -> Int{
        var numberDaysinMonth = monthThirty.contains(date.getMonth()) ? 30 : 31
        if(date.getMonth()==2) {
            if(date.getYear()%4==0){
                if(date.getYear()%100==0){
                    if(date.getYear()%400==0){
                         numberDaysinMonth = 29
                    }
                    else {
                        numberDaysinMonth = 28
                    }
                }
                else {
                    numberDaysinMonth = 29
                }
            }
            else {
                numberDaysinMonth = 28
            }
        }
        return numberDaysinMonth
    }
    
    func GenerateDayList(){
        let dayOne = Date.from(month: monthSelected, day: 1, year: yearSelected).getWeekDay()
       if(!(dayOne==1)){
           let monthbefore = monthSelected == 1 ? 12 : monthSelected-1
           let yearOfMonthbefore = monthSelected == 1 ? yearSelected-1 : yearSelected
           let numberDaysMonthBefore = CalendarCreate.numberDaysinMonth(date : Date.from(month: monthbefore, day: 1, year: yearOfMonthbefore))
           let monday = numberDaysMonthBefore  - dayOne + 2
            for i in monday...numberDaysMonthBefore {
                let day = Day(date: Date.from(month: monthbefore, day: i, year: yearOfMonthbefore))
                day.notInMonth = true
                dayList.append(day)
            }
        }
        for i in 1...CalendarCreate.numberDaysinMonth(date: dateSelected) {
            let day = Day(date: Date.from(month: monthSelected, day: i, year: yearSelected))
            if(i==self.dayDaySelected){
                dayList.append(daySelected)
            }
            else {
                dayList.append(day)
            }
        }
        let dayLast = Date.from(month: monthSelected, day: CalendarCreate.numberDaysinMonth(date: dateSelected), year: yearSelected).getWeekDay()
        if(!(dayLast==7)){
            let monthAfter = monthSelected == 12 ? 1 : monthSelected+1
            let yearOfMonthAfter = monthSelected == 12 ? yearSelected+1 : yearSelected
            let sunday = 7 - dayLast
            for i in 1...sunday{
                let day = Day(date: Date.from(month: monthAfter, day: i, year: yearOfMonthAfter))
                day.notInMonth = true
                dayList.append(day)
            }
        }
    }
    
    func MonthToString()-> String{
        switch(monthSelected){
            case 1 : return "January"
            case 2 : return "February"
            case 3 : return "March"
            case 4 : return "April"
            case 5 : return "May"
            case 6 : return "June"
            case 7 : return "July"
            case 8 : return "August"
            case 9 : return "September"
            case 10 : return "October"
            case 11 : return "November"
        default : return "December"
            
        }
    }
    
}

class Day : Identifiable, ObservableObject {
    @Published var date : Date
    @Published var isSelected = false
    @Published var notInMonth = false
    init(date: Date) {
        self.date = date
    }
}

extension Date {
    
    static func from(month: Int, day: Int, year: Int) -> Date {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        
        let calendar = Calendar(identifier: .gregorian)
        
        if let date = calendar.date(from: dateComponents) {
            return date
        } else {
            return Date.now
        }
    }
    
    func getMonth() -> Int {
        let calendar = Calendar(identifier: .gregorian)
        return calendar.component(.month, from: self)
    }
    
    func getDay() -> Int {
        let calendar = Calendar(identifier: .gregorian)
        return calendar.component(.day, from: self)
    }
    
    func getWeekDay() -> Int{
        let calendar = Calendar(identifier: .gregorian)
        return calendar.component(.weekday, from: self)
    }
    
    func getYear() -> Int{
        let calendar = Calendar(identifier: .gregorian)
        return calendar.component(.year, from: self)
    }
    
    func isDate(date : Date) -> Bool {
        if(self.getDay() == date.getDay() && self.getMonth() == date.getMonth() && self.getYear() == date.getYear()){
            return true
        }
        return false
    }
}
