//
//  ChartData.swift
//  DYChartClass
//
//  Created by macbook on 2020-01-14.
//  Copyright © 2020 Dan's Studio. All rights reserved.
//

import UIKit

struct ChartData {

	enum masterType {
		case twoD, circle
	}

	enum type {
		case pie, doughnut, line, guages, area, verticalBar, bar
	}

	var dataValues: [Int]
	var name: String
	var title: String



}

struct basicLineChartConfig { //Entity
	var verticalTitle: String?
	var verticalScaleTitles: [String]?
	var horizontalTitle: String?
	var horizontalScaleTitles: [String]?
	var valuesArray: [Int]?
	var valuesArraySets: [Int]?
	
}
