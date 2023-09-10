module FractionalIndexTest exposing (..)

import Expect exposing (Expectation)
import FractionalIndexing exposing (findCommonPrefix)
import Test exposing (..)


suite : Test
suite =
    test "findCommonPrefix" <|
        \_ ->
            Expect.equal (findCommonPrefix "123" "123004") "12300"
