include Diarium_core.Uuid.Make (struct
  let name = Unix.gethostname

  let pid = Unix.getpid

  let time = Unix.gettimeofday
end)
