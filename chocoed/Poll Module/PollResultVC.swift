//
//  PollResultVC.swift
//  chocoed
//
//  Created by Mahesh Bhople on 01/01/19.
//  Copyright © 2019 barkha sikka. All rights reserved.
//

import UIKit
//import Charts
import Highcharts

class PollResultVC: UIViewController {
    
   // @IBOutlet var chart: HorizontalBarChartView!
    
    
    
    @IBOutlet var lblTitle: UILabel!
    
    @IBOutlet var lblResult: UILabel!
    
    @IBOutlet var mainView: UIView!
    
    var QuestionData = [getPollDataList]()
     var currentQuestion = Int()
    
    var labels : [String] = [String]()
    var values : [Int] = [Int]()
    var chartView : HIChartView!
    
   // weak var axisFormaterDelegate : IAxisValueFormatter?


    @IBAction func backAction(_ sender: Any) {
        
        let vc  = self.storyboard?.instantiateViewController(withIdentifier: "poll") as? PollViewController
        present(vc!, animated: true, completion: nil)
        
    }
    
  /*  func setup(barLineChartView chartView: BarLineChartViewBase) {
        chartView.chartDescription?.enabled = false
        chartView.dragEnabled = true
        chartView.setScaleEnabled(true)
        chartView.pinchZoomEnabled = false
        let xAxis = chartView.xAxis
        xAxis.labelPosition = .bottom
        chartView.rightAxis.enabled = false
    } */
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //axisFormaterDelegate = self
        
        let language = UserDefaults.standard.string(forKey: "currentlanguage")
        self.lblTitle.text = "ResultKey".localizableString(loc: language!)

        
        self.loadPollData()
        
        
        
        
    }
    
    func showgraph(){
        
        
        self.chartView = HIChartView(frame: self.mainView.bounds)
        let options = HIOptions()
        let chart = HIChart()
        chart.type = "bar"
        options.chart = chart
        let title = HITitle()
        title.text =  self.QuestionData[self.currentQuestion].namePoll
        let subtitle = HISubtitle()
        subtitle.text = self.QuestionData[self.currentQuestion].question
        options.title = title
        options.subtitle = subtitle
        
       
        
        let optionList = self.QuestionData[self.currentQuestion].option
        for option in optionList {
            let optionObject =  getOptions(option as! NSDictionary)
            labels.append(optionObject.name)
            values.append(Int(optionObject.SelectedUserCount))
        }
        
        
        
        let xAxis = HIXAxis()
        xAxis.categories = labels
        options.xAxis = [xAxis]
        
        let yAxis = HIYAxis()
        yAxis.min = 0
        yAxis.title = HITitle()
        yAxis.title.text = "Votes"
        options.yAxis = [yAxis]
        
       
        let column = HISeries()
        column.data = values
        column.name = "Vote"
        options.series = [column]
        
        
        let exporting = HIExporting()
        exporting.enabled = false
        options.exporting = exporting
        
        let credits = HICredits()
        credits.enabled = false
        options.credits = credits

        
        self.chartView.options = options
        self.mainView.addSubview(self.chartView)
        
        
      /*  self.setup(barLineChartView: chart)
        
        chart.drawBarShadowEnabled = false
        chart.drawValueAboveBarEnabled = true
        
        chart.maxVisibleCount = 60
        
        let xAxis = chart.xAxis
        xAxis.labelPosition = .bottom
        xAxis.labelFont = .systemFont(ofSize: 10)
        xAxis.drawAxisLineEnabled = true
        xAxis.granularity = 10
        
        let leftAxis = chart.leftAxis
        leftAxis.labelFont = .systemFont(ofSize: 10)
        leftAxis.drawAxisLineEnabled = true
        leftAxis.drawGridLinesEnabled = true
        leftAxis.axisMinimum = 0
        
        let rightAxis = chart.rightAxis
        rightAxis.enabled = true
        rightAxis.labelFont = .systemFont(ofSize: 10)
        rightAxis.drawAxisLineEnabled = true
        rightAxis.axisMinimum = 0
        
        let l = chart.legend
        l.horizontalAlignment = .left
        l.verticalAlignment = .bottom
        l.orientation = .horizontal
        l.drawInside = false
        l.form = .square
        l.formSize = 8
        l.font = UIFont(name: "HelveticaNeue-Light", size: 11)!
        l.xEntrySpace = 4
        
        chart.fitBars = false
        chart.animate(yAxisDuration: 2.5)
        
        let optionList = self.QuestionData[self.currentQuestion].option
        for option in optionList {
            let optionObject =  getOptions(option as! NSDictionary)
            labels.append(optionObject.name)
        }
        
        
        
        let barWidth = 9.0
        let spaceForBar = 10.0
        
        let count = self.QuestionData[self.currentQuestion].option.count
        
        let yVals = (0..<count ).map { (i) -> BarChartDataEntry in
           
            let option = self.QuestionData[self.currentQuestion].option[i]
            let optionObject =  getOptions(option as! NSDictionary)
        
            return BarChartDataEntry(x: Double(i)*spaceForBar, y: Double(optionObject.SelectedUserCount),data: labels as AnyObject)
            
        }
        
        let set1 = BarChartDataSet(values: yVals, label: "DataSet")
        set1.drawIconsEnabled = false
        
        let data = BarChartData(dataSet: set1)
        data.setValueFont(UIFont(name:"HelveticaNeue-Light", size:10)!)
        data.barWidth = barWidth
        chart.data = data
        
        let xAxisValue = chart.xAxis
        xAxisValue.valueFormatter = axisFormaterDelegate
        
        
        
        /*
        
    
        print(self.QuestionData[self.currentQuestion])
        
        
        let optionList = self.QuestionData[self.currentQuestion].option
        for option in optionList {
            let optionObject =  getOptions(option as! NSDictionary)
            labels.append(optionObject.name)
        }
        
        print(labels)
        
        
        
        
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
 
        */ */
        
    }
    
    
    
    func loadPollData(){
        
       
        
        let userID = UserDefaults.standard.integer(forKey: "userid")
        print(userID, "USER ID IS HERE")
        //let params = ["userId": "\(userID)",  "access_token":"\(accessToken)"] as Dictionary<String, String>
        let params = ["userId": "\(userID)","pollId":"\(self.QuestionData[self.currentQuestion].id)",  "access_token":"\(accessToken)"] as Dictionary<String, String>
        
        print(params)
        
        
        MakeHttpPostRequest(url: pollResult, params: params, completion: {(success, response) -> Void in
            print(response)
         
            
            let poll = response.object(forKey: "optionList") as? NSArray ?? []
            self.QuestionData[self.currentQuestion].option = poll
           
            //            let option = response.object(forKey: "optionList") as? NSArray ?? []
            //            for options in option {
            //                self.arrayoptions.append(getOptions( options as! NSDictionary))
            //            }
            
            DispatchQueue.main.async {
                let msg = response.object(forKey: "resultText") as? String ?? ""
                self.lblResult.text = msg
                self.showgraph()
            }
            
          
            
        }, errorHandler: {(message) -> Void in
            let alert = GetAlertWithOKAction(message: message)
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
            }
        })
    }

    
  /*  func setDataCount(count: Int, range: Double){
        
        let barWidth = 2.0
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
        
        
        
    } */
}

/* extension PollResultVC : IAxisValueFormatter {
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return labels[Int(value)]
    }
} */
