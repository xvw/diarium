(** UUID in Unix context *)

type t
(** An abstract representation of an UUID *)

val make : unit -> t
(** Generate a fresh UUID *)

val to_string : t -> string
(** Render UUID to string *)
