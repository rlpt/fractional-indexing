module FractionalIndexTest exposing (..)

import Expect exposing (Expectation)
import FractionalIndexing exposing (findCommonStringPrefix, midpoint)
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
        , test "mid" <|
            \_ ->
                Expect.equal (midpoint "1992" "1993") "19925"
        , test "mid 2" <|
            \_ ->
                Expect.equal (midpoint "45" "47") "46"
        , test "mid 3" <|
            \_ ->
                Expect.equal (midpoint "123" "123004") "123002"
        ]
