//
//  ChartData.swift
//  DYChartClass
//
//  Created by macbook on 2020-01-14.
//  Copyright © 2020 Dan's Studio. All rights reserved.
//

import UIKit

struct ChartData {

	var dataValues: [Int]
	var name: String
	var title: String

	enum MasterType {
		case twoD, circle
	}

	enum ChartType {
		case pie, doughnut, line, guages, area, verticalBar, bar
	}
}

struct BasicLineChartConfig { //Entity
	var verticalTitle: String?
	var verticalScaleTitles: [String]?
	var horizontalTitle: String?
	var horizontalScaleTitles: [String]?
	var valuesArray: [Int]?
	var valuesArraySets: [Int]?

}


/**

//	private func setupCurrent() {
//		let rect = CGRect(x: sw * 0.05, y: sh * 0.55, width: sw * 0.9, height: sw * 0.8)
//		let chart = ChartProgress(frame: rect, xAxisSectionHeight: sw * 0.1, yAxisSectionWidth: sw * 0.1)
//		view.addSubview(chart)
//	}
*/
