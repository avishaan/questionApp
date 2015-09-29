//
//  BNMilestonePieChartView.swift
//  questionApp
//
//  Created by Daniel Hsu on 8/1/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit
import Charts

class BNMilestonePieChartView: PieChartView {
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
    // Drawing code
    }
    */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func config(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(yVals: dataEntries, label: "")
        let pieChartData = PieChartData(xVals: dataPoints, dataSet: pieChartDataSet)
        self.data = pieChartData
        self.usePercentValuesEnabled = true
        
        // Customize pieChart look and feel
        var colors: [UIColor] = []
        
        for i in 0..<dataPoints.count {
            let completeColor = UIColor.blueColor()
            let incompleteColor = UIColor.whiteColor()
            if dataPoints[i] == "" {
                colors.append(incompleteColor)
            } else {
                colors.append(completeColor)
            }
        }
        
        pieChartDataSet.colors = colors
        
        self.drawHoleEnabled = false
        self.descriptionText = ""
        pieChartDataSet.valueTextColor = UIColor.clearColor()
        pieChartDataSet.selectionShift = 0
        self.legend.enabled = false
        
        
    }
    
    
}
