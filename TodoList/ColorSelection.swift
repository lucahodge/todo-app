//
//  ColorSelection.swift
//  TodoList
//
//  Created by Luca Hodge on 9/17/23.
//

import Foundation
import SwiftUI


let colorList = [Color.white, Color.green, Color.yellow, Color.orange, Color.red]

func appColor(number: Int) -> Color{
    if number == 0 {
        return colorList[0]
    }
    if number <= 4 {
        return colorList[1]
    }
    if number <= 8 {
        return colorList[2]
    }
    if number <= 12 {
        return colorList[3]
    }
    return colorList[4]
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
