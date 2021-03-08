//
//  Chart2DXAxisView.swift
//  DYChartClass
//
//  Created by macbook on 2020-01-20.
//  Copyright © 2020 Dan's Studio. All rights reserved.
//

import UIKit

class Chart2DXAxisView: Chart2DAxisView {
	let config: Chart2DAxisConfig
	var xPositionArray = [CGFloat]()

	init(frame: CGRect, config: Chart2DAxisConfig, labelStyle: LabelStyle) {
		self.config = config
		super.init(frame: frame)
		commonInit(labelStyle: labelStyle)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func commonInit(labelStyle: LabelStyle) {
		let labelCount = config.unitCount
		let distance = frame.width / CGFloat(labelCount + 1)
		for i in 0..<labelCount {
			let labelSize = CGSize(width: distance * 0.85, height: frame.height)
			let positionX = distance * CGFloat(i + 1)
			let labelOrigin = CGPoint(x: positionX - labelSize.width / 2.0, y: 0.0)
			let label = UILabel(frame: CGRect(origin: labelOrigin, size: labelSize))
			applyLabelStyle(label: label, labelStyle: labelStyle)
			label.text = config.labelArray[i]
			addSubview(label)
			xPositionArray.append(positionX)
		}
	}

	private func applyLabelStyle(label: UILabel, labelStyle: LabelStyle) {
		switch labelStyle {
		case .angled30: fatalError("under construction")
		case .angled45: fatalError("under construction")
		case .date: fatalError("under construction")
		case .doubleLine: fatalError("under construction")
		case .normal:
			label.adjustsFontSizeToFitWidth = true
			label.textColor = .label
			label.textAlignment = .center
			label.font = UIFont(name: "Menlo", size: 20)
		}
	}
}

//MARK: Class enum
extension Chart2DXAxisView {
	enum LabelStyle {
		case normal, angled30, angled45, doubleLine, date
	}
}
