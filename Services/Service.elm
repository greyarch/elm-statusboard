module Services.Service exposing (..)

import Html exposing (..)
import Html.Attributes exposing (style)

import WsMessage exposing (..)

type alias Model =
  { name : String
  , status : Status
  , lastCheck: String
  }

type Status
  = Ok Int
  | Nok
  | Unknown

fromWsMessage : WsMessage.Model -> Model
fromWsMessage parsedMessage =
  let
    {name, isUp, lastCheck} = parsedMessage
  in
    init name isUp lastCheck

init : String -> Bool -> String -> Model
init name isUp lastCheck =
  case isUp of
    True ->
      Model name (Ok 0) lastCheck
    False ->
      Model name Nok lastCheck

update _ model =
  (model, Cmd.none)

view model =
  div [divStyle model.status]
    [text model.name
    ,text model.lastCheck]

divStyle status =
  let color =
    case status of
      Ok t ->
        if t > 3600 -- more than an hour ago
          then "green"
          else "yellow"
      Nok     -> "red"
      Unknown -> "lightgrey"
  in style
    [ ("background-color", color) ]
