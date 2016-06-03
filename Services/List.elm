module Services.List exposing (..)

import Html exposing (..)
import Html.Attributes exposing (style)
import Dict exposing (Dict)

import Services.Service as Service

type alias Model = Dict String Service.Model

init services =
  Dict.fromList (List.map toNameTuple services)

toNameTuple service =
  let
    {name} = service
  in
    (name, service)

update srvModel model =
  (Dict.insert srvModel.name srvModel model, Cmd.none)


view model =
  div [] (List.map viewService (Dict.toList model))


viewService (name, srv) =
  Service.view srv
