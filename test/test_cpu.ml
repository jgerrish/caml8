open Stdio
open Base
open Caml8_lib
open Caml8_lib.Ints

let%expect_test "Test Fishche.ch8" =
  let rom = In_channel.read_all "../resources/Fishie.ch8" |> Bytes.of_string in
  let cpu = Cpu.create ~rom in
  Cpu.tick cpu

(* Setting a breakpoint should set the state to Stopped when
   the PC equals the breakpoint and the PC shouldn't advance between ticks. *)
let%expect_test "Test breakpoint" =
  let rom = In_channel.read_all "../resources/test_cpu.ch8" |> Bytes.of_string in
  let cpu = Cpu.create ~rom in
  (* Set a breakpoint at the first address *)
  Cpu.set_breakpoint cpu (Uint16.of_int 0x200);
  (* CPU should still be running *)
  Stdio.printf "%s" (Cpu.cpu_state_to_string (Cpu.cpu_state cpu));
  [%expect {| running |}];

  Stdio.printf "PC: %x" (Uint16.to_int (Cpu.pc cpu));
  [%expect {| PC: 200 |}];

  (* Advancing the PC stops the CPU *)
  Cpu.tick cpu;
  Stdio.printf "%s" (Cpu.cpu_state_to_string (Cpu.cpu_state cpu));
  [%expect {|
            Stopped on breakpoint
            stopped |}];

  Stdio.printf "PC: %x " (Uint16.to_int (Cpu.pc cpu));
  [%expect {| PC: 200 |}];

  Cpu.tick cpu;
  Stdio.printf "PC: %x\n" (Uint16.to_int (Cpu.pc cpu));
  [%expect {| PC: 200 |}];
