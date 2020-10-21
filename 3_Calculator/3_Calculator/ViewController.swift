//
//  ViewController.swift
//  3_Calculator
//
//  Created by 陈劭彬 on 2020/10/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lable: UILabel!
    var tempNum:Double = 0
    var newNum:Bool = false
    var operatorJudge:Bool = false //To judge whether an operator is touched
    var operatorType:Int = -1
    var memoryNum:Double = 0 //mc/m+/m-/mr
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newNum = true
        lable.text = "0"
        // Do any additional setup after loading the view.
    }
    func removezeros()
    {
        var temp:Double = Double(lable.text!)!
        if floor(temp) == temp
        {
            lable.text = String(Int(temp))
        }
    }
    @IBAction func Number(_ sender: UIButton)
    {
        if newNum
        {
            if sender.tag == 10
            {
                lable.text = "0."
                newNum = false
            }
            else
            {
                lable.text = String(sender.tag)
                if sender.tag != 0
                {
                    newNum = false
                }
            }
        }
        else
        {
            if sender.tag == 10
            {
                lable.text! += "."
            }
            else
            {
                lable.text! += String(sender.tag)
            }
        }
        removezeros()
    }
    func Factorial(n: Int) -> Double
    {
        var result:Double = 1
        for i in 1...n
        {
            result = result * Double(i)
        }
        return result
    }
    @IBAction func oneOp(_ sender: UIButton)
    {
        var temp:Double = Double(lable.text!)!
        switch sender.tag
        {
        case 21:
            lable.text = String(-temp)
        case 22:
            lable.text = String(temp/100)
        case 23:
            lable.text = String(temp*temp)
        case 24:
            lable.text = String(temp*temp*temp)
        case 25:
            lable.text = String(exp(temp))
        case 26:
            lable.text = String(pow(10, temp))
        case 27:
            lable.text = String(1/temp)
        case 28:
            lable.text = String(sqrt(temp))
        case 29:
            lable.text = String(pow(temp, 1/3))
        case 30:
            if temp > 0
            {
                lable.text = String(log(temp))
            }
            else
            {
                lable.text = "ERROR"
            }
        case 31:
            if temp > 0
            {
                lable.text = String(log10(temp))
            }
            else
            {
                lable.text = "ERROR"
            }
        case 32:
            if Int(temp) > 170 || Int(temp) < 0
            {
                lable.text = "ERROR"
            }
            else if Int(temp) == 0
            {
                lable.text = "1"
            }
            else
            {
                lable.text = String(Factorial(n: Int(temp)))
            }
        case 33:
            lable.text = String(sin(temp))
        case 34:
            lable.text = String(cos(temp))
        case 35:
            lable.text = String(tan(temp))
        case 36:
            lable.text = String(sinh(temp))
        case 37:
            lable.text = String(cosh(temp))
        case 38:
            lable.text = String(tanh(temp))
        default:
            lable.text = lable.text
        }
        removezeros()
    }
    @IBAction func twoOp(_ sender: UIButton)
    {
        var temp:Double = Double(lable.text!)!
        if operatorJudge == true
        {
            switch operatorType
            {
            case 11:
                lable.text = String(tempNum+temp)
            case 12:
                lable.text = String(tempNum-temp)
            case 13:
                lable.text = String(tempNum*temp)
            case 14:
                if Double(lable.text!)! != 0
                {
                    lable.text = String(tempNum/temp)
                }
                else
                {
                    lable.text = "ERROR"
                }
            case 15:
                lable.text = String(pow(tempNum, temp))
            case 16:
                lable.text = String(pow(tempNum, 1/temp))
            default:
                lable.text = lable.text
            }
        }
        operatorJudge = true
        operatorType = sender.tag
        tempNum = Double(lable.text!)!
        newNum = true
        removezeros()
    }
    @IBAction func OpAC(_ sender: UIButton)
    {
        tempNum = 0.0
        newNum = true
        operatorJudge = false
        operatorType = -1
        lable.text = "0"
        removezeros()
    }
    @IBAction func OpEqual(_ sender: UIButton)
    {
        var temp:Double = Double(lable.text!)!
        switch operatorType
        {
        case 11:
            lable.text = String(tempNum+temp)
        case 12:
            lable.text = String(tempNum-temp)
        case 13:
            lable.text = String(tempNum*temp)
        case 14:
            if Double(lable.text!)! != 0
            {
                lable.text = String(tempNum/temp)
            }
            else
            {
                lable.text = "ERROR"
            }
        case 15:
            lable.text = String(pow(tempNum, temp))
        case 16:
            lable.text = String(pow(tempNum, 1/temp))
        default:
            lable.text = lable.text
        }
        tempNum = 0
        newNum = true
        operatorJudge = false
        operatorType = -1
        removezeros()
    }
    @IBAction func OpMem(_ sender: UIButton)
    {
        switch sender.tag
        {
        case 41:
            memoryNum = 0
        case 42:
            memoryNum += Double(lable.text!)!
        case 43:
            memoryNum -= Double(lable.text!)!
        case 44:
            lable.text = String(memoryNum)
        default:
            lable.text = lable.text
        }
        removezeros()
    }
    @IBAction func OpReg(_ sender: UIButton)
    {
        switch sender.tag
        {
        case 11:
            lable.text = String(M_E)
        case 12:
            lable.text = String(Double.pi)
        case 13:
            lable.text = String(arc4random())
        default:
            lable.text = lable.text
        }
        removezeros()
    }
}


