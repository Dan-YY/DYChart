//
//  Chart2DAxisView.swift
//  DYChartClass
//
//  Created by macbook on 2020-01-16.
//  Copyright © 2020 Dan's Studio. All rights reserved.
//

import UIKit

class Chart2DAxisView: UIView {
	var title: String?
	//var measureFormatType: MeasureFormatType = .day
	var scaleCount: Int = 10
	var range: ClosedRange<Int>?
	var scaleTitles: [String]?
}
