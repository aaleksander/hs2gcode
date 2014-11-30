module GCode where
import TestExt
import Test.HUnit
--базовые команды станка

--позиционированние
data Position = 
		X Double
	|	Y Double
	| 	Z Double
	|	I Double
	|	J Double

-- команды
data Command =
		G0 [Position]
	|	G1 [Position]
	|	G2 [Position]
	|	G3 [Position]
	|	F Double

instance Show Position where
	show (X var) = "X" ++ (show var)
	show (Y var) = "Y" ++ (show var)
	show (Z var) = "Z" ++ (show var)
	show (I var) = "I" ++ (show var)
	show (J var) = "J" ++ (show var)

instance Show Command where
	show (G0 par) = "G0 " ++ (arr2Str par)
	show (G1 par) = "G1 " ++ (arr2Str par)
	show (G2 par) = "G2 " ++ (arr2Str par)
	show (G3 par) = "G3 " ++ (arr2Str par)
	show (F par) = "F" ++ (show par)

arr2Str :: [Position] -> String
arr2Str l = concat $ map (\x -> show x) l

-- *********************************
-- тесты
-- *********************************

tests = [
	areEqual 	"test_01" 
				(show (X 1))
				"X1.0" ,
	
	areEqual	"test_02" 
				(show (X (-1))) 
				"X-1.0" ,
	
	areEqual	"test_03" 
				(show (G0 [X 1])) 
				"G0 X1.0",

	areEqual	"test_04" 
				(show (G0 [X 1, Y 2])) 
				"G0 X1.0Y2.0",

	areEqual	"test_05"
				(show (F 100))
				"F100.0"
	]


main = testing GCode.tests