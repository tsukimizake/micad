
-- generated by elm_rs


module Bindings exposing (..)

import Dict exposing (Dict)
import Http
import Json.Decode
import Json.Encode
import Url.Builder


resultEncoder : (e -> Json.Encode.Value) -> (t -> Json.Encode.Value) -> (Result e t -> Json.Encode.Value)
resultEncoder errEncoder okEncoder enum =
    case enum of
        Ok inner ->
            Json.Encode.object [ ( "Ok", okEncoder inner ) ]
        Err inner ->
            Json.Encode.object [ ( "Err", errEncoder inner ) ]


resultDecoder : Json.Decode.Decoder e -> Json.Decode.Decoder t -> Json.Decode.Decoder (Result e t)
resultDecoder errDecoder okDecoder =
    Json.Decode.oneOf
        [ Json.Decode.map Ok (Json.Decode.field "Ok" okDecoder)
        , Json.Decode.map Err (Json.Decode.field "Err" errDecoder)
        ]


type ToTauriCmdType
    = RequestStlFile (String)
    | RequestCode (String)
    | RequestEval


toTauriCmdTypeEncoder : ToTauriCmdType -> Json.Encode.Value
toTauriCmdTypeEncoder enum =
    case enum of
        RequestStlFile inner ->
            Json.Encode.object [ ( "t", Json.Encode.string "RequestStlFile"), ( "c", Json.Encode.string inner ) ]
        RequestCode inner ->
            Json.Encode.object [ ( "t", Json.Encode.string "RequestCode"), ( "c", Json.Encode.string inner ) ]
        RequestEval ->
            Json.Encode.object [ ( "t", Json.Encode.string "RequestEval" ) ]

type FromTauriCmdType
    = StlBytes (List (Int))
    | Code (String)
    | EvalOk (String)
    | EvalError (String)


fromTauriCmdTypeEncoder : FromTauriCmdType -> Json.Encode.Value
fromTauriCmdTypeEncoder enum =
    case enum of
        StlBytes inner ->
            Json.Encode.object [ ( "t", Json.Encode.string "StlBytes"), ( "c", Json.Encode.list (Json.Encode.int) inner ) ]
        Code inner ->
            Json.Encode.object [ ( "t", Json.Encode.string "Code"), ( "c", Json.Encode.string inner ) ]
        EvalOk inner ->
            Json.Encode.object [ ( "t", Json.Encode.string "EvalOk"), ( "c", Json.Encode.string inner ) ]
        EvalError inner ->
            Json.Encode.object [ ( "t", Json.Encode.string "EvalError"), ( "c", Json.Encode.string inner ) ]

toTauriCmdTypeDecoder : Json.Decode.Decoder ToTauriCmdType
toTauriCmdTypeDecoder = 
    Json.Decode.field "t" Json.Decode.string
        |> Json.Decode.andThen
            (\tag ->
                case tag of
                    "RequestStlFile" ->
                        Json.Decode.map RequestStlFile (Json.Decode.field "c" (Json.Decode.string))
                    "RequestCode" ->
                        Json.Decode.map RequestCode (Json.Decode.field "c" (Json.Decode.string))
                    "RequestEval" ->
                        Json.Decode.succeed RequestEval
                    unexpected ->
                        Json.Decode.fail <| "Unexpected variant " ++ unexpected
            )

fromTauriCmdTypeDecoder : Json.Decode.Decoder FromTauriCmdType
fromTauriCmdTypeDecoder = 
    Json.Decode.field "t" Json.Decode.string
        |> Json.Decode.andThen
            (\tag ->
                case tag of
                    "StlBytes" ->
                        Json.Decode.map StlBytes (Json.Decode.field "c" (Json.Decode.list (Json.Decode.int)))
                    "Code" ->
                        Json.Decode.map Code (Json.Decode.field "c" (Json.Decode.string))
                    "EvalOk" ->
                        Json.Decode.map EvalOk (Json.Decode.field "c" (Json.Decode.string))
                    "EvalError" ->
                        Json.Decode.map EvalError (Json.Decode.field "c" (Json.Decode.string))
                    unexpected ->
                        Json.Decode.fail <| "Unexpected variant " ++ unexpected
            )

