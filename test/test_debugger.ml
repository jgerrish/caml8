open Stdio
open Base
open Caml8_lib
open Caml8_lib.Ints

(* Test continuing from a breakpoint *)
let%expect_test "Test continue" =
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

  (* Debugger.continue should continue the CPU *)
  Debugger.continue cpu;
  Cpu.tick cpu;
  Stdio.printf "PC: %x\n" (Uint16.to_int (Cpu.pc cpu));
  [%expect {| PC: 202 |}]

(* Test stepping after a breakpoint *)
let%expect_test "Test step" =
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

  (* Debugger.step should step the CPU *)
  Debugger.step cpu;
  Stdio.printf "PC: %x\n" (Uint16.to_int (Cpu.pc cpu));
  [%expect {| PC: 202 |}]
