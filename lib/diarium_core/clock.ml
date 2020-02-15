type 'a t = {
    decr : 'a -> 'a
  ; incr : 'a -> 'a
  ; start : 'a
  ; mutable state : 'a
}

let make ~decr ~incr start = { decr; incr; start; state = start }

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

let int () = make ~decr:Stdlib.pred ~incr:Stdlib.succ 0
