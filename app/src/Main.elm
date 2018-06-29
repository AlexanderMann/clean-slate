module Main exposing (..)

--import Json.Decode exposing (..)

import Debug exposing (log)
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
    , results : List String
    , lastUpdatedAt : String
    }


type alias Flags =
    { root : String
    , nodes : List Node
    , lastUpdatedAt : String
    }


initialModel : Model
initialModel =
    { currentNodeId = ""
    , nodes = []
    , results = []
    , lastUpdatedAt = ""
    }


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( { initialModel
        | currentNodeId = flags.root
        , nodes = flags.nodes
        , results = []
        , lastUpdatedAt = flags.lastUpdatedAt
      }
    , Cmd.none
    )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



---- UPDATE ----


type Msg
    = NoOp
    | Answer Node


isResult : Node -> Bool
isResult node =
    case (.nodeType node) of
        "info" ->
            True

        "terminal" ->
            True

        _ ->
            False


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Answer node ->
            let
                _ =
                    Debug.log "Answered Node:" node

                newResults =
                    if (isResult node) then
                        List.append model.results [ (.id node) ]
                    else
                        model.results
            in
                ( { model
                    | currentNodeId = (.id node)
                    , results = newResults
                  }
                , Cmd.none
                )

        NoOp ->
            ( model, Cmd.none )



---- VIEW ----


getNode : String -> List Node -> Maybe Node
getNode id nodes =
    List.filter (\x -> x.id == id) nodes |> List.head


isMissingNode : Node -> Bool
isMissingNode node =
    (.id node) == "UNKNOWN"


missingNode : Node
missingNode =
    { title = "UNKNOWN Missing Node"
    , id = "UNKNOWN"
    , children = []
    , nodeType = "none"
    , info = ""
    }


getMissingNode : String -> List Node -> Node
getMissingNode id nodes =
    case getNode id nodes of
        Nothing ->
            (missingNode)

        Just x ->
            x


view : Model -> Html Msg
view model =
    div []
        [ div [ id "topbar" ]
            [ h1 [] [ text ("prison-help") ] ]
        , div [ class "wrapper" ]
            [ div [ id "results" ]
                [ div [ class "title" ] [ text "RESULTS" ]
                , (resultsCard model.results model.nodes)
                ]
            , div [ id "questions" ]
                [ div [ class "title" ] [ text "QUESTIONS" ]
                , (card model.currentNodeId model.nodes)
                ]
            ]
        , div [ id "footer" ]
            [ h5 [] [ (text ("last updated at " ++ model.lastUpdatedAt)) ] ]
        ]


resultsCard : List String -> List Node -> Html Msg
resultsCard resultIds nodes =
    let
        results =
            List.map (\x -> (getMissingNode x nodes)) resultIds
                |> List.map
                    (\x ->
                        (p [ class ("result " ++ (.nodeType x) ++ "Type") ]
                            [ (text ("- " ++ (.title x) ++ " : " ++ (.info x))) ]
                        )
                    )
    in
        (p [] results)


option : String -> List Node -> Html Msg
option id nodes =
    let
        node =
            (getMissingNode id nodes)

        _ =
            (Debug.log "--Option Node:" node)

        error =
            (p [ class "error" ] [ text "Error Occurred" ])

        childId =
            List.head (.children node)
                |> (\z ->
                        case z of
                            Just a ->
                                a

                            Nothing ->
                                "UNKNOWN"
                   )
    in
        if (.nodeType node) == "option" && childId /= "UNKNOWN" then
            (button
                [ class "button"
                , onClick (Answer (getMissingNode childId nodes))
                ]
                [ text (.title node) ]
            )
        else
            error


card : String -> List Node -> Html Msg
card id nodes =
    let
        node =
            (getMissingNode id nodes)

        _ =
            (Debug.log "Displayed Node:" node)

        options =
            if (isMissingNode node) then
                [ (p [] [ text "End of line please see results" ]) ]
            else
                List.map (\x -> (option x nodes)) (.children node)
    in
        (div [ class ("card " ++ (.nodeType node) ++ "Type") ]
            [ (p [ class "question" ] [ text (.title node) ])
            , (div [ class "hr" ] [])
            , (div [ class "info" ] [ text (.info node) ])
            , (div [ class "options" ] options)
            ]
        )



---- PROGRAM ----


main : Program Flags Model Msg
main =
    Html.programWithFlags
        { view = view
        , init = init
        , update = update
        , subscriptions = subscriptions
        }
