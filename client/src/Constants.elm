module Constants exposing (hello, url)

baseURL : String
baseURL =
  "http://localhost:55057"

hello : String
hello =
  "/say"

url : String -> String
url endpoint =
  baseURL ++ endpoint
