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
  @IBOutlet weak var barChartView: HorizontalBarChartView!
  
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
    // customize chart before setting data
    barChartView.noDataText = "No data to show you"
    barChartView.drawGridBackgroundEnabled = false
    barChartView.drawBordersEnabled = false
    barChartView.descriptionText = ""
    barChartView.legend.enabled = false
    barChartView.xAxis.enabled = false
    
    barChartView.autoScaleMinMaxEnabled = false
    
    var leftYAxis = barChartView.leftAxis
    leftYAxis.enabled = false
    var rightYAxis = barChartView.rightAxis
    rightYAxis.drawAxisLineEnabled = false
//    rightYAxis.axisMaximum = 40
    rightYAxis.customAxisMin = 10
    rightYAxis.customAxisMax = 40
//    rightYAxis.axisMinimum = 10
    
    // data should be set after customizing chart
    var dataEntries: [BarChartDataEntry] = []
    
    for i in 0..<dataPoints.count {
      let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
      dataEntries.append(dataEntry)
    }
    
    let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "Units Sold")
    chartDataSet.drawValuesEnabled = false
    let chartData = BarChartData(xVals: months, dataSet: chartDataSet)
    barChartView.data = chartData
    barChartView.notifyDataSetChanged()
    
  }
  
  func monthlyAxisFormatter() {
    
  }

}

