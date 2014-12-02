--в этом модуле объединены все доступные извне функции
module Cnc 
(  
	GCode.Position (..)
	,Export.g0
	,Export.export
	,Export.CNC (..)
	,Utils.for
)
where
import GCode hiding (main)
import Utils hiding (main) 
import Export hiding (main) 
import Geometry hiding (main)
import Trajectory hiding (main)
import Test.HUnit

main = do
	runTestTT $ TestList $ concat [Utils.tests, GCode.tests, 
		Export.tests, Geometry.tests, Trajectory.tests]
	
