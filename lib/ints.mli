(* Implemented based on ocaml-integers.
 * Did not use ocaml-integers to avoid C bindings.  *)

module Uint8 : Ints_intf.S

module Uint16 : Ints_intf.S

type uint8 = Uint8.t

type uint16 = Uint16.t

(** Uint16Set is a Set object that can be used for storing unique
    Uint16s, for example to store instruction breakpoints *)
module Uint16Set :
sig
  type elt = uint16
  type t = Set.Make(Uint16).t

  val empty : t
  val is_empty : t -> bool
  val mem : elt -> t -> bool
  val add : elt -> t -> t
  val remove : elt -> t -> t
  val compare : t -> t -> int
  val cardinal : t -> int
  val elements : t -> elt list
end

type uint16set = Uint16Set.t
