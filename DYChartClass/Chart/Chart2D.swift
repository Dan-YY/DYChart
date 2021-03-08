////
////  Chart2D.swift
////  DYChartClass
////
////  Created by macbook on 2020-01-16.
////  Copyright © 2020 Dan's Studio. All rights reserved.
////
//
//import UIKit
//
//class Chart2D: UIView {
//
//	// setting for chart templet
//	var xAxisUnitLabels: [String]?
//	var yAxisUnitLabels: [String]?
//	//var config: Chart2DConfigration
//
//	var array: [Double]?
//	//var config = Config() { didSet { applyConfig() }}
//	var grapConfig = BodyConfig()
//	var allConfig = Config()
//
//	var graphView: Chart2DGraphView!
//	var xAxisView: Chart2DXAxisView?
//	var yAxisView: Chart2DYAxisView?
//
//
//	init(frame: CGRect, xAxisSectionHeight: CGFloat?, yAxisSectionWidth: CGFloat?, config: Chart2DConfigration? = nil) {
//		let config = config ?? Chart2DConfigration()
//		super.init(frame: frame)
//		commonInit(xAxisSectionHeight, yAxisSectionWidth, config)
//	}
//
//	//init(frame: CGRect, xAxisSectionHeight: CGFloat?, yAxisSectionWidth: CGFloat?, data: [[Double]]) {}
//
//	required init?(coder: NSCoder) {
//		fatalError("init(coder:) has not been implemented")
//	}
//
//	private func commonInit(_ xAxisHeight: CGFloat?, _ yAxisWidth: CGFloat?, _ config: Chart2DConfigration) {
//		let xAxisHeight = xAxisHeight ?? 0.0
//		let yAxisWidth = yAxisWidth ?? 0.0
//		let fw = frame.width
//		let fh = frame.height
//
//		if xAxisHeight != 0.0 {
//			let rect = CGRect(x: yAxisWidth, y: fh - xAxisHeight, width: fw - yAxisWidth, height: xAxisHeight)
//			setupXAxisView(frame: rect, config: config.xAxisConfig)
//			addSubview(xAxisView!)
//		}
//
//		if yAxisWidth != 0.0 {
//			let rect = CGRect(x: 0.0, y: 0.0, width: yAxisWidth, height: fh - xAxisHeight)
//			setupYAxisView(frame: rect, config: config.yAxisConfig)
//			addSubview(yAxisView!)
//		}
//
//		let graphRect = CGRect(x: yAxisWidth, y: 0.0, width: fw - yAxisWidth, height: fh - xAxisHeight)
//		setupGraphView(frame: graphRect, config: nil)
//		addSubview(graphView)
////		applyConfig(config: Config())
////		print("first init")
//		//addSubview(verticalAxisView)
//	}
//
//	override func layoutSubviews() {
//		print("in layoutSubview")
//	}
//
//	func applyConfig(config: Config) {
//
////		let xAsixHeight: CGFloat = 50
////		let yAsixWidth: CGFloat = 30
////		xAxisView.frame = CGRect(x: yAsixWidth, y: frame.height - xAsixHeight, width: frame.width - yAsixWidth, height: xAsixHeight)
////		yAxisView.frame = CGRect(x: 0, y: 0, width: yAsixWidth, height: frame.height - xAsixHeight)
////		graphView = Chart2DGraphView(frame: CGRect(x: yAsixWidth, y: 0, width: frame.width - yAsixWidth, height: frame.height - xAsixHeight))
//
//
//	}
//
//	func applyData(data: [Double]) {
//		
//	}
//
//	private func setupGraphView(frame: CGRect, config: BodyConfig?) {
////		guard let config = config?.mainConfig else {
////			return
////		}
//		//mainView = Chart2DMain
//		//print("setup graph view called", graphView.frame)
//		//graphView.setNeedsLayout()
//		//graphView = Chart2DGraphView(frame: frame)
//	}
//
//	private func setupXAxisView(frame: CGRect, config: Chart2DAxisConfig) {
//
//		xAxisView = Chart2DXAxisView(frame: frame)
//		// temp
//		let row = config.unitCount
//
//		// start here
//		let distance = frame.width / CGFloat(row + 1)
//		for i in 0..<row {
//			let rect = CGRect(x: 0, y: 0, width: 50, height: 50)
//			let label = UILabel(frame: rect)
//			label.text = config.labelArray[i]
//			label.sizeToFit()
//			label.frame.origin = CGPoint(x: distance * CGFloat(i + 1) - label.frame.width / 2, y: 5)
//			xAxisView?.addSubview(label)
//		}
//	}
//
//	private func setupYAxisView(frame: CGRect, config: Chart2DAxisConfig) {
//		yAxisView = Chart2DYAxisView(frame: frame)
//		let row = config.unitCount
//		print(frame.height, self.frame.height, frame.height / CGFloat(row))
//		let distance = frame.height / CGFloat(row - 1)
//		for i in 0..<row {
//			let rect = CGRect(x: 0, y: 0, width: 50, height: 50)
//			let label = UILabel(frame: rect)
//			label.text = config.labelArray[i]
//			label.sizeToFit()
//			label.textAlignment = .right
//			let offset: CGFloat
//			if i == 0 {
//				offset = -label.frame.height / 2
//			} else if i == row - 1 {
//				offset = label.frame.height / 2
//			} else {
//				offset = 0
//			}
//			label.frame.origin = CGPoint(x: frame.width - label.frame.width - 5, y: frame.height - distance * CGFloat(i) - label.frame.height / 2 + offset)
//			yAxisView?.addSubview(label)
//		}
//	}
//
//}
//
//
////MARK: Class Enum
//extension Chart2D {
//	enum Style {
//		case ios, classic, noMergin
//	}
//}
//
////MARK: Class Struct
//extension Chart2D {
//	struct Config {
////		var bodyConfig = BodyConfig()
////		var xAxisConfig = AxisConfig()
////		var yAxisConfig = AxisConfig()
//		var frame: CGRect = CGRect(x: 0, y: 0, width: 200, height: 200)
//		var xAxisLabelsHeight: CGFloat = 30
//		var yAxisLabelsWidth: CGFloat = 30
//	}
//
//	struct Must {
//		var yAxisLowerBound = 0
//		var yAxisUpperBound = 100
//		var yAxisUnitsCount = 5
//		var yAxisValueFormat: NumberFormatter?
//		var xAxisLowerBound = 0
//		var xAxisUpperBound = 100
//		var xAxisUnitsCount = 5
//		var xAxisValueFormat: NumberFormatter?
//	}
//
//	struct BodyConfig {
//		var type: String = "line"
//	}
//
//	struct AxisConfig {
//		var elementCount = 10
//		var linesType = "in"
//		var title = "time"
//		var scaleString = ["a", "b", "c"]
//		var scaleType = "Int"
//	}
//}
