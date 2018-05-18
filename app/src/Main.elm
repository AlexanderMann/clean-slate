module Main exposing (..)

--import Json.Decode exposing (..)
--import Debug exposing (log)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)


--import Array exposing (..)
--import Html exposing (Html, text, div, h1, img)
--import Html.Attributes exposing (src, class)
---- MODEL ----


type alias Node =
    { title : String
    , id : String
    , children : List String
    , nodeType : String
    , info : String
    }


type alias Model =
    { currentNodeId : String
    , nodes : List Node
    }


type alias Flags =
    { root : String
    , nodes : List Node
    }


initialModel : Model
initialModel =
    { currentNodeId = ""
    , nodes = []
    }


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( { initialModel
        | currentNodeId = flags.root
        , nodes = flags.nodes
      }
    , Cmd.none
    )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



---- UPDATE ----


type Msg
    = NoOp
    | Answer String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Answer x ->
            ( { model | currentNodeId = x }, Cmd.none )

        NoOp ->
            ( model, Cmd.none )



---- VIEW ----


getNode : String -> List Node -> Maybe Node
getNode id nodes =
    List.filter (\x -> x.id == id) nodes |> List.head


view : Model -> Html Msg
view model =
    div []
        [ div [ id "topbar" ]
            [ h1 [] [ text ("prison-help") ] ]
        , div [ class "wrapper" ]
            [ div [ id "results" ]
                [ div [ class "title" ] [ text "RESULTS" ]
                , p [] [ text "- Answers some questions to see what reduction / petition may apply to your case." ]
                ]
            , div [ id "questions" ]
                [ div [ class "title" ] [ text "QUESTIONS" ]
                , card model.currentNodeId model.nodes
                ]
            ]
        ]


card : String -> List Node -> Html Msg
card id nodes =
    let
        node =
            case getNode id nodes of
                Nothing ->
                    { title = "Missing Node"
                    , id = "0"
                    , children = []
                    , nodeType = "none"
                    , info = ""
                    }

                Just x ->
                    x

        options =
            if (.id node) /= "0" then
                -- <function> : List String -> Maybe Node
                List.map (\x -> ( x, nodes )) (.children node)
                    |> List.map (\x -> getNode (Tuple.first x) (Tuple.second x))
                    |> List.map
                        (\x ->
                            case x of
                                Just y ->
                                    List.head (.children y)
                                        |> (\z ->
                                                case z of
                                                    Just a ->
                                                        a

                                                    Nothing ->
                                                        "1"
                                           )
                                        |> (\b -> div [ class "option", onClick (Answer b) ] [ text (.title y) ])

                                Nothing ->
                                    div [] []
                        )
            else
                [ p [] [ text "End of line plase see results" ] ]
    in
        div [ class "card" ]
            [ p [ class "question" ] [ text (.title node) ]
            , div [ class "hr" ] []
            , div [ class "info" ] [ text (.info node) ]
            , div [ class "options" ]
                options
            ]



---- PROGRAM ----


main : Program Flags Model Msg
main =
    Html.programWithFlags
        { view = view
        , init = init
        , update = update
        , subscriptions = subscriptions
        }
