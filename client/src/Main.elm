module Main exposing (..)

import Browser exposing (Document)
import Html exposing (..)


main : Program () Model Msg
main = 
    Browser.document 
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Project = 
    { id : Int
    , name : String
    , targetHours : Int
    }

type alias Model =
    {projects : List Project 
    }

init : () -> (Model, Cmd Msg)
init _ = 
    (Model [], Cmd.none)

-- UPDATE

type Msg
    = NoOp


update : Msg -> Model -> (Model, Cmd Msg)
update _ model = 
    (model, Cmd.none)

-- VIEW
view : Model -> Document Msg 
view _ = 
    { title = "Time Tracker" 
    , body = [ Html.text "Hello world" ] 
    }


-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions _ = 
    Sub.none

