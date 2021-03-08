//
//  ViewController.swift
//  DYChartClass
//
//  Created by macbook on 2020-01-14.
//  Copyright © 2020 Dan's Studio. All rights reserved.
//

//The MIT License (MIT)
//
//Copyright (c) 2015 Dan's Studio
//
//Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import UIKit

class ViewController: UIViewController {

	// screen size
	private let sw = UIScreen.main.bounds.width
	private let sh = UIScreen.main.bounds.height

	// view elements
	private var chartProgress: ChartProgress!
	private var dashCircle = DYDashboardCircle()
	private var dashCricleArr = [DYDashboardCircle]()

	override func viewDidLoad() {
		super.viewDidLoad()
		//setupCurrent()
		//setupSingleDashboardCircleSample()
		setupMultipleDashboardCircleSample()
		setupChartProgressSample()
		setupTestingButton()
	}

//	private func setupCurrent() {
//		let rect = CGRect(x: sw * 0.05, y: sh * 0.55, width: sw * 0.9, height: sw * 0.8)
//		let chart = ChartProgress(frame: rect, xAxisSectionHeight: sw * 0.1, yAxisSectionWidth: sw * 0.1)
//		view.addSubview(chart)
//	}

	// MARK: Dashboard simple sample
	private func setupSingleDashboardCircleSample() {
		dashCircle.frame = CGRect(x: sw * 0.2, y: sw * 0.2, width: sw * 0.6, height: sw * 0.6)
		view.addSubview(dashCircle)
		dashCircle.value(to: 0.9, animated: true)
		dashCircle.layoutSubviews()
	}

	// MARK: Dashboard advanced
	private func setupMultipleDashboardCircleSample() {

		let positionFactorArr: [CGPoint] = [CGPoint(x: 0.1, y: 0.1), CGPoint(x: 0.6, y: 0.1), CGPoint(x: 0.1, y: 0.3), CGPoint(x: 0.75, y: 0.5)]

		positionFactorArr.forEach {
			let frame = CGRect(x: sw * $0.x, y: sw * $0.y, width: sw * 0.3, height: sw * 0.3)
			let dashCircle = DYDashboardCircle(frame: frame)
			dashCircle.value(to: 0.9, animated: true)
			dashCircle.layoutSubviews()
			view.addSubview(dashCircle)
			dashCricleArr.append(dashCircle)
		}

		dashCricleArr[0].colorType = .block
		dashCricleArr[0].circleLineWidth = sw * 0.1
		dashCricleArr[1].startPosition = .right
		dashCricleArr[2].circleColors = [.systemPink, .systemBlue, .systemRed]
		dashCricleArr[2].circleType = .semiCircle
		dashCricleArr[3].circleType = .semiCircle
		dashCricleArr[3].circleLineWidth = sw * 0.1
		dashCricleArr[3].startPosition = .top
	}

	// MARK: Progress Chart sample
	private func setupChartProgressSample() {
		// step1 : setup x axis/ y axis (date and number)
		let dataNumberCount = 10
		let sampleDate = DYConsFixDate.init()
		let dateArray = sampleDate.getSameYear(dataNumberCount)
		var dataDict = [(date: Date, scoreTotal: Double)]()
		for i in 0..<dataNumberCount {
			let randome100 = Double(Int.random(in: 0...1000)) / 10.0
			dataDict.append((date: dateArray[i], scoreTotal: randome100))
		}

		// step2 : setup chart config pack
		let rect = CGRect(x: sw * 0.05, y: sh * 0.55, width: sw * 0.9, height: 250.0)
		var chartConfig = Chart2DConfigration()
		chartConfig.xAxisConfig = Chart2DAxisConfig(with: dateArray, dateStyle: .auto, maxUnits: dataNumberCount)
		chartConfig.yAxisConfig.labelPositionType = .inside
		chartConfig.graphBackConfig.horizontalLineCount = 3
		chartConfig.graphBackConfig.horizontalLineWidth = 0.5

		// setp3: setup chart view
		chartProgress = ChartProgress(frame: rect, xAxisSectionHeight: 30, yAxisSectionWidth: 1, config: chartConfig)
		chartProgress.backgroundColor = .systemGray5
		view.addSubview(chartProgress)

		// step4 : apply data
		let dataArray = [30.32, 42.8693, 43, 100, 37.343, 77.343, 45.343, 75.343, 80.343, 87.343, 85.343, 84.343]
		var dataConfig = Chart2DDataConfig()
		dataConfig.animation = .before
		chartProgress.insertData(data: dataArray, config: dataConfig)
	}

	private func setupTestingButton() {

		let randomPercentButton = UIButton(type: .roundedRect)
		randomPercentButton.frame = CGRect(x: sw * 0.25, y: sh * 0.45, width: sw * 0.5, height: 50.0)
		randomPercentButton.setTitle("Random Percent", for: .normal)
		randomPercentButton.addTarget(self, action: #selector(onRandomPercentButton(sender:)), for: .touchDown)
		view.addSubview(randomPercentButton)

		let progressButtonLeft = UIButton(type: .roundedRect)
		progressButtonLeft.frame = CGRect(x: sw * 0.1, y: sh * 0.9, width: sw * 0.3, height: 50.0)
		progressButtonLeft.tag = 0
		progressButtonLeft.setTitle("Same speed", for: .normal)
		progressButtonLeft.addTarget(self, action: #selector(onProgressButtonRight(sender:)), for: .touchDown)
		view.addSubview(progressButtonLeft)

		let progressButtonRight = UIButton(type: .roundedRect)
		progressButtonRight.frame = CGRect(x: sw * 0.6, y: sh * 0.9, width: sw * 0.3, height: 50.0)
		progressButtonRight.tag = 1
		progressButtonRight.setTitle("Random speed", for: .normal)
		progressButtonRight.addTarget(self, action: #selector(onProgressButtonRight(sender:)), for: .touchDown)
		view.addSubview(progressButtonRight)
	}

	// MARK: Handler
	@objc func onRandomPercentButton(sender: UIButton) {
		let value = CGFloat.random(in: 0.0...1.0)
		dashCricleArr.forEach { $0.value(to: value, animated: true) }
		sender.setTitle("Current: \(String(format: "%.2f", value * 100))%", for: .normal)
	}

	@objc func onProgressButtonRight(sender: UIButton) {
		if sender.tag == 0 {
			chartProgress.graphView.dotsView.runAnimation(type: .sameRate, duration: 0.5)
		} else if sender.tag == 1 {
			chartProgress.graphView.dotsView.runAnimation(type: .random, duration: 2.0)
		}
	}

	deinit { print("\(self) deinited") }
}

