open Diarium_core

let subject = Alcotest.(testable Clock.pp Clock.equal)

let initialize_clock () =
  let clock = Clock.int () in
  let expected = 0
  and computed = Clock.current clock in
  Alcotest.(check int "An empty int clock should start at 0") expected computed
;;

let initialize_clock_and_apply_mutation () =
  let clock = Clock.int () in
  let expected = 4
  and computed =
    let _ = Clock.next clock in
    let _ = Clock.next clock in
    let _ = Clock.next clock in
    Clock.next clock
  in

  Alcotest.(check int "The results should be equals") expected computed
;;

let initialize_clock_and_apply_mutation_both () =
  let clock = Clock.int () in
  let expected = 2
  and computed =
    let _ = Clock.next clock in
    let _ = Clock.next clock in
    let _ = Clock.next clock in
    let _ = Clock.previous clock in
    let _ = Clock.previous clock in
    Clock.next clock
  in

  Alcotest.(check int "The results should be equals") expected computed
;;

let initialize_clock_and_apply_reset () =
  let clock = Clock.int () in
  let expected = 0
  and computed =
    let _ = Clock.next clock in
    let _ = Clock.next clock in
    let _ = Clock.next clock in
    let _ = Clock.previous clock in
    let _ = Clock.previous clock in
    Clock.reset clock
  in

  Alcotest.(check int "The results should be equals") expected computed
;;

let check_equality_1 () =
  let clock1 =
    Clock.make
      ~incr:(fun x -> x + 1)
      ~decr:(fun x -> x - 1)
      ~pp:(fun format -> Format.fprintf format "%d")
      ~equal:Int.equal 0
  and clock2 =
    Clock.make
      ~incr:(fun x -> x + 1)
      ~decr:(fun x -> x - 1)
      ~pp:(fun format -> Format.fprintf format "%d")
      ~equal:Int.equal 0
  in
  let () =
    for _ = 0 to 10 do
      let _ = Clock.next clock1 in
      let _ = Clock.next clock2 in
      ()
    done
  in
  Alcotest.(check subject "The clocks should be equals" clock1 clock2)
;;

let check_equality_2 () =
  let clock1 =
    Clock.make
      ~incr:(fun x -> x + 1)
      ~decr:(fun x -> x - 1)
      ~pp:(fun format -> Format.fprintf format "%d")
      ~equal:Int.equal 0
  and clock2 =
    Clock.make
      ~incr:(fun x -> x + 10)
      ~decr:(fun x -> x - 1)
      ~pp:(fun format -> Format.fprintf format "%d")
      ~equal:Int.equal 0
  in
  let () =
    for _ = 0 to 10 do
      let _ = Clock.next clock1 in
      let _ = Clock.next clock2 in
      ()
    done
  in
  Alcotest.(check (neg subject) "The clocks should be not equals" clock1 clock2)
;;

let check_equality_3 () =
  let clock1 =
    Clock.make
      ~incr:(fun x -> x + 1)
      ~decr:(fun x -> x - 1)
      ~pp:(fun format -> Format.fprintf format "%d")
      ~equal:Int.equal 0
  and clock2 =
    Clock.make
      ~incr:(fun x -> x + 1)
      ~decr:(fun x -> x - 1)
      ~pp:(fun format -> Format.fprintf format "%d")
      ~equal:Int.equal 13
  in
  Alcotest.(check (neg subject) "The clocks should be not equals" clock1 clock2)
;;

let cases =
  let open Alcotest in
  ( "Clock"
  , [
      test_case "Current value of a new clock" `Quick initialize_clock
    ; test_case "Apply some incrementation " `Quick
        initialize_clock_and_apply_mutation
    ; test_case "Apply some incrementation and decrementations" `Quick
        initialize_clock_and_apply_mutation_both
    ; test_case "Apply some incrementation and decrementations and reset" `Quick
        initialize_clock_and_apply_reset
    ; test_case "Check equality between two compatibles clocks" `Quick
        check_equality_1
    ; test_case
        "Check equality between two incompatibles clocks (mutator is different)"
        `Quick check_equality_2
    ; test_case
        "Check equality between two incompatibles clocks (base is different)"
        `Quick check_equality_3
    ] )
;;
