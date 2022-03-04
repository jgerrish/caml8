open Stdio
open Base
open Caml8_lib.Ints

(* Test of_int *)
let%expect_test "test of_int" =
  Uint16.of_int 0x200
  |> Uint16.to_int
  |> printf "%x";

  [%expect {| 200 |}]

(* Run a test of Uint16Set,
   adding two duplicate items and another distinct item *)
let%expect_test "test Uint16Set" =
  let int1 = Uint16.of_int 0x200 in
  let int2 = Uint16.of_int 0x201 in
  let set =
    Uint16Set.empty
    |> Uint16Set.add int1
    |> Uint16Set.add int1
    |> Uint16Set.add int2 in
  printf "%X %B %B"
    (Uint16Set.cardinal set) (Uint16Set.mem int1 set) (Uint16Set.mem int2 set);

  [%expect {| 2 true true |}]
