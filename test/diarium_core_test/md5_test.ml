open Diarium_core
open Preface.Fun.Infix

let some_test () =
  let digests =
    [
      ("foo", "acbd18db4cc2f85cedef654fccc4a4d8")
    ; ("bar", "37b51d194a7513e45b56f6524f2d51f2")
    ; ("ocaml", "6217c07ff169f6ab2eb2731f855095f1")
    ]
  in
  List.iter
    (fun (raw, expected) ->
      let computed = Md5.(from_string %> to_string) raw in
      Alcotest.(check string "Hash should be equals") expected computed)
    digests
;;

let cases =
  let open Alcotest in
  ("Md5", [ test_case "Some hashing experiences on string" `Quick some_test ])
;;
