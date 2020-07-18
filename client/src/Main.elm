module Main exposing (main)

import Browser
import Html exposing (br, div, h2, input, text, Html)
import Html.Attributes exposing (placeholder, type_)
import Html.Events exposing (onInput)
import Http
import Json.Decode as D
import Json.Encode as E

import Constants exposing (hello, url)

-- MAIN

main =
  Browser.element
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view = view
    }

-- MODEL

type Model
  = Failure
  | Loading
  | Success HelloReply
  
type alias HelloRequest =
  { name : String }

type alias HelloReply =
  { message : String }

-- INIT

init : () -> (Model, Cmd Msg)
init _ =
  (Loading, sayHello (HelloRequest "generic"))

-- Encoder
helloRequestEncoder : HelloRequest -> E.Value
helloRequestEncoder request =
  E.object
    [ ("name", E.string request.name) ]

-- Decoder

helloReplyDecoder : D.Decoder HelloReply
helloReplyDecoder =
  D.map HelloReply (D.field "message" D.string)

-- UPDATE

type Msg
  = SayHello HelloRequest
  | GotReply (Result Http.Error HelloReply)

update : Msg -> Model -> (Model, Cmd Msg)
update msg _ =
  case msg of
    SayHello name ->
      (Loading, sayHello name)      
    GotReply result ->
      case result of
        Ok reply ->
          (Success reply, Cmd.none)

        Err _ ->
          (Failure, Cmd.none)

updateReply: String -> Msg
updateReply name =
  SayHello (HelloRequest (validName name))

validName : String -> String
validName name =
  if String.length name > 0 then name else "generic"


-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
  Sub.none


-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ h2 [] [ text "Hello Service" ]
    , input [ type_ "text", placeholder "Name", onInput updateReply ] []
    , viewReply model
    ]


viewReply : Model -> Html Msg
viewReply model =
  case model of
    Failure ->
      text "The service might be down :-("

    Loading ->
      text "Contacting service..."

    Success reply ->
      div []
        [ br [] []
        , text reply.message
        ]

-- HTTP

sayHello : HelloRequest -> Cmd Msg
sayHello req =
  Http.post
    { url = url hello
    , body = Http.jsonBody <| helloRequestEncoder req
    , expect = Http.expectJson GotReply helloReplyDecoder
    }
