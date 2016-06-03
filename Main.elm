module Main exposing (..)

import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import WebSocket

import WsMessage exposing (..)
import Services.Service as Service exposing (init, update, view)
import Services.List as ServiceList exposing (init, update, view)


main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

-- MODEL

type alias Model =
  { services: ServiceList.Model
  }

init : (Model, Cmd Msg)
init =
  (Model (ServiceList.init []), Cmd.none)


-- UPDATE

type Msg
  = NewMessage String
  | ParsedMessage WsMessage.Model


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case (Debug.log "message" msg) of
    NewMessage str ->
      (model, Cmd ParsedMessage (WsMessage.parse str))
    ParsedMessage message ->
      (Model (ServiceList.update (Service.fromWsMessage message) model.services), Cmd.none)


-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
  WebSocket.listen "wss://7d32c2c8.ngrok.io" NewMessage


-- VIEW

view : Model -> Html Msg
view model =
  div [] (ServiceList.view model.services)
