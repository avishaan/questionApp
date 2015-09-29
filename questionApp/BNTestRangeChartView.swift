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
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  func config(startMonth startMonth: Double, endMonth: Double, successAgeInMonths: Double, babyAgeInMonths: Double, babyName: String) {
    // customize chart before setting data
    self.noDataText = "No data to show you"
    self.drawGridBackgroundEnabled = false
    self.drawBordersEnabled = true
    self.descriptionText = ""
    self.legend.enabled = false
    self.xAxis.enabled = false
    
    self.autoScaleMinMaxEnabled = false
    self.borderColor = UIColor.darkGrayColor()
    
    let leftYAxis = self.leftAxis
    leftYAxis.enabled = false
    let rightYAxis = self.rightAxis
    rightYAxis.drawAxisLineEnabled = true
    //    rightYAxis.axisMaximum = 40
    rightYAxis.customAxisMin = startMonth
    rightYAxis.customAxisMax = endMonth
    rightYAxis.labelCount = Int(endMonth)
    rightYAxis.spaceBottom = 0.8
    rightYAxis.spaceTop = 0.8
    rightYAxis.gridLineWidth = 1.5
    
    // these are percentage-based relative to height of the view
    let h = self.viewPortHandler.chartHeight
    var dashBot = h * (7 / 94)
    var dashMid = h * (57 / 94)
    rightYAxis.gridLineDashLengths = [0, dashMid, dashBot]
    
    let babyAgeLimitLine = ChartLimitLine(limit: babyAgeInMonths, label: babyName)
    rightYAxis.addLimitLine(babyAgeLimitLine)
    
    self.rightYAxisRenderer = BNYAxisRendererHorizontalWithSmileLimit(viewPortHandler: self.viewPortHandler, yAxis: self.rightAxis, transformer: self.getTransformer(.Right))
    
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
    let formatter:NSNumberFormatter = BNCustomAlternatingFormatter(mod: modu)
    formatter.maximumFractionDigits = 1
    formatter.positiveSuffix = " mo."
    rightYAxis.valueFormatter = formatter
    
    // fonts
    rightYAxis.labelFont = UIFont(name: kOmnesFontMedium, size: 17)!
    rightYAxis.labelTextColor = kGrey
    
    // data should be set after customizing chart
    var dataEntries: [BarChartDataEntry] = []
    
    let dataPoints = ["Jan"]
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
  public override func renderLimitLines(context context: CGContext?)
  {
    var limitLines = _yAxis.limitLines
    
    if (limitLines.count <= 0)
    {
      return
    }
    
    CGContextSaveGState(context)
    
    let trans = transformer.valueToPixelMatrix
    var position = CGPoint(x: 0.0, y: 0.0)
    
    for (var i = 0; i < limitLines.count; i++)
    {
      let l = limitLines[i]
      
      position.x = CGFloat(l.limit)
      position.y = 0.0
      position = CGPointApplyAffineTransform(position, trans)
      
      let image = UIImage(named: "smile")
      if let image = image {
        let offset = (position.x <= (image.size.width*1.5)) ? 0 : image.size.width/2
        image.drawAtPoint(CGPointMake(position.x - offset, viewPortHandler.chartHeight/3))
      }
      
    }
    
    CGContextRestoreGState(context)
  }
}