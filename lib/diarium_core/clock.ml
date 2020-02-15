type 'a t = {
    decr : 'a -> 'a
  ; incr : 'a -> 'a
  ; start : 'a
  ; pp : Format.formatter -> 'a -> unit
  ; equal : 'a -> 'a -> bool
  ; mutable state : 'a
}

let make ~decr ~incr ~pp ~equal start =
  { decr; incr; start; state = start; pp; equal }
;;

let current clock = clock.state

let next clock =
  let () = clock.state <- clock.incr clock.state in
  clock.state
;;

let previous clock =
  let () = clock.state <- clock.decr clock.state in
  clock.state
;;

let reset clock =
  let () = clock.state <- clock.start in
  clock.state
;;

let pp format clock =
  Format.fprintf format "Clock.{current = %a; start = %a}" clock.pp clock.state
    clock.pp clock.start
;;

let equal clock_a clock_b =
  clock_a.equal clock_a.state clock_b.state
  && clock_a.equal clock_a.start clock_b.start
;;

let int () =
  let decr = Stdlib.pred in
  let incr = Stdlib.succ in
  let pp format = Format.fprintf format "%d" in
  let equal = Int.equal in
  make ~decr ~incr ~pp ~equal 0
;;
