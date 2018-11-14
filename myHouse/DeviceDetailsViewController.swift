//
//  DeviceDetailsViewController.swift
//  myHouse
//
//  Created by Loïc CHACORNAC on 12/11/2018.
//  Copyright © 2018 fr.myHouse. All rights reserved.
//

import UIKit
import Charts

class DeviceDetailsViewController: UIViewController {
    
    var device: Device?
    var deviceData: [Double] = [0, 9, 9, 19, 23, -2, 7, 9, 12, 13, 23]
    var lineChartEntry = [ChartDataEntry]()
    
    
    
    @IBOutlet weak var DescriptionView: UILabel!
    @IBOutlet weak var ChartView: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DescriptionView.text = self.device!.deviceDescription
        self.device!.getData(success: {})
        updateGraoh()
    }
    
    
    
    func updateGraoh(){
        for i in 0..<deviceData.count {
            let value = ChartDataEntry(x:Double(i), y:deviceData[i])
            lineChartEntry.append(value)
        }
        
        let line1 = LineChartDataSet(values: lineChartEntry, label: "Number")
        line1.setColor(UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1))
        line1.drawFilledEnabled = true
        line1.fillColor = (UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1))
        line1.highlightColor = UIColor(red: 244/255, green: 117/255, blue: 117/255, alpha: 1)
        line1.drawCirclesEnabled = false
        line1.valueFont = .systemFont(ofSize: 15)
        line1.mode = .cubicBezier
        
        
        let xAxis = ChartView.xAxis
        xAxis.drawGridLinesEnabled = false
        xAxis.centerAxisLabelsEnabled = true
        xAxis.drawAxisLineEnabled = false
        xAxis.labelPosition = .bottomInside
        
        let yAxis = ChartView.leftAxis
        yAxis.drawGridLinesEnabled = false
        
        let data = LineChartData()
        data.addDataSet(line1)
        
        ChartView.rightAxis.enabled = false
        ChartView.dragEnabled = true
        ChartView.setScaleEnabled(true)
        ChartView.animate(xAxisDuration: 1, yAxisDuration: 1)
        ChartView.data = data
        
    }
}
