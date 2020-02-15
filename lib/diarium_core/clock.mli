(** Effectful counter *)

type 'a t
(** Type of a clock *)

val make :
     decr:('a -> 'a)
  -> incr:('a -> 'a)
  -> pp:(Format.formatter -> 'a -> unit)
  -> equal:('a -> 'a -> bool)
  -> 'a
  -> 'a t
(** Make a new clock: [make ~decr ~incr start]*)

val current : 'a t -> 'a
(** [current clock] get the current value of a clock *)

val next : 'a t -> 'a
(** [next clock] update the state of the clock to the next step and returns the
    new state. *)

val previous : 'a t -> 'a
(** [previous clock] update the state of the clock to the previous step and
    returns the new state. *)

val reset : 'a t -> 'a
(** [next clock] update the state of the clock with the first step and returns
    the new state. *)

val pp : Format.formatter -> 'a t -> unit
(** Pretty printer *)

val equal : 'a t -> 'a t -> bool
(** Structural equality *)

(** {2 Specifics clocks} *)

val int : unit -> int t
