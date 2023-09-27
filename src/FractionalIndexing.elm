module FractionalIndexing exposing (..)

import Html exposing (a)



-- https://observablehq.com/@dgreensp/implementing-fractional-indexing


midpoint : String -> String -> String
midpoint a b =
    let
        commonPrefix =
            findCommonStringPrefix a b

        newA =
            String.slice (String.length commonPrefix) (String.length a) a

        newB =
            String.slice (String.length commonPrefix) (String.length b) b
    in
    if String.length commonPrefix > 0 then
        let
            _ =
                Debug.log "CP" [ commonPrefix, newA, newB ]
        in
        String.join ""
            [ commonPrefix
            , midpoint
                newA
                newB
            ]

    else
        let
            floatA =
                String.toInt a |> Maybe.withDefault 0 |> toFloat

            floatB =
                String.toInt b |> Maybe.withDefault 9 |> toFloat
        in
        -- first digits (or lack of digit) are different
        if floatB - floatA > 1 then
            let
                midDigit =
                    round <| 0.5 * (floatA + floatB)
            in
            String.fromInt midDigit

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


allDigits =
    "0123456789"



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
