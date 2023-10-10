module FractionalIndexing exposing (..)

import Html exposing (a)
import Html.Attributes exposing (id)



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


getIntegerPart : String -> Result String String
getIntegerPart key =
    let
        integerPartLength =
            getIntegerLength (String.toList key |> List.head |> Maybe.withDefault 'a')
    in
    case integerPartLength of
        Ok len ->
            if len > String.length key then
                Err <| "invalid order key: " ++ key

            else
                Ok <| String.slice 0 len key

        Err err ->
            Err err


stringA26Zeros =
    "A" ++ String.repeat 26 zero


validateOrderKey : String -> Result String String
validateOrderKey key =
    if String.isEmpty key then
        Ok key

    else if key == stringA26Zeros then
        Err <| "invalid order key: " ++ key

    else
        case getIntegerPart key of
            Ok i ->
                let
                    f =
                        String.slice (String.length i) (String.length key) key

                    len =
                        String.length f

                    fEnd =
                        String.slice (len - 1) len f
                in
                if fEnd == zero then
                    Err <| "invalid order key: " ++ key

                else
                    Ok key

            Err e ->
                Err e


validateInteger : String -> Result String String
validateInteger int =
    let
        errTxt =
            "invalid integer part of order key: " ++ int

        maybeLength =
            getAt 0 (String.toList int)
                |> Maybe.map getIntegerLength
                |> Maybe.withDefault (Err errTxt)
    in
    case maybeLength of
        Ok len ->
            if len /= String.length int then
                Err errTxt

            else
                Ok int

        Err e ->
            Err e


generateKeyBetween : String -> String -> Result String String
generateKeyBetween unvalidatedA unvalidatedB =
    if unvalidatedA /= "" && unvalidatedB /= "" && unvalidatedA >= unvalidatedB then
        Err (unvalidatedA ++ " >= " ++ unvalidatedB)

    else
        case ( validateOrderKey unvalidatedA, validateOrderKey unvalidatedB ) of
            ( Ok a, Ok b ) ->
                if String.isEmpty a then
                    if String.isEmpty b then
                        Ok (String.fromList [ 'a', firstChar ])

                    else
                        let
                            ib =
                                getIntegerPart b

                            fb =
                                ib |> Result.map (\intPart -> String.slice (String.length intPart) (String.length b) b)
                        in
                        Result.map2
                            (\ib_ fb_ ->
                                if ib_ == stringA26Zeros then
                                    Ok <| ib_ ++ midpoint "" fb_

                                else if ib_ < b then
                                    Ok ib_

                                else
                                    decrementInteger ib_
                                        |> Result.fromMaybe "cannot decrement any more"
                            )
                            ib
                            fb
                            |> Result.andThen identity

                else if String.isEmpty b then
                    let
                        ia =
                            getIntegerPart a

                        -- TODO make own func nonIntegerTail
                        fa =
                            ia |> Result.map (\intPart -> String.slice (String.length intPart) (String.length a) a)

                        -- i = incrementInteger ia
                    in
                    Result.map2
                        (\ia_ fa_ ->
                            let
                                i =
                                    incrementInteger ia_
                            in
                            case i of
                                Nothing ->
                                    Ok <| ia_ ++ midpoint fa_ ""

                                Just i_ ->
                                    Ok i_
                        )
                        ia
                        fa
                        |> Result.andThen identity

                else
                    let
                        ia : Result String String
                        ia =
                            getIntegerPart a

                        fa =
                            ia |> Result.map (\intPart -> String.slice (String.length intPart) (String.length a) a)

                        ib : Result String String
                        ib =
                            getIntegerPart b

                        fb =
                            ib |> Result.map (\intPart -> String.slice (String.length intPart) (String.length b) b)
                    in
                    Result.map4
                        (\ia_ fa_ ib_ fb_ ->
                            let
                                res =
                                    if ia_ == ib_ then
                                        Ok <| ia_ ++ midpoint fa_ fb_

                                    else
                                        case incrementInteger ia_ of
                                            Just i ->
                                                if i < b then
                                                    Ok i

                                                else
                                                    Ok <| ia_ ++ midpoint fa_ ""

                                            Nothing ->
                                                Err "Cannot increment anymore"
                            in
                            res
                        )
                        ia
                        fa
                        ib
                        fb
                        |> Result.andThen identity

            ( Err a, _ ) ->
                Err a

            ( _, Err b ) ->
                Err b


decrementInteger : String -> Maybe String
decrementInteger x =
    -- TODO validate integer?
    case String.toList x of
        [] ->
            Nothing

        head :: originalDigits ->
            let
                ( borrow, digits ) =
                    dec originalDigits
            in
            if borrow then
                if head == 'a' then
                    Just (String.fromList [ 'Z', lastChar ])

                else if head == 'A' then
                    -- Cannot go lower
                    Nothing

                else
                    let
                        nextHeadDigit : Char
                        nextHeadDigit =
                            Char.toCode head - 1 |> Char.fromCode

                        finalDigits =
                            if nextHeadDigit < 'Z' then
                                digits ++ [ lastChar ]

                            else
                                List.take (List.length digits - 1) digits
                    in
                    Just (String.fromList (nextHeadDigit :: finalDigits))

            else
                Just (String.fromList (head :: digits))


dec : List Char -> ( Bool, List Char )
dec digs =
    let
        acc : Char -> ( Bool, List Char ) -> ( Bool, List Char )
        acc dig ( borrow, prevDigs ) =
            let
                prevDigitIdx =
                    String.indexes (String.fromChar dig) base62Digits
                        |> List.head
                        |> Maybe.map (\idx -> idx - 1)
                        |> Maybe.withDefault -1
            in
            if prevDigitIdx == -1 then
                ( True, lastChar :: prevDigs )

            else
                let
                    decChar =
                        getAt prevDigitIdx (String.toList base62Digits)
                            -- use non standard char is totem to show this has failed, but it never should
                            |> Maybe.withDefault '-'
                in
                ( False, decChar :: prevDigs )
    in
    List.foldr acc ( True, [] ) digs


incrementInteger : String -> Maybe String
incrementInteger x =
    -- TODO validate integer?
    case String.toList x of
        [] ->
            Nothing

        head :: originalDigits ->
            let
                ( carry, digits ) =
                    inc originalDigits
            in
            if carry then
                if head == 'Z' then
                    Just (String.fromList [ 'a', getDigitAt 0 ])

                else if head == 'z' then
                    -- we have run out of integers
                    Nothing

                else
                    let
                        nextHeadDigit : Char
                        nextHeadDigit =
                            Char.toCode head + 1 |> Char.fromCode

                        finalDigits =
                            if nextHeadDigit > 'a' then
                                digits ++ [ firstChar ]

                            else
                                List.take (List.length digits - 1) digits
                    in
                    Just (String.fromList (nextHeadDigit :: finalDigits))

            else
                Just (String.fromList (head :: digits))


inc : List Char -> ( Bool, List Char )
inc digs =
    let
        acc : Char -> ( Bool, List Char ) -> ( Bool, List Char )
        acc dig ( carry, prevDigs ) =
            if carry then
                let
                    nextDigitIdx =
                        String.indexes (String.fromChar dig) base62Digits
                            |> List.head
                            |> Maybe.map (\idx -> idx + 1)
                            -- use -1 as default as it will fail on following checks
                            |> Maybe.withDefault -1
                in
                if nextDigitIdx == String.length base62Digits then
                    --  nextDigitIndex is out of range, so we want to carry and continue on to next dig
                    ( True, firstChar :: prevDigs )

                else
                    -- nextDigitIndex is still in range, so we can inc with carry
                    let
                        incChar =
                            getAt nextDigitIdx (String.toList base62Digits)
                                -- use non standard char is totem to show this has failed, but it never should
                                |> Maybe.withDefault '-'
                    in
                    ( False, incChar :: prevDigs )

            else
                ( carry, dig :: prevDigs )
    in
    List.foldr acc ( True, [] ) digs


getDigitAt : Int -> Char
getDigitAt idx =
    -- use non standard char '-' as totem to show this has failed
    getAt idx (String.toList base62Digits) |> Maybe.withDefault '-'


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


firstChar =
    '0'


lastChar =
    'z'


zero =
    String.fromChar firstChar


base62Digits =
    "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
