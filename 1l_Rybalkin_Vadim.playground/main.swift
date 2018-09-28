//
//  main.swift
//  1l_Rybalkin_Vadim.playground
//
//  Created by Вадим Рыбалкин on 26/09/2018.
//  Copyright © 2018 Вадим Рыбалкин. All rights reserved.
//

import Foundation
/*************
 ****Utils****
 ************/
func rDouble(min:Double,max:Double, precision:Double = 0.01)-> Double{
    return round(Double.random(in: min...max)/precision) * precision
}
func rUInt (min:UInt,max:UInt)-> UInt {
    return UInt.random(in: min...max)
}
func decimalString (_ number:Double)->String {
    let twoDigitsFormat = NumberFormatter()
    twoDigitsFormat.maximumFractionDigits = 2
    twoDigitsFormat.numberStyle = .decimal
    return twoDigitsFormat.string(from: number as NSNumber) ?? "NaN"
}
func moneyString (_ sum:Double)->String {
    let moneyFormater:NumberFormatter = NumberFormatter()
    moneyFormater.numberStyle = .currency
    moneyFormater.allowsFloats = true
    moneyFormater.groupingSize = 3
    moneyFormater.maximumFractionDigits = 2
    return moneyFormater.string(from: sum as NSNumber) ?? "NaN"
}
let pluralYears: [String] = ["год", "года", "лет"]
let pluralPercents: [String] = ["процент","процента","процентов"]
//https://gist.github.com/youmee/bc23dd6088e59609609f
func pluralForm(number: UInt, forms: [String]) -> String {
    return number % 10 == 1 && number % 100 != 11 ? forms[0] :
        (number % 10 >= 2 && number % 10 <= 4 && (number % 100 < 10 || number % 100 >= 20) ? forms[1] : forms[2])
}
func isNumeric(_ input: String) -> Bool {
    return Double(input) != nil
}
func validateWhileGetPositiveNumeric(input:String)->String{
    if isNumeric(input) && Double(input)! > 0 {
        return input
    }
    var output:String = ""
    print("Пожалуйста введите положительное число")
    while let str = readLine() {
        if isNumeric(str) && Double(str)! > 0{
            output = str
            break
        }else{
            print("Пожалуйста введите положительное число")
        }
        
    }
    return output
}

/*************
 ****Views****
 ************/
func printT1Result(a:Double, b:Double, c:Double, dis:Double, x1:Double?, x2:Double?){
    print("Уравнение: "+decimalString(a)+"x² + "+decimalString(b)+"x + "+decimalString(c)+" = 0")
    print("Дискриминант: " + decimalString(dis))
    if(x1 != nil){
        print("x1: " + decimalString(x1!) )
    }else{
        print ("Нет корней")
        return
    }
    if(x2 != nil){
        print("x2: " + decimalString(x2!)  )
    }
}
func printT2Result(base:Double, height:Double, area:Double?, perimeter:Double?, hypotenuse:Double?){
    print("Дан треугольник с основанием " + decimalString(base) + " и высотой " + decimalString(height))
    if (base <= 0 || height <= 0) {
        print("Ошибка в исходных данных: катет не может быть нулевой или отрицательной длинны")
        return
    }
    print("Площадь треугольника: " + decimalString(area!))
    print("Гипотенуза треугольника: " + decimalString(perimeter!))
    print("Перимитер треугольника: " + decimalString(hypotenuse!))
    
}
func printT3Result(sum:Double, percent:Double, years:UInt, sumAfterYears:Double){
    
    print("Даны условия вклада:")
    print("Начальная cумма вклада: \(moneyString(sum))")
    print("Вклад сделан на \(years) \(pluralForm(number: years, forms: pluralYears )) под \(decimalString(percent)) \(pluralForm(number: UInt(percent), forms: pluralPercents ))")
    print("Через \(years) \(pluralForm(number: years, forms: pluralYears)) на счету будет \(moneyString(sumAfterYears)) ")
    print()
    
}
/************************************
 ****Решить квадратное уравнение.****
 ************************************/
func taskOne(){
    print("Задание №1 ")
    print("Решить квадратное уравнение")
    print()
    /*
    * Решение
    */
    func quadratic( a:Double, b:Double, c:Double)-> (dis:Double, x1:Double?, x2:Double?) {
        let dis = pow(b, 2) - 4 * a * c
        let x1:Double? = dis>=0 ? (-b + sqrt(dis))/(2*a): nil
        let x2:Double? = dis>0 ? (-b - sqrt(dis))/(2*a): nil
        return(dis:dis,x1:x1,x2:x2)
    }
    
    /*
     * Тесты
    */
    //проверяем квадратное уровнение с отрицательным дискриминантом
    let unsolvable = quadratic(a:-1, b:-1, c:-1)
    print("проверка нерешаемого квадратного уравнения")
    printT1Result(a: -1, b: -1, c: -1, dis: unsolvable.dis, x1: unsolvable.x1, x2: unsolvable.x2)
    print()
    //проверяем квадратное уравнение с дискриминантом равным нулю
    let zero = quadratic(a:1, b:2, c:1)
    print("проверка квадратного уравнения c дискриминантом равным нулю")
    printT1Result(a: 1, b: 2, c: 1, dis: zero.dis, x1: zero.x1, x2: zero.x2)
    print()
    //проверяем квадратное уравнение с положительным дискриминантом
    let positive = quadratic(a:4.88, b:-8.64, c:-21.66)
    print("проверка квадратного уравнения c дискриминантом больше нуля")
    printT1Result(a: 4.88, b: -8.64, c: -21.66, dis: positive.dis, x1: positive.x1, x2: positive.x2)
    print()
    //рассчет квадратных уравнений с псевдослучайными числами
    print("10 псевдослучайных уравнений")
    print()
    for i in 1...10{
        let a:Double = rDouble(min: -25, max: 25)
        let b:Double = rDouble(min: -25, max: 25)
        let c:Double = rDouble(min: -25, max: 25)
        let result = quadratic( a: a, b: b, c: c)
        print("Уравнение №\(i)")
        printT1Result(a: a, b: b, c: c, dis: result.dis, x1: result.x1, x2: result.x2)
        print()
        print()
    }
}
/***************************************************************************************************
 ****Даны катеты прямоугольного треугольника. Найти площадь, периметр и гипотенузу треугольника.****
 ***************************************************************************************************/

func taskTwo(){
    print("Задание №2 ")
    print("Даны катеты прямоугольного треугольника. Найти площадь, периметр и гипотенузу треугольника")
    print()
    /*
    * Решение
    */
    func rightTriangleArea(base:Double,height:Double)-> Double?{
        if(base <= 0 || height <= 0){
            return nil
        }
        return base * height / 2
    }
    func perimeter(a:Double, b:Double, c:Double)-> Double?{
        if(a <= 0 || b <= 0 || c <= 0){
            return nil
        }
        return a+b+c
    }
    func hypotenuse(base:Double, height:Double)-> Double?{
        if(base <= 0 || height <= 0){
            return nil
        }
        return sqrt(pow(base,2) + pow(height,2))
    }
    
    /*
     * Тесты
     */
    //проверяем что катет треугольника не может быть нулевой длинны
    let pointBase: Double = 0
    let pointHeight: Double = 2
    let pointArea = rightTriangleArea(base: pointBase, height: pointHeight)
    let pointHypotenuse = hypotenuse(base: pointBase, height: pointHeight)
    let pointPerimeter = perimeter(a: pointBase, b: pointHeight, c: pointHypotenuse ?? 0 )
    print("проверка ошибочных данных: катет равен 0")
    printT2Result(base: pointBase, height: pointHeight, area: pointArea, perimeter: pointPerimeter, hypotenuse: pointHypotenuse)
    print()
    print()
    //проверяем что катет треугольника не может быть отрицательной длинны
    print("проверка ошибочных данных: катет отрицательной длинны")
    let base: Double = 20
    let height:Double = -2.12321
    let negativeArea = rightTriangleArea(base: base, height: height)
    let negativeHypotenuse = hypotenuse(base: base, height: height)
    let negativePerimeter = perimeter(a: base, b: height, c: pointHypotenuse ?? 0 )
    printT2Result(base: base, height: height, area: negativeArea, perimeter: negativePerimeter, hypotenuse: negativeHypotenuse)
    print()
    print()
    //рассчет с псевдослучайными данными
    print("10 псевдослучайных треугольников")
    for i in 1...10{
        let randomBase:Double = rDouble(min: -1, max: 50)
        let randomHeight:Double = rDouble(min: -1, max: 50)

        let randomArea = rightTriangleArea(base: randomBase, height: randomHeight)
        let randomHypotenuse = hypotenuse(base: randomBase, height: randomHeight)
        let randomPerimeter = perimeter(a: randomBase, b: randomHeight, c: randomHypotenuse ?? 0 )
        print("Треугольник №\(i)")
        printT2Result(base: randomBase, height: randomHeight, area: randomArea, perimeter: randomPerimeter, hypotenuse: randomHypotenuse)
        print()
        print()
    }
    
}
/**************************************************************************************************
 ****Пользователь вводит сумму вклада в банк и годовой процент. Найти сумму вклада через 5 лет.****
 **************************************************************************************************/
func taskThree(){
    /*
     * Решение
     */
    func addYearPercent(sum:Double, percent:Double)-> Double{
        return sum * (1 + percent/100)
    }
   
    func calculateSumAfterYears (sum:Double,percent:Double, years:UInt)-> Double{
        if (sum < 0 || percent < 0 || years < 1) {
            return 0
        }
        if (years <= 1) {
            return sum
        }
        var newSum:Double  = sum
        for _ in 1...years {
            newSum += addYearPercent(sum: sum, percent: percent)
        }
        return newSum
    }
    
    /*
     * Тесты
     */
    // проверка на псевдослучайных данных
    print("10 вычислений с псевдослучайными условиями")
    for i in 1...10{
        let randomSum:Double = rDouble(min: 1, max: 5000000000)
        let randomPercent:Double = rDouble(min: 0.01, max: 100)
        let randomYears:UInt = rUInt(min: 0, max: 100)
        let result:Double = calculateSumAfterYears(sum: randomSum, percent: randomPercent, years: randomYears)
        print("Вклад №\(i)")
        printT3Result(sum: randomSum, percent: randomPercent, years: randomYears, sumAfterYears: result)
        print()
    }
    //проверка по условиям задачи
    print("Пользователь вводит сумму вклада в банк и годовой процент. Найти сумму вклада через 5 лет")
    print("Введите сумму")
    let userInputSum:String = validateWhileGetPositiveNumeric(input: readLine() ?? "0")
    print()
    print("Введите годовые проценты")
    let userInputYearPercent:String = validateWhileGetPositiveNumeric(input: readLine() ?? "0")
    print()
    
    //todo: Ввод символов из которых нельзя получить число - крашит приложение
    let userSum:Double = Double(userInputSum)!
    let userYearPercent:Double = Double(userInputYearPercent)!
    
    let userInputResult:Double = calculateSumAfterYears(sum: userSum, percent: userYearPercent, years: 5)
    printT3Result(sum: userSum, percent: userYearPercent, years: 5, sumAfterYears: userInputResult)
    
    //считать пока пользователь не прервет выполнение
    print("Для продолжения рассчетов по вкладам нажмите enter")
    print("Для выхода из программы введите q и нажмите enter")
    while let input = readLine()  {
        if (input == "q" || input == "й" ){
            break
        }
         //todo Ввод символов из которых нельзя получить число - крашит приложение
        print("Введите сумму")
        let userInputSum:String = validateWhileGetPositiveNumeric(input: readLine() ?? "0")
        print()
        print("Введите годовые проценты")
        let userInputYearPercent:String = validateWhileGetPositiveNumeric(input: readLine() ?? "0.01")
        print()
        print("Введите срок в полных годах")
        let userInputYears:String = validateWhileGetPositiveNumeric(input: readLine() ?? "1")
        print()
        let userSum:Double = Double(userInputSum) ?? 0
        let userYearPercent:Double = Double(userInputYearPercent) ?? 0
        let userYears:UInt = UInt(userInputYears) ?? 0
        if (userSum < 0 || userYearPercent < 0 || userYears < 1) {
            print("Введены не корректные данные")
            continue
        }
        let userInputResult:Double = calculateSumAfterYears(sum: userSum, percent: userYearPercent, years: userYears)
        printT3Result(sum: userSum, percent: userYearPercent, years: userYears, sumAfterYears: userInputResult)
        print("Для продолжения рассчетов по вкладам нажмите enter")
        print("Для выхода из программы введите q и нажмите enter")
    }
    print("Выхожу...")
}

print("Решение первой задачи")
print("Для продолжения нажмите enter")
var waitUser = readLine()
taskOne()
print("Решение второй задачи")
print("Для продолжения нажмите enter")
waitUser = readLine()
taskTwo()
print("Решение третьей задачи")
print("Для продолжения нажмите enter")
waitUser = readLine()
taskThree()
