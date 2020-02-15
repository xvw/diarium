open Preface.Fun

type t = string

let global_clock = Clock.int ()

module type GENERATOR = sig
  val name : unit -> string

  val pid : unit -> int

  val time : unit -> float
end

let dashify hashed_str =
  let str_f = Format.asprintf "%s-%s-%s-%s-%s" in
  Scanf.sscanf hashed_str "%8s%4s%4s%4s%12s" str_f
;;

let mk clock hname pid time =
  let counter = Clock.next clock in
  let p = string_of_int pid in
  let t = string_of_float time in
  let i = string_of_int counter in
  String.concat "-" [ hname; p; t; i ]
  |> Md5.(from_string %> to_string) %> dashify
;;

let make ?(clock = global_clock) (module G : GENERATOR) () =
  mk clock (G.name ()) (G.pid ()) (G.time ())
;;

module Make (G : GENERATOR) = struct
  type t = string

  let clock = Clock.int ()

  let make = make ~clock (module G)

  let to_string x = x
end
