//
//  GameViewController.swift
//  fgh
//
//  Created by 90305076 on 2/10/20.
//  Copyright © 2020 Ethan Koland. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    @IBOutlet weak var ButtonClear: UIButton!
    @IBOutlet weak var ButtonPlusMinus: UIButton!
    @IBOutlet weak var ButtonPercent: UIButton!
    @IBOutlet weak var ButtonDivide: UIButton!
    @IBOutlet weak var Button7: UIButton!
    @IBOutlet weak var Button8: UIButton!
    @IBOutlet weak var Buttin9: UIButton!
    @IBOutlet weak var ButtonX: UIButton!
    @IBOutlet weak var Button4: UIButton!
    @IBOutlet weak var Button5: UIButton!
    @IBOutlet weak var Button6: UIButton!
    @IBOutlet weak var ButtonMinus: UIButton!
    @IBOutlet weak var Button1: UIButton!
    @IBOutlet weak var Button2: UIButton!
    @IBOutlet weak var Button3: UIButton!
    @IBOutlet weak var ButtonPlus: UIButton!
    @IBOutlet weak var Button0: UIButton!
    @IBOutlet weak var ButtonDot: UIButton!
    @IBOutlet weak var ButtonEqual: UIButton!
    @IBOutlet weak var LabelQuestion: UILabel!
    @IBOutlet weak var LabelAnswer: UILabel!
    var Answer:Double = 0
    var Q1:Double = 0
    var Q1Dec:Int = 0
    var Q2:Double = 0
    var Q2Dec:Double = 0
    var QuestString:String = ""
    var DoubleClickClear = false
    var Q2Active = false
    var isDecimal = false
    var decCount:Double = 0.0
    var function: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        print(1)
        LabelAnswer.text = "Jeff Was Here"
    }
    @IBAction func Button1(sender: Any){
         AddNumber(num: 1)
    }
    @IBAction func Button2(_ sender: Any){
         AddNumber(num: 2)

    }
    @IBAction func Button3(_ sender: Any){
         AddNumber(num: 3)
    }
    
    @IBAction func Button4(_ sender: Any) {
        AddNumber(num: 4)

    }
    
    @IBAction func Button5(_ sender: Any) {
         AddNumber(num: 5)
    }
    @IBAction func Button6(_ sender:Any){
         AddNumber(num: 6)

    }
    @IBAction func Button7(_ sender: Any){
        AddNumber(num: 7)

    }
    @IBAction func Button8(_ sender: Any){
         AddNumber(num: 8)
    }
    @IBAction func Button9(_ sender: Any){
       AddNumber(num: 9)

    }
    @IBAction func Button0(_ sender: Any) {
        AddNumber(num: 0)
        
    }
    @IBAction func ButtonClear(_ sender:Any){
        Answer = 0;
        LabelAnswer.text = ""
        decCount = 0;
        if(!DoubleClickClear){
            ButtonClear.setTitle("AC", for: .normal )
            if(Q2Active){
            
                Q2 = 0
            } else {
                Q1 = 0
                Q2 = 0
                Q2Active = false
                
            }
            updateDisplay()
            DoubleClickClear = true
            isDecimal = false
        
        } else {
            ButtonClear.setTitle("C", for: .normal)
            DoubleClickClear = false
            Q2Active = false
            Q1 = 0
            Q2 = 0
            updateDisplay()
            isDecimal = false
        }
        function = ""
        
        
    }
    @IBAction func ButtonPlusMinus(_ sender:Any){
        if(Q2Active){
            Q2 = Q2 * -1
        } else {
            Q1 = Q1 * -1
        }
        updateDisplay()
    }
    @IBAction func ButtonPercent(_ sender:Any){
        Q2 = 0;
        Q2Active = false
        Q1 = Q1 / 100
        updateDisplay()
        
    }
    @IBAction func ButtonDivision(_ sender:Any){
        Opperation(opp: "/")
    }
    @IBAction func ButtonMult(_ sender:Any){
        Opperation(opp: "x")
    }
    @IBAction func ButtonMinus(_ sender:Any){
        Opperation(opp: "-")
    }
    @IBAction func ButtonAdd(_ sender:Any){
        Opperation(opp: "+")
    }
    @IBAction func ButtonEqual(_ sender:Any){
        if (function == "+"){
            Answer = Q1 + Q2
        } else if ( function == "-") {
            Answer = Q1 - Q2
        } else if ( function == "x") {
            Answer = Q1 * Q2
        } else {
            Answer = Q1 / Q2
        }
        LabelAnswer.text = String(Answer)
        Q1 = Answer
        Q2 = 0;
        Q2Active = false;
    }
    @IBAction func ButtonDot(_ sender:Any){
        isDecimal = true
        print(isDecimal)
    }
    
    func  update(inp:Double, Number:Int) -> Double{
        ButtonClear.setTitle("C", for: .normal)
        DoubleClickClear = false
        var temp:Double
        var Str:String
        let Count:Double = decCount + 1
        if(!isDecimal){
             temp = inp * 10
            temp = temp + Double(Number)
        } else {
            temp = inp .truncatingRemainder(dividingBy: 1.0)
            Str = String(temp)
            print(Str)
            
            temp = Double(temp) * pow(10, Count) + Double(Number)
            temp = round(temp)
            print(temp)
            temp = temp * pow(10, Double(-1 * Count))
            
            temp = Double(Int(inp)) + temp
            decCount += 1
        }
        //Wrtite a line for making decimals
        LabelAnswer.text = String(Answer)
        return(temp)
    }
    func updateDisplay(){
        var questionString:String
        if(Q2Active){
            questionString = String(Q1) + " " + function + " " + String(Q2)
            LabelAnswer.text = String(Q2)
        } else {
            questionString = String(Q1)
            LabelAnswer.text = String(Q2)
        }
        LabelQuestion.text = questionString
        
    }
    
    func eequal(){
        Answer = Q1 + Q2
        LabelAnswer.text = String(Answer)
        Q1 = Answer
        Q2 = 0;
        Q2Active = false;
    }
    
    func Opperation(opp : String){
        if(function == opp){
            Answer = Q1 + Q2
            LabelAnswer.text = String(Answer)
            Q1 = Answer
            Q2 = 0;
            Q2Active = true;
            updateDisplay()
        } else {
            function = opp
            Q2Active = true;
            isDecimal = false
            decCount = 0;
        }
        updateDisplay()
    }
    
    func AddNumber( num : Int){
        if (Q2Active){
                Q2 = update(inp: Q2, Number: num)
        } else {
            Q1 = update(inp: Q1, Number: num)
        }
        //print(Answer)
        updateDisplay()
    }


}
