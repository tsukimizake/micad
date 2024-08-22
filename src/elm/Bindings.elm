
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
    = RequestStlFile
    | RequestCode (String)


toTauriCmdTypeEncoder : ToTauriCmdType -> Json.Encode.Value
toTauriCmdTypeEncoder enum =
    case enum of
        RequestStlFile ->
            Json.Encode.string "RequestStlFile"
        RequestCode inner ->
            Json.Encode.object [ ( "RequestCode", Json.Encode.string inner ) ]

type FromTauriCmdType
    = StlBytes (List (Int))
    | Code (String)


fromTauriCmdTypeEncoder : FromTauriCmdType -> Json.Encode.Value
fromTauriCmdTypeEncoder enum =
    case enum of
        StlBytes inner ->
            Json.Encode.object [ ( "StlBytes", Json.Encode.list (Json.Encode.int) inner ) ]
        Code inner ->
            Json.Encode.object [ ( "Code", Json.Encode.string inner ) ]

toTauriCmdTypeDecoder : Json.Decode.Decoder ToTauriCmdType
toTauriCmdTypeDecoder = 
    Json.Decode.oneOf
        [ Json.Decode.string
            |> Json.Decode.andThen
                (\x ->
                    case x of
                        "RequestStlFile" ->
                            Json.Decode.succeed RequestStlFile
                        unexpected ->
                            Json.Decode.fail <| "Unexpected variant " ++ unexpected
                )
        , Json.Decode.map RequestCode (Json.Decode.field "RequestCode" (Json.Decode.string))
        ]

fromTauriCmdTypeDecoder : Json.Decode.Decoder FromTauriCmdType
fromTauriCmdTypeDecoder = 
    Json.Decode.oneOf
        [ Json.Decode.map StlBytes (Json.Decode.field "StlBytes" (Json.Decode.list (Json.Decode.int)))
        , Json.Decode.map Code (Json.Decode.field "Code" (Json.Decode.string))
        ]

