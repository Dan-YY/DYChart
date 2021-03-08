//
//  Chart2DDot.swift
//  DYChartClass
//
//  Created by macbook on 2020-01-22.
//  Copyright © 2020 Dan's Studio. All rights reserved.
//

import UIKit

class Chart2DDot: CAShapeLayer {
	var startPosition: CGPoint?
	var endPosition: CGPoint?
	var yOffset: CGFloat?
}

class Chart2DLine: ChartStraightLine {
	var positionA: CGPoint?
	var positionB: CGPoint?
}
