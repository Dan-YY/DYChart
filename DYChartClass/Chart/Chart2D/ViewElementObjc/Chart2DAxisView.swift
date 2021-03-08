//
//  Chart2DAxisView.swift
//  DYChartClass
//
//  Created by macbook on 2020-01-16.
//  Copyright © 2020 Dan's Studio. All rights reserved.
//

import UIKit

//abstract
class Chart2DAxisView: UIView {
	var title: String?
	var scaleCount: Int = 5
	var range: ClosedRange<Int>?
	var scaleTitles: [String]?

	var style: Style = .iOS

	override init(frame: CGRect) {
		super.init(frame: frame)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

//Mark: Class enum
extension Chart2DAxisView {
	enum Style {
		case iOS, classic
	}
}
