module Infix : sig
  val ( % ) : int -> int -> int
end = struct
  let ( % ) x y =
    let result = x mod y in
    if result >= 0 then result else result + y
end

let index_of_letter letter =
  match letter with
  | 'a' | 'A' -> 0
  | 'b' | 'B' -> 1
  | 'c' | 'C' -> 2
  | 'd' | 'D' -> 3
  | 'e' | 'E' -> 4
  | 'f' | 'F' -> 5
  | 'g' | 'G' -> 6
  | 'h' | 'H' -> 7
  | 'i' | 'I' -> 8
  | 'j' | 'J' -> 9
  | 'k' | 'K' -> 10
  | 'l' | 'L' -> 11
  | 'm' | 'M' -> 12
  | 'n' | 'N' -> 13
  | 'o' | 'O' -> 14
  | 'p' | 'P' -> 15
  | 'q' | 'Q' -> 16
  | 'r' | 'R' -> 17
  | 's' | 'S' -> 18
  | 't' | 'T' -> 19
  | 'u' | 'U' -> 20
  | 'v' | 'V' -> 21
  | 'w' | 'W' -> 22
  | 'x' | 'X' -> 23
  | 'y' | 'Y' -> 24
  | 'z' | 'Z' -> 25
  | _ -> -1 (* Handle other cases *)

let letter_of_index ?(upper = false) index =
  let char =
    match index with
    | 0 -> 'a'
    | 1 -> 'b'
    | 2 -> 'c'
    | 3 -> 'd'
    | 4 -> 'e'
    | 5 -> 'f'
    | 6 -> 'g'
    | 7 -> 'h'
    | 8 -> 'i'
    | 9 -> 'j'
    | 10 -> 'k'
    | 11 -> 'l'
    | 12 -> 'm'
    | 13 -> 'n'
    | 14 -> 'o'
    | 15 -> 'p'
    | 16 -> 'q'
    | 17 -> 'r'
    | 18 -> 's'
    | 19 -> 't'
    | 20 -> 'u'
    | 21 -> 'v'
    | 22 -> 'w'
    | 23 -> 'x'
    | 24 -> 'y'
    | 25 -> 'z'
    | i ->
        raise (Invalid_argument ("Index " ^ Int.to_string i ^ " out of range"))
  in
  if upper = true then Char.uppercase_ascii char else char

let skip_chars =
  [
    ' ';
    '.';
    ',';
    '!';
    '?';
    ':';
    ';';
    '\'';
    '\"';
    '-';
    '(';
    ')';
    '[';
    ']';
    '{';
    '}';
    '/';
    '<';
    '>';
    '&';
    '@';
    '#';
    '$';
    '%';
    '^';
    '*';
    '~';
    '`';
    '|';
    '\\';
    '_';
    '+';
    '0';
    '1';
    '2';
    '3';
    '4';
    '5';
    '6';
    '7';
    '8';
    '9';
  ]

let read_file file = In_channel.with_open_bin file In_channel.input_all

let write_file content name =
  Out_channel.with_open_text name (fun oc ->
      Out_channel.output_string oc content)

let remove_punctuation_and_spaces text =
  let text_list = String.to_seq text |> List.of_seq in
  let rec aux orig acc =
    match orig with
    | [] -> acc
    | h :: t when List.mem h skip_chars -> aux t acc
    | h :: t -> aux t (h :: acc)
  in
  aux text_list [] |> List.rev |> List.to_seq |> String.of_seq
