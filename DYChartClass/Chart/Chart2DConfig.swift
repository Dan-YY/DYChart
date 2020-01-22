//
//  Chart2DConfig.swift
//  DYChartClass
//
//  Created by macbook on 2020-01-21.
//  Copyright © 2020 Dan's Studio. All rights reserved.
//

import UIKit

struct Chart2DConfig {


	var yAxisLowerBound = 0
	var yAxisUpperBound = 100
	var yAxisUnitsCount = 5
	var yAxisValueFormat: NumberFormatter?
	var xAxisLowerBound = 0
	var xAxisUpperBound = 100
	var xAxisUnitsCount = 5
	var xAxisValueFormat: NumberFormatter?



}

struct Chart2DConfigration {
//	enum gridType {
//		case non, thinX, thinXY, thinY
//	}
	var xAxisConfig = Chart2DAxisConfig()
	var yAxisConfig = Chart2DAxisConfig()
	var graphBackConfig = Chart2DGraphBackConfig()
	var dataConfig = Chart2DDataConfig()
}

struct Chart2DDataConfig {
	enum ShapeType {
		case dot, circle, square
	}
	enum AnimationState {
		case before, after, autoPlay
	}
	var shapeType: ShapeType = .circle
	var strokeLineWidth: CGFloat = 2
	var fillColor: UIColor = .systemRed
	var strokeColor: UIColor = .systemGreen
	var size: CGSize = CGSize(width: 3, height: 3)
	var animation: AnimationState = .after
	//var image: UIImage
}

struct Chart2DGraphBackConfig {
	enum EdgeType {
		case topBot, leftBot, all
	}
	var edgeType: EdgeType = .topBot
	var horizontalLineCount = 0
	var verticalLineCount = 0
	var horizontalLineWidth: CGFloat = 2
	var verticalLineWidth: CGFloat = 2
}

struct Chart2DDotConfig {
	enum ShapeType {
		case dot, circle, square
	}
	var shapeType: ShapeType = .dot
	var fillColor: UIColor?
	var strokeColor: UIColor?
	var size: CGSize
	//var image: UIImage
}

class Chart2DAxisConfig {

	// for all
	var unitCount: Int
	var labelArray: [String]

	var labelStyle: LabelStyle = .normal
	var labelPositionType: LabelPositionType = .outside

	// for range
	var lowerBound: Double?
	var upperBound: Double?

	enum DateFormatType {
		case day, month, year, dayMonth, monthYear, dayMonthYear, auto
	}

	enum LabelStyle {
		case normal, angled30, angled45, doubleLine, date
	}

	enum LabelPositionType {
		case outside, inside
	}

	init() {
		let array = ["0", "25", "50", "75", "100"]
		self.unitCount = array.count
		self.labelArray = array
	}

	init(with dates: [Date], dateStyle: DateFormatType) {
		self.unitCount = dates.count
		let formatter = DateFormatter()
		formatter.dateFormat = "MMM,d,yyyy"
		labelArray = dates.map({ formatter.string(from: $0 as Date) })
	}

	init(with dates: [Date], dateStyle: DateFormatType, maxUnits: Int) {
		self.labelArray = Chart2DDateFormatter.formatForChart(dates: dates, maxUnits: maxUnits)
		self.unitCount = maxUnits
	}

	init(with items: [String]) {
		self.unitCount = items.count
		labelArray = items
	}

	init(withRange lowerBound: Double, upperBound: Double, formate: NumberFormatter, numberOfUnitsDisplayed: Int) {
		self.unitCount = numberOfUnitsDisplayed
		self.lowerBound = lowerBound
		self.upperBound = upperBound
		let range = upperBound - lowerBound
		var array = [String]()

		if numberOfUnitsDisplayed == 1 {
			// display upper bound
			array.append(String(lowerBound))
		} else if numberOfUnitsDisplayed == 2 {
			// display upperbound and lower bound
			array.append(String(lowerBound))
			array.append(String(upperBound))
		} else {
			let unitValue = range / Double((numberOfUnitsDisplayed - 1))
			for index in 0..<numberOfUnitsDisplayed {
				let value = lowerBound + unitValue * Double(index)
				array.append(String(value))
			}
		}
		self.labelArray = array
	}



	
}




struct Chart2DDateFormatter {

	static func formatForChart(dates: [Date], maxUnits: Int) -> [String] {

		let formatter = DateFormatter()
		formatter.dateFormat = "MMM.dd\nyyyy"
		let maxComponent = 1

		let yearFormatter = DateFormatter()
		yearFormatter.dateFormat = "yyyy"
		let monthFormatter = DateFormatter()
		monthFormatter.dateFormat = "MMM"
		let dayFormatter = DateFormatter()
		dayFormatter.dateFormat = "dd"
		let timeFormatter = DateFormatter()
		timeFormatter.dateFormat = "h:mm"
		var lastYear = ""
		var lastMonth = ""
		var lastDay = ""
		var stringArray = [String]()

		for date in dates {
			var string = ""
			var currentComponent = 0
			let year = yearFormatter.string(from: date)
			let month = monthFormatter.string(from: date)
			let day = dayFormatter.string(from: date)

			if lastYear != year {
				lastYear = year
				string.append(year)
				currentComponent += 1
			}
			if currentComponent >= maxComponent {
				stringArray.append(string)
				continue
			}
			if lastMonth != month {
				lastMonth = month
				string.append(month)
				currentComponent += 1
			}
			if currentComponent >= maxComponent {
				stringArray.append(string)
				continue
			}
			if lastDay != day {
				lastDay = day
				string.append(day)
				currentComponent += 1
			}
			if currentComponent == 0 {
				let time = timeFormatter.string(from: date)
				string.append(time)
			}
			stringArray.append(string)
		}

		return stringArray
	}
}
