val continue : Cpu.t -> unit
(** [continue cpu] Continue running the CPU,
    clearing the current breakpoint *)

val step : Cpu.t -> unit
(** [step cpu] Execute the current instruction and advance the PC
    Ignores any breakpoints *)

val print_help : unit -> unit
(** [print_help] Print help for the debugger *)
