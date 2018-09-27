//
//  main.swift
//  1l_Rybalkin_Vadim.playground
//
//  Created by Вадим Рыбалкин on 26/09/2018.
//  Copyright © 2018 Вадим Рыбалкин. All rights reserved.
//

import Foundation

/************************************
 ****Решить квадратное уравнение.****
************************************/
func quadratic( a:Double, b:Double, c:Double)-> (dis:Double, x1:Double?, x2:Double?) {
    let dis = pow(b, 2) - 4 * a * c
    let x1:Double? = dis>=0 ? (-b + sqrt(dis))/(2*a): nil
    let x2:Double? = dis>0 ? (-b - sqrt(dis))/(2*a): nil
    return(dis:dis,x1:x1,x2:x2)
}
func printT1Result(a:Double, b:Double, c:Double, dis:Double, x1:Double?, x2:Double?){
    let formatedA:String = String(format: "%.2f", arguments: [a])
    let formatedB:String = String(format: "%.2f", arguments: [b])
    let formatedC:String = String(format: "%.2f", arguments: [c])
    let quadraticMessage:String = "Уравнение: "+formatedA+"x² + "+formatedB+"x + "+formatedC+" = 0"
    let disMessage:String = "Дискриминант: " + String(format: "%.2f", arguments: [dis])
    print(quadraticMessage)
    print(disMessage)
    if(x1 != nil){
        print("x1: " + String(format: "%.2f", arguments: [x1!])  )
    }else{
        print ("Нет корней")
        return
    }
    if(x2 != nil){
        print("x2: " + String(format: "%.2f", arguments: [x2!])  )
    }
}
//test task one
//check quadratic with negative discriminant
let unsolvable = quadratic(a:-1, b:-1, c:-1)
print("проверка нерешаемого квадратного уравнения")
printT1Result(a: -1, b: -1, c: -1, dis: unsolvable.dis, x1: unsolvable.x1, x2: unsolvable.x2)
print()
//check quadratic with zero discriminant
let zero = quadratic(a:1, b:2, c:1)
print("проверка квадратного уравнения c дискриминантом равным нулю")
printT1Result(a: 1, b: 2, c: 1, dis: zero.dis, x1: zero.x1, x2: zero.x2)
print()
//check quadratic with positive discriminant
let positive = quadratic(a:4.88, b:-8.64, c:-21.66)
print("проверка квадратного уравнения c дискриминантом больше нуля")
printT1Result(a: 4.88, b: -8.64, c: -21.66, dis: positive.dis, x1: positive.x1, x2: positive.x2)
print()
//random checks
print("10 псевдослучайных уравнений")
print()
for i in 1...10{
    let a:Double = round(Double.random(in: -25...25)/0.01)*0.01
    let b:Double = round(Double.random(in: -25...25)/0.01)*0.01
    let c:Double = round(Double.random(in: -25...25)/0.01)*0.01
    let result = quadratic( a: a, b: b, c: c)
    print("Уравнение №\(i)")
    printT1Result(a: a, b: b, c: c, dis: result.dis, x1: result.x1, x2: result.x2)
    print()
    print()
}
/************************/

