module T = Domainslib.Task

module Ngram : sig
  type t

  val bottom : t -> float
  val ngram : string -> t
  val score : t -> string -> float
end = struct
  module StringMap = Map.Make (String)

  type t = {
    ngrams : float StringMap.t;
    length : int;
    num : int;
    bottom : float;
  }

  (* getter for bottom of an isntance of t *)
  let bottom t = t.bottom

  (* getter for ngrams of an instance of t *)

  (** Generate an ngram map and associated data from a file. *)
  let ngram file =
    let map =
      let file_string = Utils.read_file file in
      String.split_on_char '\n' file_string
      |> List.map (fun str -> String.split_on_char ' ' str)
      |> List.map (function [ a; b ] -> (a, b) | _ -> failwith "invalid!")
      |> List.map (function a, b -> (a, int_of_string b))
      |> List.to_seq |> StringMap.of_seq
    in
    let n = StringMap.fold (fun _ v acc -> acc + v) map 0 in
    let l = String.length @@ fst @@ List.hd @@ StringMap.to_list map in
    let floor = Float.log10 (0.01 /. float_of_int n) in

    let map =
      StringMap.map
        (fun a -> Float.log10 (float_of_int a /. float_of_int n))
        map
    in
    { ngrams = map; length = l; num = n; bottom = floor }

  let score ngram text =
    let range_limit = String.length text - ngram.length + 1 in
    let rec aux score i =
      match i = range_limit with
      | true -> score
      | false -> (
          let slice =
            String.uppercase_ascii
            @@ String.sub
                 (String.concat "" @@ String.split_on_char ' ' text)
                 i ngram.length
          in
          match StringMap.mem slice ngram.ngrams with
          | true -> aux (score +. StringMap.find slice ngram.ngrams) (i + 1)
          | false -> aux (score +. ngram.bottom) (i + 1))
    in
    aux 0. 0
end

let crack text =
  let trigrams = Ngram.ngram "resources/english_trigrams.txt" in
  let quadgrams = Ngram.ngram "resources/english_quadgrams.txt" in
  let text = Utils.remove_punctuation_and_spaces text in
  let iter_through_pos ngram pos key text =
    let rec aux current_best_score best_key current_key i =
      match i with
      | 25 -> best_key
      | _ -> (
          let score =
            Ngram.score ngram
            @@ Encode_decode.decode
                 (String.concat "" @@ List.map (String.make 1) current_key)
                 text
          in
          print_endline @@ String.concat "" @@ List.map (String.make 1) current_key;
          let increment current =
            List.mapi
              (fun index value ->
                if index <> pos then value
                else
                  value |> Utils.index_of_letter |> ( + ) 1
                  |> Utils.letter_of_index)
              current
          in
          match score > current_best_score with
          | true -> aux score current_key (increment current_key) (i + 1)
          | false ->
              aux current_best_score best_key (increment current_key) (i + 1))
    in
    aux 0. key key 0
  in
  iter_through_pos trigrams 0 [ 'a'; 'a'; 'a'; 'a' ] text
