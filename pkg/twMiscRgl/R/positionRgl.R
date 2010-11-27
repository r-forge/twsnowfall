view3dTiltSpin <- function(
	### Adjusting the rgl viewing position by first tilting to front and then spinning to right.
	spin=-20	##<< spinning angle in degree
	,tilt=20	##<< tilting angle in degree
){
	M <- rotationMatrix((-90+tilt)*pi/180, 1,0,0)	# looking a bit from above
	par3d(userMatrix = rotate3d(M, spin*pi/180, 0, 0, 1) )	# spinning a bit to the left
	return(invisible(M))
	### the tilted but not spinned userMatrix
}
attr(view3dTiltSpin,"ex") <- function(){
	plot3d( cube3d(col="green") )
	view3dTiltSpin()
	view3dTiltSpin(70)	#spinning70 degress
}

movie3dRound <- function(
	### Generating a movie of a full round
	movie="movie"
	,frameTime=1	##<< number of seconds for displying a frame
	,duration=frameTime*12	##<< number of seconds for the full rotation
	,dir = tempdir()		##<< A directory in which to create temporary files for each frame of the movie 
	,...			##<< further arguments to \code{\link{movie3d}}
){
	##details<<
	## The default parameterization provides 12 views, in analogy of the clock
	movie3d(spin3d(rpm=60/duration), fps=1/frameTime, duration=duration, movie = movie, dir=dir, ...)	#full round in 12 seconds
	dir
	### The directory where the movie was generated 	
}
attr(view3dTiltSpin,"ex") <- function(){
	.tmp.f <- function(){	# wrapped inside function, because it takes long 
		view3d(fov = 10, zoom = 0.8)	
		view3dTiltSpin()
		plot3d( cube3d(col="green") )
		dir <- movie3dRound("testCube")	
		#avi does not work dir <- movie3dRound("testCube",type="avi")	#doees not work	
		#dir <- movie3dRound("testCube",1/22,type="mpeg", duration=12)	
		copy2clip(dir)			# the directory where the movie was generated
	}
}