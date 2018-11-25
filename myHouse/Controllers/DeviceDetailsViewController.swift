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
    var sensor: String?
    
    @IBOutlet weak var DescriptionView: UILabel!
    @IBOutlet weak var ChartView: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DescriptionView.text = self.device!.deviceDescription
        self.device!.getData(success: { self.updateGraoh() })
        updateGraoh()
    }
    
    
    
    func updateGraoh(){
        var lineChartEntry = [ChartDataEntry]()
        for i in 0..<device!.datas[sensor!]!["data"]!.count {
            let x = device!.datas[sensor!]!["date"]![i] as! Date
            let y = device!.datas[sensor!]!["data"]![i] as! Double
            let value = ChartDataEntry(x: x.timeIntervalSince1970, y: y)
            lineChartEntry.append(value)
        }
        
        let line1 = LineChartDataSet(values: lineChartEntry, label: self.sensor)
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
        xAxis.labelFont = .systemFont(ofSize: 10, weight: .light)
        xAxis.labelCount = 4
        xAxis.valueFormatter = DateValueFormatter()
        
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
