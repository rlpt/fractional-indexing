module FractionalIndexing exposing (..)

import Html exposing (a)



-- https://observablehq.com/@dgreensp/implementing-fractional-indexing


midpoint : String -> String -> String
midpoint a b =
    let
        digitA =
            String.toInt a |> Maybe.withDefault 0 |> toFloat

        digitB =
            String.toInt b |> Maybe.withDefault 9 |> toFloat
    in
    if digitB - digitA > 1 then
        let
            midDigit =
                round <| 0.5 * (digitA + digitB)
        in
        ""

    else
        --first digits are consecutive
        ""


findCommonStringPrefix : String -> String -> String
findCommonStringPrefix a b =
    findCommonPrefix [] (String.toList a) (String.toList b)


findCommonPrefix : List Char -> List Char -> List Char -> String
findCommonPrefix prefix aa bb =
    let
        a =
            List.head aa |> Maybe.withDefault '0'

        maybeB =
            List.head bb
    in
    case maybeB of
        Just b ->
            if a == b then
                -- Keep going
                let
                    prefix_ =
                        prefix ++ [ a ]
                in
                findCommonPrefix prefix_ (List.tail aa |> Maybe.withDefault []) (List.tail bb |> Maybe.withDefault [])

            else
                String.fromList prefix

        Nothing ->
            String.fromList prefix


type Idx
    = Blank
    | Valid { raw : String }


parseIdx : Maybe String -> Result String Idx
parseIdx maybeIdxStr =
    -- TODO check for trailing 0
    case maybeIdxStr of
        Just idxStr ->
            if String.isEmpty idxStr then
                Ok Blank

            else
                Ok (Valid { raw = idxStr })

        Nothing ->
            Ok Blank


zero =
    "0"


end =
    "9"



-- generateKeyBetween : (Maybe String) -> (Maybe String) -> Result String String
-- generateKeyBetween a b =
--     case (a, b) of
--         (Just a_, Just b_) ->
--             Ok ""
--         _ ->
--             Ok ""
-- generateNKeysBetween : (Maybe String) -> (Maybe String) -> Int -> String -> List String
-- generateNKeysBetween a b n digits =
--     []
