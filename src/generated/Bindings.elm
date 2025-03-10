
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
    = RequestCode (String)
    | RequestEval
    | SaveStlFile (Int) (String)


toTauriCmdTypeEncoder : ToTauriCmdType -> Json.Encode.Value
toTauriCmdTypeEncoder enum =
    case enum of
        RequestCode inner ->
            Json.Encode.object [ ( "t", Json.Encode.string "RequestCode"), ( "c", Json.Encode.string inner ) ]
        RequestEval ->
            Json.Encode.object [ ( "t", Json.Encode.string "RequestEval" ) ]
        SaveStlFile t0 t1 ->
            Json.Encode.object [ ( "t", Json.Encode.string "SaveStlFile"), ( "c", Json.Encode.list identity [ Json.Encode.int t0, Json.Encode.string t1 ] ) ]

type FromTauriCmdType
    = Code (String)
    | EvalOk (Evaled)
    | EvalError (String)
    | SaveStlFileOk (String)
    | SaveStlFileError (String)


fromTauriCmdTypeEncoder : FromTauriCmdType -> Json.Encode.Value
fromTauriCmdTypeEncoder enum =
    case enum of
        Code inner ->
            Json.Encode.object [ ( "t", Json.Encode.string "Code"), ( "c", Json.Encode.string inner ) ]
        EvalOk inner ->
            Json.Encode.object [ ( "t", Json.Encode.string "EvalOk"), ( "c", evaledEncoder inner ) ]
        EvalError inner ->
            Json.Encode.object [ ( "t", Json.Encode.string "EvalError"), ( "c", Json.Encode.string inner ) ]
        SaveStlFileOk inner ->
            Json.Encode.object [ ( "t", Json.Encode.string "SaveStlFileOk"), ( "c", Json.Encode.string inner ) ]
        SaveStlFileError inner ->
            Json.Encode.object [ ( "t", Json.Encode.string "SaveStlFileError"), ( "c", Json.Encode.string inner ) ]

type alias Evaled =
    { value : Value
    , polys : List (( Int, SerdeStlFaces ))
    , previews : List (Int)
    }


evaledEncoder : Evaled -> Json.Encode.Value
evaledEncoder struct =
    Json.Encode.object
        [ ( "value", (valueEncoder) struct.value )
        , ( "polys", (Json.Encode.list (\( a, b) -> Json.Encode.list identity [ Json.Encode.int a, serdeStlFacesEncoder b ])) struct.polys )
        , ( "previews", (Json.Encode.list (Json.Encode.int)) struct.previews )
        ]


type Value
    = Integer (Int)
    | Double (Float)
    | Stl (Int)
    | String (String)
    | Symbol (String)
    | List (List (Value))


valueEncoder : Value -> Json.Encode.Value
valueEncoder enum =
    case enum of
        Integer inner ->
            Json.Encode.object [ ( "t", Json.Encode.string "Integer"), ( "c", Json.Encode.int inner ) ]
        Double inner ->
            Json.Encode.object [ ( "t", Json.Encode.string "Double"), ( "c", Json.Encode.float inner ) ]
        Stl inner ->
            Json.Encode.object [ ( "t", Json.Encode.string "Stl"), ( "c", Json.Encode.int inner ) ]
        String inner ->
            Json.Encode.object [ ( "t", Json.Encode.string "String"), ( "c", Json.Encode.string inner ) ]
        Symbol inner ->
            Json.Encode.object [ ( "t", Json.Encode.string "Symbol"), ( "c", Json.Encode.string inner ) ]
        List inner ->
            Json.Encode.object [ ( "t", Json.Encode.string "List"), ( "c", Json.Encode.list (valueEncoder) inner ) ]

type SerdeStlFaces
    = SerdeStlFaces (List (SerdeStlFace))


serdeStlFacesEncoder : SerdeStlFaces -> Json.Encode.Value
serdeStlFacesEncoder (SerdeStlFaces inner) =
    (Json.Encode.list (serdeStlFaceEncoder)) inner


type SerdeStlFace
    = SerdeStlFace (List (List (Float)))


serdeStlFaceEncoder : SerdeStlFace -> Json.Encode.Value
serdeStlFaceEncoder (SerdeStlFace inner) =
    (Json.Encode.list (Json.Encode.list (Json.Encode.float))) inner


toTauriCmdTypeDecoder : Json.Decode.Decoder ToTauriCmdType
toTauriCmdTypeDecoder = 
    Json.Decode.field "t" Json.Decode.string
        |> Json.Decode.andThen
            (\tag ->
                case tag of
                    "RequestCode" ->
                        Json.Decode.map RequestCode (Json.Decode.field "c" (Json.Decode.string))
                    "RequestEval" ->
                        Json.Decode.succeed RequestEval
                    "SaveStlFile" ->
                        Json.Decode.field "c" (Json.Decode.succeed SaveStlFile |> Json.Decode.andThen (\x -> Json.Decode.index 0 (Json.Decode.int) |> Json.Decode.map x) |> Json.Decode.andThen (\x -> Json.Decode.index 1 (Json.Decode.string) |> Json.Decode.map x))
                    unexpected ->
                        Json.Decode.fail <| "Unexpected variant " ++ unexpected
            )

fromTauriCmdTypeDecoder : Json.Decode.Decoder FromTauriCmdType
fromTauriCmdTypeDecoder = 
    Json.Decode.field "t" Json.Decode.string
        |> Json.Decode.andThen
            (\tag ->
                case tag of
                    "Code" ->
                        Json.Decode.map Code (Json.Decode.field "c" (Json.Decode.string))
                    "EvalOk" ->
                        Json.Decode.map EvalOk (Json.Decode.field "c" (evaledDecoder))
                    "EvalError" ->
                        Json.Decode.map EvalError (Json.Decode.field "c" (Json.Decode.string))
                    "SaveStlFileOk" ->
                        Json.Decode.map SaveStlFileOk (Json.Decode.field "c" (Json.Decode.string))
                    "SaveStlFileError" ->
                        Json.Decode.map SaveStlFileError (Json.Decode.field "c" (Json.Decode.string))
                    unexpected ->
                        Json.Decode.fail <| "Unexpected variant " ++ unexpected
            )

evaledDecoder : Json.Decode.Decoder Evaled
evaledDecoder =
    Json.Decode.succeed Evaled
        |> Json.Decode.andThen (\x -> Json.Decode.map x (Json.Decode.field "value" (valueDecoder)))
        |> Json.Decode.andThen (\x -> Json.Decode.map x (Json.Decode.field "polys" (Json.Decode.list (Json.Decode.map2 (\a b -> ( a, b )) (Json.Decode.index 0 (Json.Decode.int)) (Json.Decode.index 1 (serdeStlFacesDecoder))))))
        |> Json.Decode.andThen (\x -> Json.Decode.map x (Json.Decode.field "previews" (Json.Decode.list (Json.Decode.int))))


valueDecoder : Json.Decode.Decoder Value
valueDecoder = 
    Json.Decode.field "t" Json.Decode.string
        |> Json.Decode.andThen
            (\tag ->
                case tag of
                    "Integer" ->
                        Json.Decode.map Integer (Json.Decode.field "c" (Json.Decode.int))
                    "Double" ->
                        Json.Decode.map Double (Json.Decode.field "c" (Json.Decode.float))
                    "Stl" ->
                        Json.Decode.map Stl (Json.Decode.field "c" (Json.Decode.int))
                    "String" ->
                        Json.Decode.map String (Json.Decode.field "c" (Json.Decode.string))
                    "Symbol" ->
                        Json.Decode.map Symbol (Json.Decode.field "c" (Json.Decode.string))
                    "List" ->
                        Json.Decode.map List (Json.Decode.field "c" (Json.Decode.list (valueDecoder)))
                    unexpected ->
                        Json.Decode.fail <| "Unexpected variant " ++ unexpected
            )

serdeStlFacesDecoder : Json.Decode.Decoder SerdeStlFaces
serdeStlFacesDecoder =
    Json.Decode.map SerdeStlFaces (Json.Decode.list (serdeStlFaceDecoder))


serdeStlFaceDecoder : Json.Decode.Decoder SerdeStlFace
serdeStlFaceDecoder =
    Json.Decode.map SerdeStlFace (Json.Decode.list (Json.Decode.list (Json.Decode.float)))


