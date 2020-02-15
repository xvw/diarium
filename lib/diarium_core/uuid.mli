(** Build Unique identifier (using platform context)*)

type t = string
(** Represent an unique identifier *)

(** {2 Requirement} *)

module type GENERATOR = sig
  val name : unit -> string

  val pid : unit -> int

  val time : unit -> float
end

(** {2 API} *)

val make : ?clock:int Clock.t -> (module GENERATOR) -> unit -> t
(** create an UUID (as a string) *)

(** {2 Functor} *)

(** Functor to provide an UUID-generator (using a unique clock) as an abstract
    type*)
module Make (G : GENERATOR) : sig
  type t

  val make : unit -> t

  val to_string : t -> string
end
