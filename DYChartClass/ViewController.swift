//
//  ViewController.swift
//  DYChartClass
//
//  Created by macbook on 2020-01-14.
//  Copyright © 2020 Dan's Studio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	var chart: Chart2D!
	var chartP: ChartProgress!
	let dataArray = [30.32, 42.8693, 43, 100, 37.343, 77.343, 45.343, 75.343, 80.343, 87.343, 85.343, 84.343]

	override func viewDidLoad() {
		super.viewDidLoad()

		makeChartProgress()




		//makeSup()

		//makeGroup()

		//makeChart()


		let button = UIButton(type: .roundedRect)
		button.frame = CGRect(x: 50, y: 800, width: 100, height: 50)
		button.setTitle("startAni", for: .normal)
		button.addTarget(self, action: #selector(onButton), for: .touchDown)
		view.addSubview(button)

		let button2 = UIButton(type: .roundedRect)
		button2.frame = CGRect(x: 150, y: 800, width: 100, height: 50)
		button2.setTitle("getReady", for: .normal)
		button2.addTarget(self, action: #selector(onButton2), for: .touchDown)
		view.addSubview(button2)


	}

	@objc func onButton() {
		chartP.graphView.dotsView.runAnimation(type: .sameRate, duration: 0.2)
	}

	@objc func onButton2() {
		//chartP.graphView.dotsView.getReadyForAnimation()
		chartP.graphView.dotsView.runAnimation(type: .random, duration: 2)
	}

	func makeChartProgress() {

		let dataNumberCount = 10
		let a = DYConsFixDate.init()
		let dateArray = a.getSameYear(dataNumberCount)
		var dict = [(date: Date, scoreTotal: Double)]()
		for i in 0..<dataNumberCount {
			let randome100 = Double(Int.random(in: 0...1000)) / 10
			dict.append((date: dateArray[i], scoreTotal: randome100))
		}

		let rect = CGRect(x: 30, y: 100, width: view.frame.width * 0.96, height: 300)
		var chartConfig = Chart2DConfigration()
		chartConfig.xAxisConfig = Chart2DAxisConfig(with: dateArray, dateStyle: .auto, maxUnits: dataNumberCount)
		chartConfig.yAxisConfig.labelPositionType = .inside
		chartConfig.graphBackConfig.horizontalLineCount = 3
		chartConfig.graphBackConfig.horizontalLineWidth = 0.5
		//chartConfig.graphBackConfig.verticalLineCount = 10
		chartP = ChartProgress(frame: rect, xAxisSectionHeight: 30, yAxisSectionWidth: 1, config: chartConfig)
		view.addSubview(chartP)
		chartP.center = view.center

		var dataConfig = Chart2DDataConfig()
		dataConfig.animation = .before
		chartP.insertData(data: dataArray, config: dataConfig)


		let label = UILabel(frame: CGRect(x: 100, y: 100, width: 80, height: 60))
		label.text = "Jan 23 2018"
		//label.adjustsFontSizeToFitWidth = true
		//label.numberOfLines = 1
		//label.lineBreakMode = .byClipping
		label.textAlignment = .center
		view.addSubview(label)
	}


	func makeChart() {
		let rect = CGRect(x: 30, y: 100, width: view.frame.width * 0.9, height: 300)
		//let chartConfig = Chart2DConfigration()
		chart = Chart2D(frame: rect, xAxisSectionHeight: 30, yAxisSectionWidth: 30)
		//let xConfig = Chart2D.AxisConfig(elementCount: 5, linesType: "fasd", title: "XX", scaleString: ["a","fw","dfsa","dfsa"], scaleType: "fdas")

	
		view.addSubview(chart)


		chart.center = view.center

		let dataNumberCount = 10
		let a = DYConsFixDate.init()
		let dateArray = a.getRandom(dataNumberCount)
		var dict = [(date: Date, scoreTotal: Double)]()
		for i in 0..<dataNumberCount {
			let randome100 = Double(Int.random(in: 0...1000)) / 10
			dict.append((date: dateArray[i], scoreTotal: randome100))
		}

		//print(dict)



	}

	func makeGroup() {
		let backHelperView = UIView()
		backHelperView.frame = CGRect(x: 29, y: 99, width: view.frame.width * 0.9 + 2, height: 300 + 2)
		//backHelperView.backgroundColor = .red
		view.addSubview(backHelperView)
		let rect = CGRect(x: 30, y: 100, width: view.frame.width * 0.9, height: 300)
		//let chartV = Chart2DGraphView(frame: rect)
		//chartV.backgroundColor = .brown
		//view.addSubview(chartV)
	}

	func makeSup() {
		let backG = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width * 0.9 + 10, height: 300 + 10))
		backG.center = view.center
		backG.backgroundColor = .darkGray
		view.addSubview(backG)

		let chart = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width * 0.9, height: 300))
		chart.center = view.center
		chart.backgroundColor = .cyan
		view.addSubview(chart)


		var config = DDLine.config(rectSize: chart.frame.size)
		let botLine = DDLine()
		botLine.makeLine(config: config)
		botLine.frame.origin = CGPoint(x: 0, y: chart.frame.height - config.lineWidth / 2)
		chart.layer.addSublayer(botLine)

		let rightLine = DDLine()
		config.directionType = .vertical
		rightLine.makeLine(config: config)
		rightLine.frame.origin = CGPoint(x: config.lineWidth / 2, y: 0)
		chart.layer.addSublayer(rightLine)

		let array = [34, 54, 54, 75, 84, 25, 63, 75, 87, 59]

//		let dot = DDLineChartDot()
//		let dotConfig = DDLineChartDot.config()
//		dot.makeDot(config: dotConfig)
//		chart.layer.addSublayer(dot)
		var lastPosition: CGPoint = CGPoint.zero

		for (i, number) in array.enumerated() {
			let dot = DDLineChartDot()
			let dotConfig = DDLineChartDot.config()

			let positionY = CGFloat(100 - number)/100 * chart.frame.height - dotConfig.dotSize.width
			let positionX = chart.frame.width / CGFloat(array.count) * CGFloat(i + 1) - dotConfig.dotSize.width
			dot.frame.origin = CGPoint(x: positionX, y: positionY)
			dot.makeDot(config: dotConfig)
			chart.layer.addSublayer(dot)
			//print(dot.frame.origin)

			if i != 0 {
				// make connection
				let path = UIBezierPath()
				path.move(to: lastPosition)
				path.addLine(to: CGPoint(x: positionX, y: positionY))
				let connection = CAShapeLayer()
				connection.strokeColor = UIColor.systemGray5.cgColor
				connection.lineWidth = 2
				connection.path = path.cgPath
				chart.layer.addSublayer(connection)
			}
			lastPosition = CGPoint(x: positionX, y: positionY)
		}

	}


}

