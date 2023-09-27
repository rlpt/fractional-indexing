module FractionalIndexTest exposing (..)

import Expect exposing (Expectation)
import FractionalIndexing exposing (findCommonStringPrefix)
import Test exposing (..)


suite : Test
suite =
    describe "findCommonPrefix"
        [ test "123 123004" <|
            \_ ->
                Expect.equal (findCommonStringPrefix "123" "123004") "12300"
        , test "12 123004" <|
            \_ ->
                Expect.equal (findCommonStringPrefix "12" "123004") "12"
        , test "12345678 12345678" <|
            \_ ->
                Expect.equal (findCommonStringPrefix "12345678" "12345678") "12345678"
        ]
