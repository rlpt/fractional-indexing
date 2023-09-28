module FractionalIndexTest exposing (..)

import Expect exposing (Expectation)
import FractionalIndexing exposing (findCommonStringPrefix, getIntegerLength, getIntegerPart, midpoint)
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
        , test "getIntegerLength a" <|
            \_ ->
                Expect.equal (getIntegerLength 'a') (Ok 2)
        , test "getIntegerLength d" <|
            \_ ->
                Expect.equal (getIntegerLength 'd') (Ok 5)
        , test "getIntegerLength z" <|
            \_ ->
                Expect.equal (getIntegerLength 'z') (Ok 27)
        , test "getIntegerLength A" <|
            \_ ->
                Expect.equal (getIntegerLength 'A') (Ok 27)
        , test "getIntegerLength D" <|
            \_ ->
                Expect.equal (getIntegerLength 'D') (Ok 24)
        , test "getIntegerLength Z" <|
            \_ ->
                Expect.equal (getIntegerLength 'Z') (Ok 2)
        , test "getIntegerPart a0" <|
            \_ ->
                Expect.equal (getIntegerPart "a0") (Ok "a0")
        , test "getIntegerPart Zz" <|
            \_ ->
                Expect.equal (getIntegerPart "Zz") (Ok "Zz")
        , test "getIntegerPart a0V" <|
            \_ ->
                Expect.equal (getIntegerPart "a0V") (Ok "a0")
        , test "getIntegerPart b125" <|
            \_ ->
                Expect.equal (getIntegerPart "b125") (Ok "b12")
        ]
