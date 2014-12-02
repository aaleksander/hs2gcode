module Meta where
--мета - траектории
import Test.HUnit
import TestExt
import GCode hiding (main)
import Export hiding (main)
import Utils hiding (main)

data MPoint = 
		MPnt Double Double  			-- обычная точка (угол)
	| 	MRound Double Double Double   	-- скругленный угол
	|	MCircle Double Double Double	-- окружность с радиусом
	deriving (Show, Eq)

--преобразует траекторию в g-код
--meta2Trajectory :: [MPoint] -> Direction -> Double -> CNC
--meta2GCode l dir safeZ = undefined

tests = []
--	assertCNC "Meta.test_01"
--			  (meta2GCode [MPnt 0 0, MPnt 10 0, MPnt 10 10, MPnt 0 10] CW 5)
--			  "dd"
--	]



--main = do
--	testing Meta.tests