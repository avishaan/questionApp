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
  @IBOutlet weak var barChartView: BarChartView!
  
  var months: [String]?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
    
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
    barChartView.noDataText = "No data to show you"
    var dataEntries: [BarChartDataEntry] = []
    
    for i in 0..<dataPoints.count {
      let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
      dataEntries.append(dataEntry)
    }
    
    let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "Units Sold")
    let chartData = BarChartData(xVals: months, dataSet: chartDataSet)
    barChartView.data = chartData
    
  }
  

}

