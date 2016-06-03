module Services.Group exposing (..)

import Html exposing (..)
import Html.Attributes exposing (style)

import Services.List as ServiceList

type alias Model =
  { title : String
  , serviceList: ServiceList.Model
  }

init title services =
  Model title (ServiceList.init services)

update _ model = model

view address model =
  div [ divStyle ]
    [ h2 [] [ text model.title ]
    , ServiceList.view address model.serviceList
    ]

divStyle =
  style [ ("padding", "10px" ) ]
