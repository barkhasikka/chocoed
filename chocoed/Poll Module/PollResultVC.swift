//
//  PollResultVC.swift
//  chocoed
//
//  Created by Mahesh Bhople on 01/01/19.
//  Copyright © 2019 barkha sikka. All rights reserved.
//

import UIKit
import Charts

class PollResultVC: UIViewController {
    
    @IBOutlet var chart: HorizontalBarChartView!
    
     var QuestionData = [getPollDataList]()
     var currentQuestion = Int()
    
    var labels : [String] = [String]()


    @IBAction func backAction(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)

    }
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        chart.drawBarShadowEnabled = false
        chart.drawValueAboveBarEnabled = true
        
        
        
        print(self.QuestionData[self.currentQuestion])
        
        chart.maxVisibleCount = 60
        
        let optionList = self.QuestionData[self.currentQuestion].option
        for option in optionList {
            let optionObject =  getOptions(option as! NSDictionary)
            labels.append(optionObject.name)
        }
        
        print(labels)
        
        
        
        //xAxis.labelCount = self.QuestionData[self.currentQuestion].option.count
        
       
        
      //  xAxis.setLabelCount(self.QuestionData[self.currentQuestion].option.count, force: true)
        
        
      /*  let leftAxis = chart.leftAxis;
        leftAxis.drawAxisLineEnabled = false;
        leftAxis.drawGridLinesEnabled = false;
        leftAxis.axisMinimum = 0.0; // this replaces startAtZero = YES
        
        let rightAxis = chart.rightAxis
        rightAxis.enabled = false;
        
        rightAxis.drawAxisLineEnabled = false;
        rightAxis.drawGridLinesEnabled = false;
        rightAxis.axisMinimum = 0.0; // this replaces startAtZero = YES */
        
        let l = chart.legend
        l.enabled =  false
        
        chart.fitBars = true;
        
        let xAxis  = chart.xAxis
        xAxis.granularity = 1.0
        xAxis.labelPosition = .bottom
       // xAxis.axisMinimum = 0.0
        
        
        
        xAxis.valueFormatter = IndexAxisValueFormatter(values: labels)
        xAxis.labelCount = optionList.count
        xAxis.setLabelCount(optionList.count, force: true)
        xAxis.drawAxisLineEnabled = true
        xAxis.drawGridLinesEnabled = false
        chart.leftAxis.enabled=false
        chart.rightAxis.enabled=false
        
        chart.chartDescription?.text = self.QuestionData[self.currentQuestion].namePoll
        
        setDataCount(count: self.QuestionData[self.currentQuestion].option.count, range: 50)

        // Do any additional setup after loading the view.
    }
    

    
    func setDataCount(count: Int, range: Double){
        
        let barWidth = 9.0
        let spaceForBar =  10.0;
        
        var yVals = [BarChartDataEntry]()
        
        for i in 0..<count{
            
            
            //let mult = (range + 1)
            //let val = (Double)(arc4random_uniform(UInt32(mult)))
            
            let option = self.QuestionData[self.currentQuestion].option[i]
            let optionObject =  getOptions(option as! NSDictionary)
            
            
            yVals.append(BarChartDataEntry(x: Double(i) * spaceForBar, y: Double(optionObject.SelectedUserCount)))
            
        
            
        }
        
        var set1 : BarChartDataSet!
        
        
        if let count = chart.data?.dataSetCount, count > 0{
            set1 = chart.data?.dataSets[0] as! BarChartDataSet
            set1.values = yVals
            chart.data?.notifyDataChanged()
            chart.notifyDataSetChanged()
            
        }else{
            set1 = BarChartDataSet(values: yVals, label: "DataSet")
            
            
            var dataSets = [BarChartDataSet]()
            dataSets.append(set1)
            
            let data = BarChartData(dataSets: dataSets)
            
            data.barWidth =  barWidth;
            
            chart.data = data
            chart.notifyDataSetChanged()
            
        }
        
        
        
    }
}
