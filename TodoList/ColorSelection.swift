//
//  ColorSelection.swift
//  TodoList
//
//  Created by Luca Hodge on 9/17/23.
//

import Foundation
import SwiftUI


let colorList = [Color.gray, Color.green, Color.yellow, Color.orange, Color.red]
//let appColorList = [Color.gray, Color(red: 0.4, green: 0.7, blue: 0.4), Color(red: 0.8, green: 0.8, blue: 0.1), Color(red: 1, green: 0.6, blue: 0.4), Color(red: 0.8, green: 0.4, blue: 0.4)]
let appColorList = [Color(red: 230/255, green: 230/255, blue: 230/255), Color(red: 176/255, green: 255/255, blue: 172/255), Color(red: 251/255, green: 255/255, blue: 127/255), Color(red: 255/255, green: 186/255, blue: 115/255), Color(red: 254/255, green: 102/255, blue: 102/255)]

//145, 255, 0

func appColor(number: Int) -> Color{
    let increment = 4;
    if number == 0 {
        return appColorList[0]
    }
    if number <= increment {
        return appColorList[1]
    }
    if number <= increment*2 {
        return appColorList[2]
    }
    if number <= increment*3 {
        return appColorList[3]
    }
    return appColorList[4]
}

func todoColor(date: Date) -> Color{
    let timeInterval = date.timeIntervalSinceNow
    let days = -timeInterval // / (60 * 60 * 24)
    if days == 0 {
        return colorList[0]
    }
    if days <= 1 {
        return colorList[1]
    }
    if days <= 3 {
        return colorList[2]
    }
    if days <= 7 {
        return colorList[3]
    }
    return colorList[4]
}

func newTodoColor() -> Color{
    colorList[0]
}

//struct ColorSelection{
//}

//extension ColorSelection{
//    let colors = [Color.white, Color.green, Color.yellow, Color.orange, Color.red]
//
//}
