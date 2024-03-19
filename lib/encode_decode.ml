open Utils
open Utils.Infix

let encode key phrase =
  let phrase_list = phrase |> String.to_seq |> List.of_seq in
  let rec aux acc i phrase_ =
    match phrase_ with
    | [] -> acc
    | h :: t when List.mem h skip_chars -> aux (h :: acc) i t
    | _ :: t ->
        let key_letter_index = key.[i] |> index_of_letter in
        let offset = List.hd phrase_ |> index_of_letter in
        let ciphered_letter =
          if Char.uppercase_ascii (List.hd phrase_) = List.hd phrase_ then
            (key_letter_index + offset) % 26 |> letter_of_index ~upper:true
          else (key_letter_index + offset) % 26 |> letter_of_index
        in
        if i < String.length key - 1 then aux (ciphered_letter :: acc) (i + 1) t
        else aux (ciphered_letter :: acc) 0 t
  in
  aux [] 0 phrase_list |> List.rev |> List.to_seq |> String.of_seq

let decode key cipher =
  let cipher_list = cipher |> String.to_seq |> List.of_seq in
  let rec aux acc i cipher_ =
    match cipher_ with
    | [] -> acc
    | h :: t when List.mem h skip_chars -> aux (h :: acc) i t
    | _ :: t ->
        let key_letter_index = key.[i] |> index_of_letter in
        let cipher_letter_index = List.hd cipher_ |> index_of_letter in
        let decoded_letter =
          if Char.uppercase_ascii (List.hd cipher_) = List.hd cipher_ then
            (cipher_letter_index - key_letter_index) % 26
            |> letter_of_index ~upper:true
          else (cipher_letter_index - key_letter_index) % 26 |> letter_of_index
        in
        if i < String.length key - 1 then aux (decoded_letter :: acc) (i + 1) t
        else aux (decoded_letter :: acc) 0 t
  in
  aux [] 0 cipher_list |> List.rev |> List.to_seq |> String.of_seq
