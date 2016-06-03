module WsMessage exposing (..)

import Json.Decode as Json


type alias Model =
  { name : String
  , group: String
  , isUp: Bool
  , lastCheck : String
  }

parse i =
  let
    name = getStringProperty ["info", "name"] i
    group = getStringProperty ["info", "group"] i
    isUp = getBoolProperty ["status", "isUp"] i
    lastCheck = getStringProperty ["status", "lastCheck"] i
  in
    Model name group isUp lastCheck

-- decoder : Json.Decoder String
getStringProperty property i =
  Json.decodeString (decoder property Json.string) i
  |> Result.withDefault ""

getBoolProperty property i =
  Json.decodeString (decoder property Json.bool) i
  |> Result.withDefault False

decoder property jsonType =
  Json.at property jsonType
