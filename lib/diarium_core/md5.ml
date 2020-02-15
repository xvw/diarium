open Preface.Fun

type t = string

let from_string = Digest.(to_hex <% string)

let to_string = id
