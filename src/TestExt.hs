module TestExt where
--небольшой модуль для более удобного написания тестирования
import Test.HUnit
import Control.Monad.Writer

--создаем тесто для проверки равенства
areEqual ::(Eq a, Show a) => String -> a -> a -> Test
areEqual comment left right = TestLabel comment $ TestCase $ left @?= right

--другая функция экспорта, для тестирования
export' :: Show a => Writer [a] t -> String
export' f = 
	unlines $ map (show) y
	where (_, y) = runWriter f

assertCNC :: Show a => String -> Writer [a] t -> String -> Test
assertCNC comment up ok = TestLabel comment $ TestCase $(export' up) @?= ok

--запускает тесты из списка
testing :: [Test] -> IO Counts
testing l = runTestTT $ TestList l



--main = runTestTT $ TestList [areEqual 1 2 "33"]
