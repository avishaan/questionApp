//
//  ViewController.swift
//  questionApp
//
//  Created by Brown Magic on 6/8/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit
import Charts


class ViewController: BNUIViewController {

  @IBOutlet weak var subView: UIView!
  @IBOutlet weak var chartView: CombinedChartView!
  
  var months: [String]?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    months = ["Jan"]
    let unitsSold = [8.0]
    
    setChart(months!, values: unitsSold)
    
    //check all fonts
    for family in UIFont.familyNames() {
      println(family)
      for name in UIFont.fontNamesForFamilyName(family as! String) {
        println(name)
      }
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func setChart(dataPoints: [String], values: [Double]) {
    chartView.noDataText = "No data to show you"
    
    var dataEntries:[BarChartDataEntry] = []
    
    for i in 0..<dataPoints.count {
      let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
      dataEntries.append(dataEntry)
    }
    
    let barChartDataSet = BarChartDataSet(yVals: dataEntries, label: "Units Sold")
    let barChartData = BarChartData(xVals: months, dataSet: barChartDataSet)
    var data: CombinedChartData = CombinedChartData(xVals: months, dataSet: barChartDataSet)
    data.barData = barChartData
    chartView.data = data
    
    chartView.descriptionText = ""
    chartView.legend.enabled = false
    chartView.xAxis.enabled = false
  }
  

}

