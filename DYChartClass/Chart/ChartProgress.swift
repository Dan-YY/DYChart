//
//  ChartProgress.swift
//  DYChartClass
//
//  Created by macbook on 2020-01-21.
//  Copyright © 2020 Dan's Studio. All rights reserved.
//

import UIKit

class ChartProgress: UIView {

	var xAxisUnitLabels: [String]?
	var yAxisUnitLabels = ["0", "25", "50", "75", "100"]
	var xPositionArray = [CGFloat]()
	var yHeight: CGFloat!

	let xAxisMaxUnit = 10

	enum subType {
		case overall, sub
	}

	var array: [Double]?

	var graphView: Chart2DGraphView!
	private var xAxisView: Chart2DXAxisView?
	private var yAxisView: Chart2DYAxisView?


	init(frame: CGRect, xAxisSectionHeight: CGFloat?, yAxisSectionWidth: CGFloat?, config: Chart2DConfigration? = nil) {
		let config = config ?? Chart2DConfigration()
		super.init(frame: frame)
		commonInit(xAxisHeight: xAxisSectionHeight, yAxisWidth: yAxisSectionWidth, config: config)
	}

	//init(frame: CGRect, xAxisSectionHeight: CGFloat?, yAxisSectionWidth: CGFloat?, data: [[Double]]) {}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func commonInit(xAxisHeight: CGFloat?, yAxisWidth: CGFloat?, config: Chart2DConfigration) {
		let xAxisHeight = xAxisHeight ?? 0.0
		let yAxisWidth = yAxisWidth ?? 0.0
		yHeight = frame.height - xAxisHeight

		let viewFrame = CGRect(x: yAxisWidth, y: 0.0,
													 width: frame.width - yAxisWidth, height: frame.height - xAxisHeight)
		setupGraphView(frame: viewFrame, config: config.graphBackConfig)
		addSubview(graphView)

		if xAxisHeight != 0.0 {
			//xAxisView = Chart2DXAxisView(frame: viewFrame, config: config.xAxisConfig, labelStyle: .normal)
			let rect = CGRect(x: yAxisWidth, y: frame.height - xAxisHeight, width: frame.width - yAxisWidth, height: xAxisHeight)
			xAxisView = Chart2DXAxisView(frame: rect, config: config.xAxisConfig, labelStyle: .normal)
			//setupXAxisView(frame: viewFrame, config: config.xAxisConfig)
			xPositionArray = xAxisView!.xPositionArray
			addSubview(xAxisView!)
		}

		if yAxisWidth != 0.0 {
			let rect = CGRect(x: 0, y: 0, width: yAxisWidth, height: frame.height - xAxisHeight)
			yAxisView = Chart2DYAxisView(frame: rect, config: config.yAxisConfig)
			//setupYAxisView(frame: viewFrame, config: config.yAxisConfig)
			addSubview(yAxisView!)
		}

//		applyConfig(config: Config())
//		print("first init")
		//addSubview(verticalAxisView)
	}

	override func layoutSubviews() {
		super.layoutSubviews()
	}

	func applyData(data: [Double]) { //TODO

	}

	private func setupGraphView(frame: CGRect, config: Chart2DGraphBackConfig) {
		graphView = Chart2DGraphView(frame: frame, config: config)
	}

//	private func setupXAxisView(frame: CGRect, config: Chart2DAxisConfig) {
//		xAxisView = Chart2DXAxisView(frame: frame)
//		// temp
//		let row = config.unitCount
//		// start here
//		let distance = frame.width / CGFloat(row + 1)
//		for i in 0..<row {
//			let rect = CGRect(x: 0.0, y: 0.0, width: distance * 0.8, height: 30.0)
//			let label = UILabel(frame: rect)
//			label.adjustsFontSizeToFitWidth = true
//			label.textColor = .label
//			label.textAlignment = .center
//			label.font = UIFont(name: "Menlo", size: 20)
//			label.text = config.labelArray[i]
//			let positionX = distance * CGFloat(i + 1)
//			label.frame.origin = CGPoint(x: positionX - label.frame.width / 2.0, y: 0.0)
//			xAxisView?.addSubview(label)
//			xPositionArray.append(positionX)
//		}
//	}

//	private func setupYAxisView(frame: CGRect, config: Chart2DAxisConfig) {
//		yAxisView = Chart2DYAxisView(frame: frame)
//		let row = config.unitCount
//		//print(frame.height, self.frame.height, frame.height / CGFloat(row))
//		let distance = frame.height / CGFloat(row - 1)
//		for i in 0..<row {
//			let rect = CGRect(x: 0, y: 0, width: distance * 0.8, height: 30)
//			let label = UILabel(frame: rect)
//			label.textColor = .label
//			label.font = UIFont.systemFont(ofSize: 15, weight: .light)
//			label.text = config.labelArray[i]
//			//label.textAlignment = .left
//			label.sizeToFit()
//
//			let offset: CGFloat
//			if i == 0 {
//				offset = -label.frame.height / 2 - 3
//			} else if i == row - 1 {
//				offset = label.frame.height / 2 + 3
//			} else {
//				offset = 0
//			}
//			var positionX: CGFloat
//
//			switch config.labelPositionType {
//			case .outside:
//				positionX = frame.width - label.frame.width - 5
//			case .inside:
//				positionX = frame.width
//			}
//
//			label.frame.origin = CGPoint(x: positionX, y: frame.height - distance * CGFloat(i) - label.frame.height / 2 + offset)
//			yAxisView?.addSubview(label)
//		}
//	}
}


extension ChartProgress {
	func insertData(data: [Double], config: Chart2DDataConfig) {
		graphView.dotsView.insertData(data: data, xPosition: xPositionArray, yHeight: yHeight, config: config)
	}

	func insertData(data: [Int], config: Chart2DDataConfig) {
		let data = data.map({ Double($0) })
		insertData(data: data, config: config)
	}

	func insertData(data: [Float], config: Chart2DDataConfig) {
		let data = data.map({ Float($0) })
		insertData(data: data, config: config)
	}
}
