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
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  func config(#startMonth: Double, endMonth: Double, successAgeInMonths: Double, babyAgeInMonths: Double, babyName: String) {
    // customize chart before setting data
    self.noDataText = "No data to show you"
    self.drawGridBackgroundEnabled = false
    self.drawBordersEnabled = true
    self.descriptionText = ""
    self.legend.enabled = false
    self.xAxis.enabled = false
    
    self.autoScaleMinMaxEnabled = false
    self.borderColor = UIColor.darkGrayColor()
    
    var leftYAxis = self.leftAxis
    leftYAxis.enabled = false
    var rightYAxis = self.rightAxis
    rightYAxis.drawAxisLineEnabled = true
    //    rightYAxis.axisMaximum = 40
    rightYAxis.customAxisMin = startMonth
    rightYAxis.customAxisMax = endMonth
    rightYAxis.labelCount = Int(endMonth)
    rightYAxis.spaceBottom = 0.8
    rightYAxis.spaceTop = 0.8
    rightYAxis.gridLineWidth = 1.5
    
    // these are percentage-based relative to height of the view
    let h = self.frame.size.height
    let dashBot = h * (7 / 107)
    let dashMid = h * (55 / 107)
    rightYAxis.gridLineDashLengths = [0, dashMid, dashBot]
    
    var babyAgeLimitLine = ChartLimitLine(limit: babyAgeInMonths, label: babyName)
    rightYAxis.addLimitLine(babyAgeLimitLine)
    
    self.rightYAxisRenderer = BNYAxisRendererHorizontalWithSmileLimit(viewPortHandler: self.viewPortHandler, yAxis: self.rightAxis, transformer: _rightAxisTransformer)
    
    // make sure the left axis matches the right
    leftYAxis.customAxisMin = rightYAxis.customAxisMin
    leftYAxis.customAxisMax = rightYAxis.customAxisMax
    leftYAxis.spaceBottom = rightYAxis.spaceBottom
    leftYAxis.spaceTop = rightYAxis.spaceTop
    //    rightYAxis.axisMinimum = 10
    
    // formatter
    var e = endMonth
    if (e % 2) != 0 {
      e++;
    }
    let modu = Int(ceil(e / 2))
    var formatter:NSNumberFormatter = BNCustomAlternatingFormatter(mod: modu)
    formatter.maximumFractionDigits = 1
    formatter.positiveSuffix = " mo."
    rightYAxis.valueFormatter = formatter
    
    // fonts
    rightYAxis.labelFont = UIFont(name: kOmnesFontMedium, size: 17)!
    rightYAxis.labelTextColor = kGrey
    
    // data should be set after customizing chart
    var dataEntries: [BarChartDataEntry] = []
    
    var dataPoints = ["Jan"]
    var values = [successAgeInMonths]
    
    for i in 0..<dataPoints.count {
      let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
      dataEntries.append(dataEntry)
    }
    
    let chartDataSet = BarChartDataSet(yVals: dataEntries, label: nil)
    chartDataSet.drawValuesEnabled = false
    chartDataSet.barSpace = 0.35
    let chartData = BarChartData(xVals: dataPoints, dataSet: chartDataSet)
    self.data = chartData
    
    self.setExtraOffsets(left: 30, top: 0, right: 30, bottom: 0)
    
    self.notifyDataSetChanged()
    
  }
}

class BNCustomAlternatingFormatter: NSNumberFormatter {
  
  private var mod = 1
  
  convenience init (mod: Int) {
    self.init()
    self.mod = mod
  }
  
  override func stringFromNumber(number: NSNumber) -> String? {
    let diff = number.integerValue % mod
    if (diff == 0) {
      return super.stringFromNumber(number)
    }
    return ""
  }
}

public class BNYAxisRendererHorizontalWithSmileLimit: ChartYAxisRendererHorizontalBarChart
{
  public override func renderLimitLines(#context: CGContext)
  {
    var limitLines = _yAxis.limitLines
    
    if (limitLines.count <= 0)
    {
      return
    }
    
    CGContextSaveGState(context)
    
    var trans = transformer.valueToPixelMatrix
    
    var position = CGPoint(x: 0.0, y: 0.0)
    
    for (var i = 0; i < limitLines.count; i++)
    {
      var l = limitLines[i]
      
      position.x = CGFloat(l.limit)
      position.y = 0.0
      position = CGPointApplyAffineTransform(position, trans)
      
      var image = UIImage(named: "smile")
      if let image = image {
        image.drawAtPoint(CGPointMake(position.x - image.size.width/2, viewPortHandler.chartHeight/3))
      }
      
    }
    
    CGContextRestoreGState(context)
  }
}