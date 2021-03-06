# DYChart for Swift

Easy setup chart class

Including circle dashboard and 2DChart

Both with animation and variety of config to customize.

![alt text](http://www.dansstudio.ca/resources/pubSha/ChartDemoGIF.gif.opt584x1244o0%2C0s584x1244.gif "Logo Title Text 1")


Circle/Semi Chircle dashboard sample:

	let dashCircle = DYDashboardCircle()
	dashCircle.value(to: 0.9, animated: true)
	dashCircle.layoutSubviews()
	view.addSubview(dashCircle)

other config:

	var circleColors: [UIColor] 
  Any systemColor or define your RGB colors, any number of them. It will be mixed as gradient by default
  
	var circleLineWidth: CGFloat 
  
	var colorType: ColorType 
  .gradient, .block
  
	var startPosition: KeyPosition 
  (.left , .right, .top, .bottom) set it as zero/starting point
  
	var circleType: CircleType  
  .circle, .semiCircle
  

2DChart: (still under development, some function may not work as expected)
