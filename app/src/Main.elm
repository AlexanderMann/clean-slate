module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)


--import Html exposing (Html, text, div, h1, img)
--import Html.Attributes exposing (src, class)
---- MODEL ----


type alias Model =
    {}


init : ( Model, Cmd Msg )
init =
    ( {}, Cmd.none )



---- UPDATE ----


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ div [ id "topbar" ]
            [ h1 [] [ text "prison-help" ] ]
        , div [ class "wrapper" ]
            [ div [ id "results" ]
                [ div [ class "title" ] [ text "RESULTS" ]
                , p [] [ text "- Answers some questions to see what reduction / petition may apply to your case." ]
                ]
            , div [ id "questions" ]
                [ div [ class "title" ] [ text "QUESTIONS" ]
                , div [ class "card" ]
                    [ p [ class "question" ] [ text "Can the case be reduced by a recent Proposition?" ]
                    , div [ class "hr" ] []
                    , div [ class "info" ] [ text "extra info" ]
                    , div [ class "options" ]
                        [ div [ class "option" ] [ text "YES" ]
                        , div [ class "option" ] [ text "NO" ]
                        ]
                    ]
                ]
            ]
        ]



---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
