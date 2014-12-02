module Trajectory where
-- описание траектории (горизонтальной)
import Test.HUnit
import TestExt

import Utils hiding (main)
import Export hiding (main)
import GCode hiding (main)
import Geometry hiding (main)
import Control.Monad.Writer

data TSegment = 
		--прямой отрезок
		TLine Double Double
		-- дуга (x, y центра, радиус, угол начала, угол конца, направление)
	|	TArc Double Double Double Double Double Direction 
	deriving (Show)

type Trajectory = [TSegment]

trajectory2GCode :: Trajectory -> CNC
trajectory2GCode (x : xs) = do
	g0 [X 1, Y 2, Z 3]

--получить первую позицию у траектории
getFirstPosition :: Trajectory -> (Double, Double)
getFirstPosition (TLine x y:_) = (x, y) 
getFirstPosition (TArc x y r a1 a2 d:_) = (x, y)

--получить начало дуги
getArcBegin :: TSegment -> (Double, Double)
getArcBegin (TArc x, y, r, a1, a2, _ ) = rotatePoint (r, 0) (x, y) a1 CCW

tests = [
	areEqual "Trajectory.test_01" 
		(getFirstPosition [TLine 10 11])
		(10, 11),

	areEqual "Trajectory.test_02" 
		(getFirstPosition [TArc 0 0 10 0 90 CCW])
		(10, 0),

	areEqual "Trajectory.test_03" 
		(getFirstPosition [TArc 3 0 10 0 90 CCW])
		(13, 0),

	areEqual "Trajectory.test_04" 
		(getFirstPosition [TArc 10 10 10 0 90 CCW])
		(20, 10)
	]

main = do
	testing Trajectory.tests
	--export $ trajectory2GCode []