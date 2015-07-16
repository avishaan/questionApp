//
//  BNTestRangeChartView.swift
//  questionApp
//
//  Created by Brown Magic on 7/16/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit
import Charts

class BNTestRangeChartView: HorizontalBarChartView {
  
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  func config(#startMonth: Double, endMonth: Double, currentAge: Double, babyName: String) {
    println("test")
    var dataPoints = ["Jan"]
    var values = [currentAge]
    
    // customize chart before setting data
    self.noDataText = "No data to show you"
    self.drawGridBackgroundEnabled = false
    self.drawBordersEnabled = false
    self.descriptionText = ""
    self.legend.enabled = false
    self.xAxis.enabled = false
    
    self.autoScaleMinMaxEnabled = false
    
    var leftYAxis = self.leftAxis
    leftYAxis.enabled = false
    var rightYAxis = self.rightAxis
    rightYAxis.drawAxisLineEnabled = false
//    rightYAxis.axisMaximum = 40
    rightYAxis.customAxisMin = startMonth
    rightYAxis.customAxisMax = endMonth
    rightYAxis.labelCount = 2
    leftYAxis.spaceBottom = 0.2
    rightYAxis.spaceBottom = 0.2
    leftYAxis.spaceTop = 0.2
    rightYAxis.spaceTop = 0.2
//    rightYAxis.axisMinimum = 10
    // formatter
    var formatter:NSNumberFormatter = NSNumberFormatter()
    formatter.maximumFractionDigits = 1
    formatter.positiveSuffix = " mo."
    rightYAxis.valueFormatter = formatter
    
    // fonts
    rightYAxis.labelFont = UIFont(name: kOmnesFontMedium, size: 17)!
    rightYAxis.labelTextColor = kGrey
    
    // set limit lines
    var babyAgeLimitLine = ChartLimitLine(limit: 9.0, label: babyName)
    babyAgeLimitLine.valueFont = UIFont(name: kOmnesFontSemiBold, size: 16)!
    babyAgeLimitLine.valueTextColor = kOrange
    babyAgeLimitLine.lineColor = kOrange
    babyAgeLimitLine.lineWidth = 5.0
    babyAgeLimitLine.lineDashLengths = [12]
    rightYAxis.addLimitLine(babyAgeLimitLine)
    
    // data should be set after customizing chart
    var dataEntries: [BarChartDataEntry] = []
    
    for i in 0..<dataPoints.count {
      let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
      dataEntries.append(dataEntry)
    }
    
    let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "Units Sold")
    chartDataSet.drawValuesEnabled = false
    let chartData = BarChartData(xVals: dataPoints, dataSet: chartDataSet)
    self.data = chartData
    
    self.setExtraOffsets(left: 30, top: 0, right: 30, bottom: 0)
    
    self.notifyDataSetChanged()
    
  }

}
