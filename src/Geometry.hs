module Geometry where
--функциюю для работы с геометрией
import Test.HUnit
import TestExt
import Utils hiding (main)

--развернуть точку вокруг другой точки на определенный угол  определенном направлении
rotatePoint :: 	(Double, Double) -> (Double, Double) -> Double -> Direction -> (Double, Double)
rotatePoint (px, py) (cx, cy) a dir = (x, y)
	where 
		x = rnd (x' + cx) 5
		y = rnd (y' + cy) 5
		aa = if( dir == CCW ) then (a2r a) else (a2r (-a)) -- в какую сторону вращать
		x' = (px - cx)*(cos aa) - (py - cy)*(sin aa)
		y' = (px - cx)*(sin aa) + (py - cy)*(cos aa)

--перевести радианы в градусы
a2r :: Double -> Double
a2r a = a*pi/180

--перевести градусы в радианы
r2a :: Double -> Double
r2a r = r*180.0/pi

tests = [
	areEqual "Geometry.test_01"
			 (rotatePoint (10, 0) (0, 0) 90 CCW)
			 (0, 10),
	areEqual "Geometry.test_02"
			 (rotatePoint (10, 0) (0, 0) 90 CW)
			 (0, -10),
	areEqual "Geometry.test_03"
			 (rotatePoint (20, 0) (12, 0) 90 CCW)
			 (12, 8),
	areEqual "Geometry.test_04"
			 (rotatePoint (20, 0) (12, 0) 90 CW)
			 (12, -8),

	-- развороты через ось Х
	areEqual "Geometry.test_05"
			 (rotatePoint (20, -20) (0, 0) 90 CCW)
			 (20, 20),
	areEqual "Geometry.test_05"
			 (rotatePoint (20, 20) (0, 0) 90 CW)
			 (20, -20)
	]

main = do
	testing $ Geometry.tests