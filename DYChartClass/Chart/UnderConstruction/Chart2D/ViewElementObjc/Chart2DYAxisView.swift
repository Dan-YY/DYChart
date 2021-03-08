//
//  Chart2DYAxisView.swift
//  DYChartClass
//
//  Created by macbook on 2020-01-20.
//  Copyright © 2020 Dan's Studio. All rights reserved.
//

import UIKit

class Chart2DYAxisView: Chart2DAxisView {
	let config: Chart2DAxisConfig

	init(frame: CGRect, config: Chart2DAxisConfig) {
		self.config = config
		super.init(frame: frame)
		commonInit()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func commonInit() {
		let row = config.unitCount
		//print(frame.height, self.frame.height, frame.height / CGFloat(row))
		let distance = frame.height / CGFloat(row - 1)
		for i in 0..<row {
			let rect = CGRect(x: 0, y: 0, width: distance * 0.8, height: 30)
			let label = UILabel(frame: rect)
			label.textColor = .label
			label.font = UIFont.systemFont(ofSize: 15, weight: .light)
			label.text = config.labelArray[i]
			//label.textAlignment = .left
			label.sizeToFit()

			let offset: CGFloat
			if i == 0 {
				offset = -label.frame.height / 2 - 3
			} else if i == row - 1 {
				offset = label.frame.height / 2 + 3
			} else {
				offset = 0
			}
			var positionX: CGFloat

			switch config.labelPositionType {
			case .outside:
				positionX = frame.width - label.frame.width - 5
			case .inside:
				positionX = frame.width
			}

			label.frame.origin = CGPoint(x: positionX, y: frame.height - distance * CGFloat(i) - label.frame.height / 2 + offset)
			addSubview(label)
		}
	}
}
