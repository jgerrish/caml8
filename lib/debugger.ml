open Cpu

let continue cpu =
  clear_breakpoint cpu (Cpu.pc cpu);
  Cpu.run cpu

let step cpu =
  Cpu.step cpu

let print_help () =
  Stdio.printf "c: continue, s: step, SPACE: Toggle Running/Stopped, p: Dump CPU state\n";
  (* Flush the output, so we can see it while a game is running or paused *)
  Stdio.Out_channel.flush Stdio.Out_channel.stdout
