module Utils where

import Test.HUnit
import TestExt
import Export hiding (main)
import GCode hiding (main)
import Control.Monad.Writer

--всякие полезные штуки

--вызывает фунцию f, передавая ей параметром с шагом z. 
-- Последовательность заканчивается четко на z2
-- step должен быть всегда положительным
for :: (Monad m, Num a, Ord a) => a -> a -> a -> (a -> m b) -> m ()
for z1 z2 step f
	| z1 < z2 = mapM_ f $ for_1 z1 z2 step []
	| z1 >= z2 = mapM_ f $ for_2 z1 z2 step []
	where 
		for_1 v1 v2 step acc
			| v1 < v2 = (for_1 (v1 + step) v2 step (acc ++ [v1]))
			| v1 >= v2 = acc ++ [v2]
		for_2 v1 v2 step acc
			| v1 > v2 = (for_2 (v1 - step) v2 step (acc ++ [v1]))
			| v1 <= v2 = acc ++ [v2]

f11 z = do
	g0 [Z z]

tests = [
	assertCNC "test_01" 
			 (for 1 2 0.5 f11)
			 "G0 Z1.0\nG0 Z1.5\nG0 Z2.0\n",
	assertCNC "test_02" 
			 (for 1 2.2 0.5 f11)
			 "G0 Z1.0\nG0 Z1.5\nG0 Z2.0\nG0 Z2.2\n",
	assertCNC "test_03" 
			 (for 2 1 0.5 f11)
			 "G0 Z2.0\nG0 Z1.5\nG0 Z1.0\n",
	assertCNC "test_04" 
			 (for 2 0.8 0.5 f11)
			 "G0 Z2.0\nG0 Z1.5\nG0 Z1.0\nG0 Z0.8\n"

	]


main = do
	--export $ for 2 1 0.5 f11
	testing Utils.tests
