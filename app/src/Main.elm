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
            let
                _ =
                    Debug.log "Answered Node:" x
            in
                ( { model | currentNodeId = x }, Cmd.none )

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
                , p [] [ text "- Answers some questions to see what reduction / petition may apply to your case." ]
                ]
            , div [ id "questions" ]
                [ div [ class "title" ] [ text "QUESTIONS" ]
                , card model.currentNodeId model.nodes
                ]
            ]
        ]


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
                , onClick (Answer childId)
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
