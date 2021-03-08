//
//  DYConsFixDate.swift
//  DYChartClass
//
//  Created by macbook on 2020-01-21.
//  Copyright © 2020 Dan's Studio. All rights reserved.
//

import UIKit

struct DYConsFixDate {

	let formatter: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy//MM/dd HH:mm"
		return formatter
	}()

	func getSameMonth(_ count: Int) -> [Date] {
		let dateStart = Date(timeIntervalSince1970: 100000)
		let increasement = TimeInterval(exactly: 100000)

		var array = [Date]()
		for i in 0..<count {
			let next = dateStart + TimeInterval(i) * increasement!
			array.append(next)
		}
		return array
	}

	func getSameYear(_ count: Int) -> [Date] {
		let dateStart = Date(timeIntervalSince1970: 100000)
		let increasement = TimeInterval(exactly: 2000000)

		var array = [Date]()
		for i in 0..<count {
			let next = dateStart + TimeInterval(i) * increasement!
			array.append(next)
		}
		return array
	}

	func getDifferentYear(_ count: Int) -> [Date] {
		let dateStart = Date(timeIntervalSince1970: 100000)
		let increasement = TimeInterval(exactly: 100000000)

		var array = [Date]()
		for i in 0..<count {
			let next = dateStart + TimeInterval(i) * increasement!
			array.append(next)
		}
		return array
	}

	func getRandom(_ count: Int) -> [Date] {
		var dateStart = Date(timeIntervalSince1970: 100000)

		var array = [Date]()
		for i in 0..<count {
			let random = Int.random(in: 0...10000000)
			let increasement = TimeInterval(exactly: random)
			let next = dateStart + TimeInterval(i) * increasement!
			array.append(next)
			dateStart = next
		}
		return array
	}

	private func printDate(date: Date) {
		print(formatter.string(from: date))
	}

}
