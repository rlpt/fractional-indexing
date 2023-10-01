module FractionalIndexTest exposing (..)

import Expect exposing (Expectation)
import FractionalIndexing exposing (findCommonStringPrefix, generateKeyBetween, getIntegerLength, getIntegerPart, incrementInteger, midpoint, validateOrderKey)
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
        , test "validateOrderKey A00000000000000000000000000" <|
            \_ ->
                Expect.equal
                    (validateOrderKey "A00000000000000000000000000")
                    (Err "invalid order key: A00000000000000000000000000")
        , test "validateOrderKey a00" <|
            \_ ->
                Expect.equal
                    (validateOrderKey "a00")
                    (Err "invalid order key: a00")
        , test "validateOrderKey a0" <|
            \_ ->
                Expect.equal
                    (validateOrderKey "a0")
                    (Ok "a0")
        , test "incrementInteger a0" <|
            \_ ->
                Expect.equal
                    (incrementInteger "a0")
                    (Just "a1")

        -- , test "incrementInteger bzz" <|
        --     \_ ->
        --         Expect.equal
        --             (incrementInteger "bzz")
        --             (Just "bz0")
        --      const BASE_62_DIGITS = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
        , test "incrementInteger bzz" <|
            \_ ->
                Expect.equal
                    (incrementInteger "bzz")
                    (Just "c000")
        , test "generateKeysBetween" <|
            \_ ->
                Expect.equal
                    (generateKeyBetween "" "")
                    (Ok "a0")
        , test "generateKeysBetween a0 a1" <|
            \_ ->
                Expect.equal
                    (generateKeyBetween "a0" "a1")
                    (Ok "a0V")
        , test "generateKeysBetween a1 a2" <|
            \_ ->
                Expect.equal
                    (generateKeyBetween "a1" "a2")
                    (Ok "a1V")
        , test "generateKeysBetween a0V a1" <|
            \_ ->
                Expect.equal
                    (generateKeyBetween "a0V" "a1")
                    (Ok "a0l")
        , test "generateKeysBetween Zz a0" <|
            \_ ->
                Expect.equal
                    (generateKeyBetween "Zz" "a0")
                    (Ok "ZzV")
        , test "generateKeysBetween Zz a1" <|
            \_ ->
                Expect.equal
                    (generateKeyBetween "Zz" "a1")
                    (Ok "a0")
        , only <|
            test "generateKeysBetween null Y00" <|
                \_ ->
                    Expect.equal
                        (generateKeyBetween "" "Y00")
                        (Ok "Xzzz")

        -- test(null, "Y00", "Xzzz");
        -- test(null, "a0V", "a0");
        -- test(null, "b999", "b99");
        ]
