module FractionalIndexing exposing (..)

import Html exposing (a)



-- https://observablehq.com/@dgreensp/implementing-fractional-indexing


generateKeyBetween : Maybe String -> Maybe String -> Result String String
generateKeyBetween a b =
    Ok ""


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
        commonPrefix
            ++ midpoint
                newA
                newB

    else
        -- At this point strings do not have a common prefix
        let
            indexOfDigit digit default =
                String.indexes digit base62Digits |> List.head |> Maybe.withDefault default

            digitA =
                if String.isEmpty a then
                    0

                else
                    indexOfDigit a 0

            digitB =
                if String.isEmpty b then
                    String.length base62Digits

                else
                    indexOfDigit b (String.length base62Digits)
        in
        if digitB - digitA > 1 then
            let
                midDigit =
                    round <| 0.5 * (toFloat digitA + toFloat digitB)
            in
            getBase62FromIndex midDigit

        else
        --first digits are consecutive
        if
            String.length b > 1
        then
            String.slice 0 1 b

        else
            let
                aTail =
                    String.slice 1 (String.length a) a
            in
            getBase62FromIndex digitA ++ midpoint aTail ""


getBase62FromIndex : Int -> String
getBase62FromIndex idx =
    getAt idx (String.toList base62Digits) |> Maybe.map String.fromChar |> Maybe.withDefault ""


getAt : Int -> List a -> Maybe a
getAt index list =
    List.foldl
        (\item ( i, result ) ->
            if i == index then
                ( i + 1, Just item )

            else
                ( i + 1, result )
        )
        ( 0, Nothing )
        list
        |> Tuple.second


charCodeAt : Int -> String -> Maybe Int
charCodeAt index str =
    String.toList str
        |> getAt index
        |> Maybe.map Char.toCode


getIntegerLength : Char -> Result String Int
getIntegerLength head =
    if head >= 'a' && head <= 'z' then
        Ok <|
            Char.toCode head
                - Char.toCode 'a'
                + 2

    else if head >= 'A' && head <= 'Z' then
        Ok <|
            Char.toCode 'Z'
                - Char.toCode head
                + 2

    else
        Err <| "invalid order key head: " ++ String.fromChar head


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


base62Digits =
    "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
