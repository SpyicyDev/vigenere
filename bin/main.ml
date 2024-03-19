open Cmdliner

(* encode options *)

let encode_cmd =
  let encode_t =
    let key =
      let doc = "The key for the Vigenere Cipher." in
      Arg.(required & pos 0 (some string) None & info [] ~docv:"KEY" ~doc)
    in

    let phrase =
      let doc = "The plaintext to be encoded." in
      Arg.(required & pos 1 (some string) None & info [] ~docv:"PHRASE" ~doc)
    in

    let file_in =
      let doc = "Makes the phrase input be a path to a file to read from." in
      Arg.(value & flag & info [ "f"; "filephrase" ] ~doc)
    in

    let file_out =
      let doc = "File to write the encoded text to." in
      Arg.(value & opt string "" & info [ "o"; "output" ] ~docv:"FILE" ~doc)
    in

    let encode_func file_bool k p file_out_name =
      let phrase_text = if file_bool then (Vigenere.Utils.read_file p) else p in
      if file_out_name = "" then
      print_endline ("CIPHERED TEXT: " ^ Vigenere.encode k phrase_text)
      else
        Vigenere.Utils.write_file (Vigenere.encode k phrase_text) file_out_name
    in

    Term.(const encode_func $ file_in $ key $ phrase $ file_out)
  in
  let doc = "Encode plaintext with a key using a Vigenere cipher." in
  let info = Cmd.info "encode" ~doc in
  Cmd.v info encode_t

(* decode options *)

let decode_cmd =
  let decode_t =
    let key =
      let doc = "The key for the Vigenere Cipher." in
      Arg.(required & pos 0 (some string) None & info [] ~docv:"KEY" ~doc)
    in

    let cipher =
      let doc = "The ciphertext to be decoded." in
      Arg.(required & pos 1 (some string) None & info [] ~docv:"CIPHER" ~doc)
    in

    let file_in =
      let doc = "Makes the cipher input be a path to a file to read from." in
      Arg.(value & flag & info [ "f"; "filecipher" ] ~doc)
    in

    let file_out =
      let doc = "File to write the decoded text to." in
      Arg.(value & opt string "" & info [ "o"; "output" ] ~docv:"FILE" ~doc)
    in

    let decode_func file_bool k p file_out_name =
      let cipher_text = if file_bool then (Vigenere.Utils.read_file p) else p in
      if file_out_name = "" then
        print_endline ("PLAINTEXT: " ^ Vigenere.decode k cipher_text)
      else
        Vigenere.Utils.write_file (Vigenere.decode k cipher_text) file_out_name
    in

    Term.(const decode_func $ file_in $ key $ cipher $ file_out)
  in
  let doc = "Decode ciphertext with a key using a Vigenere cipher." in
  let info = Cmd.info "decode" ~doc in
  Cmd.v info decode_t

let group =
  let doc = "A tool for working with Vigenere ciphers." in
  let info = Cmd.info "vigenere" ~version:"%%VERSION%%" ~doc in
  Cmd.group info [ encode_cmd; decode_cmd ]

let () = exit (Cmd.eval group)
