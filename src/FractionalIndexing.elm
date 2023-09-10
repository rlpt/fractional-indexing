module FractionalIndexing exposing (..)

-- https://observablehq.com/@dgreensp/implementing-fractional-indexing


findCommonPrefix : String -> String -> String
findCommonPrefix a b =
    findCommonPrefix_ [] (String.toList a) (String.toList b)


findCommonPrefix_ : List Char -> List Char -> List Char -> String
findCommonPrefix_ prefix aa bb =
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
                findCommonPrefix_ prefix_ (List.tail aa |> Maybe.withDefault []) (List.tail bb |> Maybe.withDefault [])

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


base62Digits =
    "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"


zero =
    "0"
