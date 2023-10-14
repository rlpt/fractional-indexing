module FractionalIndexTest exposing (..)

import Expect exposing (Expectation)
import FractionalIndexing exposing (generateKeyBetween, generateNKeysBetween)
import Test exposing (..)


suite : Test
suite =
    describe "FractionalTest"
        [ testGenerateKeyBetween "" "" (Ok "a0")
        , testGenerateKeyBetween "" "a0" (Ok "Zz")
        , testGenerateKeyBetween "" "Zz" (Ok "Zy")
        , testGenerateKeyBetween "a0" "" (Ok "a1")
        , testGenerateKeyBetween "a1" "" (Ok "a2")
        , testGenerateKeyBetween "a0" "a1" (Ok "a0V")
        , testGenerateKeyBetween "a0V" "a1" (Ok "a0l")
        , testGenerateKeyBetween "Zz" "a0" (Ok "ZzV")
        , testGenerateKeyBetween "Zz" "a1" (Ok "a0")
        , testGenerateKeyBetween "" "Y00" (Ok "Xzzz")
        , testGenerateKeyBetween "bzz" "" (Ok "c000")
        , testGenerateKeyBetween "a0" "a0V" (Ok "a0G")
        , testGenerateKeyBetween "a0" "a0G" (Ok "a08")
        , testGenerateKeyBetween "b125" "b129" (Ok "b127")
        , testGenerateKeyBetween "a0" "a1V" (Ok "a1")
        , testGenerateKeyBetween "Zz" "a01" (Ok "a0")
        , testGenerateKeyBetween "" "a0V" (Ok "a0")
        , testGenerateKeyBetween "" "b999" (Ok "b99")
        , testGenerateKeyBetween ""
            "A00000000000000000000000000"
            (Err "invalid order key: A00000000000000000000000000")
        , testGenerateKeyBetween ""
            "A000000000000000000000000001"
            (Ok "A000000000000000000000000000V")
        , testGenerateKeyBetween "zzzzzzzzzzzzzzzzzzzzzzzzzzy"
            ""
            (Ok "zzzzzzzzzzzzzzzzzzzzzzzzzzz")
        , testGenerateKeyBetween "zzzzzzzzzzzzzzzzzzzzzzzzzzz"
            ""
            (Ok "zzzzzzzzzzzzzzzzzzzzzzzzzzzV")
        , testGenerateKeyBetween "a00"
            ""
            (Err "invalid order key: a00")
        , testGenerateKeyBetween "a00"
            "a1"
            (Err "invalid order key: a00")
        , testGenerateKeyBetween "0"
            "1"
            (Err "invalid order key head: 0")
        , testGenerateKeyBetween "a1"
            "a0"
            (Err "a1 >= a0")
        , testGenerateNKeysBetween
            ""
            ""
            5
            (Ok "a0 a1 a2 a3 a4")
        , testGenerateNKeysBetween
            "a4"
            ""
            10
            (Ok "a5 a6 a7 a8 a9 aA aB aC aD aE")
        , testGenerateNKeysBetween
            ""
            "a0"
            5
            (Ok "Zv Zw Zx Zy Zz")
        , testGenerateNKeysBetween
            "a0"
            "a2"
            20
            (Ok "a04 a08 a0G a0K a0O a0V a0Z a0d a0l a0t a1 a14 a18 a1G a1O a1V a1Z a1d a1l a1t")
        ]


null : String -> String
null s =
    if String.isEmpty s then
        "null"

    else
        s


testGenerateKeyBetween : String -> String -> Result String String -> Test
testGenerateKeyBetween a b expected =
    test ("generateKeyBetween " ++ null a ++ " " ++ null b) <|
        \_ ->
            Expect.equal
                (generateKeyBetween a b)
                expected


testGenerateNKeysBetween : String -> String -> Int -> Result String String -> Test
testGenerateNKeysBetween a b n expected =
    test ("generateNKeysBetween " ++ null a ++ " " ++ null b ++ " " ++ String.fromInt n) <|
        \_ ->
            Expect.equal
                (generateNKeysBetween a b n |> Result.map (String.join " "))
                expected
