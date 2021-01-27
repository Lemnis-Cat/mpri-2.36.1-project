
(* open ZArith *)
open Format
open Takuzu

let pp_elem fmt e : unit =
  fprintf fmt "%c"
  (match e with
  | Empty -> ' '
  | Zero -> '0'
  | One -> '1')

let print_grid fmt g : unit =
  fprintf fmt "+-------------------------------+@\n";
  for i=0 to 63 do
    fprintf fmt "| %a " pp_elem (Array.get g i);
    if i mod 8 = 7 then fprintf fmt "|@\n---------------------------------@\n"
  done

let do_solve n g =
  let t = Unix.gettimeofday () in
  let x = g () in
  let t = Unix.gettimeofday () -. t in
  printf "@[[%2.2f] Solving grid '%s'@\n@[%a@]@]@." t n print_grid x

let () = do_solve "empty" Takuzu.empty

let () = do_solve "1" Takuzu.example1

let () = do_solve "2" Takuzu.example2

let () = do_solve "3" Takuzu.example3

let () = do_solve "4" Takuzu.example4

let () = do_solve "5" Takuzu.example5

let () = do_solve "6" Takuzu.example6
