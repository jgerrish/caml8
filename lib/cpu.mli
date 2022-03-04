open Ints

type t

type state = Stopped | Running
(** [state] Running state of the CPU: Running or Stopped *)

val create : rom:bytes -> t

val cpu_state_to_string : state -> string
(** [cpu_state_to_string state] Return a string representation of the CPU state *)

val step : t -> unit
(** [step t]
    Execute the current instruction in the CPU, incrementing the PC *)

val tick : t -> unit
(** [tick t]
    This executes the current instruction in the CPU if there isn't a breakpoint
    and advances the PC *)

val get_gfx : t -> bool array

val set_key : t -> uint8 option -> unit

val cpu_state : t -> state
(** [cpu_state t] Get the state of CPU t *)

val run : t -> unit
(** [run t] Set the CPU to Running *)

val stop : t -> unit
(** [stop t] Set the CPU to Stopped *)

val toggle_state : t -> unit
(** [toggle_state t]
    Toggle the state of the CPU from Running to Stopped or Stopped to Running *)

val dump_state : t -> unit
(** [dump_state t]
    Dump the state of the CPU including registers and a memory window *)

val set_breakpoint : t -> uint16 -> unit
(** [set_breakpoint t breakpoint_address]
    Set a breakpoint in CPU t at breakpoint_address *)

val clear_breakpoint : t -> uint16 -> unit
(** [clear_breakpoint t breakpoint_address]
    Clear a breakpoint in CPU t at breakpoint_address *)

val pc : t -> uint16
(** [pc t] Get the Program Counter for CPU t *)
