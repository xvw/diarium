(** Generate MD5 hash from string *)

type t
(** Abstract representation of a MD5 string *)

val from_string : string -> t
(** Hash a string in MD5 *)

val to_string : t -> string
(** Represent the MD5 as a string. Be carreful, the function does not un-hash
    the string, it export the hashed string as string *)
