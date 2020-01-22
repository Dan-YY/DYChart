//
//  Chart2DBody.swift
//  DYChartClass
//
//  Created by macbook on 2020-01-16.
//  Copyright © 2020 Dan's Studio. All rights reserved.
//

import UIKit

class Chart2DGraphView: UIView {

	var backgroundView: Chart2DGraphBackground!
	var dotsView = Chart2DGraphNodes()
	var linesView = Chart2DGraphLines()
	

	init(frame: CGRect, config: Chart2DGraphBackConfig) {
		super.init(frame: frame)
		commonInit(config: config)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func commonInit(config: Chart2DGraphBackConfig) {
		backgroundView = Chart2DGraphBackground(frame: bounds, config: config)
		addSubview(backgroundView)
		addSubview(dotsView)
		addSubview(linesView)
		//setup()
	}

	override func layoutSubviews() {
		//setup()
	}

	private func setup() {

		//makeBackground()
	}



}

extension Chart2DGraphView {

	private func makeBackground() {
		makeEdge()
		makeGrid(column: 3, row: 10)
	}

	private func makeEdge() {
		var edgeConfig = ChartStraightLine.config()
		edgeConfig.lineWidth = 3
		let offset = edgeConfig.lineWidth / 2

		let topEdge = ChartStraightLine()
		topEdge.makeLine(start: CGPoint(x: 0, y: 0 + offset), end: CGPoint(x: frame.width, y: 0 + offset), config: edgeConfig)
		layer.addSublayer(topEdge)

		let botEdge = ChartStraightLine()
		botEdge.makeLine(start: CGPoint(x: 0, y: frame.height - offset), end: CGPoint(x: frame.width, y: frame.height - offset), config: edgeConfig)
		layer.addSublayer(botEdge)

		let leftEdge = ChartStraightLine()
		leftEdge.makeLine(start: CGPoint(x: 0 + offset, y: 0), end: CGPoint(x: 0 + offset, y: frame.height), config: edgeConfig)
		layer.addSublayer(leftEdge)

		let rightEdge = ChartStraightLine(start: CGPoint(x: frame.width, y: 0), end: CGPoint(x: frame.width - offset, y: frame.height), config: edgeConfig)
		layer.addSublayer(rightEdge)

	}

	private func makeScale() {

	}

	private func makeGrid(column: Int, row: Int) {

		var config = ChartStraightLine.config()
		config.lineWidth = 2

		// horizontal
		let horizontalEdgeOffset = frame.width / CGFloat(row + 1)
		let horizontalDistance = frame.width / CGFloat(row + 1)
		let hOffset = config.lineWidth / 2
		for index in 0..<row {
			let horizontalScaleLine = ChartStraightLine()
			let xPosition = CGFloat(index) * horizontalDistance + horizontalEdgeOffset
			let start = CGPoint(x: xPosition - hOffset, y: frame.height)
			let end = CGPoint(x: xPosition - hOffset, y: 0)
			horizontalScaleLine.makeLine(start: start, end: end, config: config)
			layer.addSublayer(horizontalScaleLine)
		}


		// vertical
		let verticalEdgeOffset = frame.height / CGFloat(column + 1)
		let verticalDistance = frame.height / CGFloat(column + 1)
		let vOffset = config.lineWidth / 2
		for index in 0..<column {
			let verticalScaleLine = ChartStraightLine()
			let yPosition = CGFloat(index) * verticalDistance + verticalEdgeOffset
			let start = CGPoint(x: 0, y: frame.height - yPosition + vOffset)
			let end = CGPoint(x: frame.width, y: frame.height - yPosition + vOffset)
			verticalScaleLine.makeLine(start: start, end: end, config: config)
			layer.addSublayer(verticalScaleLine)
		}
	}


}
