module Export where

-- тут типы из GCode превращаются в тестовый вид для станка

import GCode hiding (main)
import Control.Monad.Writer
import Test.HUnit
import TestExt

type CNC = Writer [Command] Command

write f = writer (aa, [aa]) where aa = f

g0 :: [Position] -> CNC
g0 l = write $ G0 l

g1 :: [Position] -> CNC
g1 l = write $ G1 l

g2 :: [Position] -> CNC
g2 l = write $ G2 l

g3 :: [Position] -> CNC
g3 l = write $ G3 l

f :: Double -> CNC
f a = write $ F a

--экспортирует программу в консоль
export f = 
	mapM_ (putStrLn.show) y
	where (_, y) = runWriter f



testUP a b c = areEqual c (export' a) b

tests = [
	assertCNC "test_01" 
			 (do 
			 	g0 [X 0] 
			 	g0 [Y 0])
			 "G0 X0.0\nG0 Y0.0\n"
	]

main = do
	testing Export.tests