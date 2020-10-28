{******************************************************************************}
{                                                                              }
{            Indy (Internet Direct) - Internet Protocols Simplified            }
{                                                                              }
{            https://www.indyproject.org/                                      }
{            https://gitter.im/IndySockets/Indy                                }
{                                                                              }
{******************************************************************************}
{                                                                              }
{  This file is part of the Indy (Internet Direct) project, and is offered     }
{  under the dual-licensing agreement described on the Indy website.           }
{  (https://www.indyproject.org/license/)                                      }
{                                                                              }
{  Copyright:                                                                  }
{   (c) 1993-2020, Chad Z. Hower and the Indy Pit Crew. All rights reserved.   }
{                                                                              }
{******************************************************************************}
{                                                                              }
{        Originally written by: Fabian S. Biehn                                }
{                               fbiehn@aagon.com (German & English)            }
{                                                                              }
{        Contributers:                                                         }
{                               Here could be your name                        }
{                                                                              }
{******************************************************************************}

// This File is auto generated!
// Any change to this file should be made in the
// corresponding unit in the folder "intermediate"!

// Generation date: 28.10.2020 15:24:13

unit IdOpenSSLHeaders_ui;

interface

// Headers for OpenSSL 1.1.1
// ui.h

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdCTypes,
  IdGlobal,
  IdOpenSSLConsts,
  IdOpenSSLHeaders_ossl_typ,
  IdOpenSSLHeaders_crypto,
  IdOpenSSLHeaders_pem,
  IdOpenSSLHeaders_uierr;

{$MINENUMSIZE 4}

const
  (* These are the possible flags.  They can be or'ed together. *)
  (* Use to have echoing of input *)
  UI_INPUT_FLAG_ECHO = $01;
  (*
   * Use a default password.  Where that password is found is completely up to
   * the application, it might for example be in the user data set with
   * UI_add_user_data().  It is not recommended to have more than one input in
   * each UI being marked with this flag, or the application might get
   * confused.
   *)
  UI_INPUT_FLAG_DEFAULT_PWD = $02;


  (*
   * The user of these routines may want to define flags of their own.  The core
   * UI won't look at those, but will pass them on to the method routines.  They
   * must use higher bits so they don't get confused with the UI bits above.
   * UI_INPUT_FLAG_USER_BASE tells which is the lowest bit to use.  A good
   * example of use is this:
   *
   *    #define MY_UI_FLAG1       (0x01 << UI_INPUT_FLAG_USER_BASE)
   *
  *)
  UI_INPUT_FLAG_USER_BASE = 16;

  (* The commands *)
  (*
   * Use UI_CONTROL_PRINT_ERRORS with the value 1 to have UI_process print the
   * OpenSSL error stack before printing any info or added error messages and
   * before any prompting.
   *)
  UI_CTRL_PRINT_ERRORS = 1;
  (*
   * Check if a UI_process() is possible to do again with the same instance of
   * a user interface.  This makes UI_ctrl() return 1 if it is redoable, and 0
   * if not.
   *)
  UI_CTRL_IS_REDOABLE = 2;

type
  (*
   * Give a user interface parameterised control commands.  This can be used to
   * send down an integer, a data pointer or a function pointer, as well as be
   * used to get information from a UI.
   *)
  UI_ctrl_f = procedure;

  (*
   * The UI_STRING type is the data structure that contains all the needed info
   * about a string or a prompt, including test data for a verification prompt.
   *)
  ui_string_st = type Pointer;
  UI_STRING = ui_string_st;
  PUI_STRING = ^UI_STRING;
// DEFINE_STACK_OF(UI_STRING)

  (*
   * The different types of strings that are currently supported. This is only
   * needed by method authors.
   *)
  UI_string_types = (
    UIT_NONE = 0,
    UIT_PROMPT,                 (* Prompt for a string *)
    UIT_VERIFY,                 (* Prompt for a string and verify *)
    UIT_BOOLEAN,                (* Prompt for a yes/no response *)
    UIT_INFO,                   (* Send info to the user *)
    UIT_ERROR                   (* Send an error message to the user *)
  );

  (* Create and manipulate methods *)
  UI_method_opener_cb = function(ui: PUI): TIdC_INT;
  UI_method_writer_cb = function(ui: PUI; uis: PUI_String): TIdC_INT;
  UI_method_flusher_cb = function(ui: PUI): TIdC_INT;
  UI_method_reader_cb = function(ui: PUI; uis: PUI_String): TIdC_INT;
  UI_method_closer_cb = function(ui: PUI): TIdC_INT;
  UI_method_data_duplicator_cb = function(ui: PUI; ui_data: Pointer): Pointer;
  UI_method_data_destructor_cb = procedure(ui: PUI; ui_data: Pointer);
  UI_method_prompt_constructor_cb = function(ui: PUI; const object_desc: PIdAnsiChar; const object_name: PIdAnsiChar): PIdAnsiChar;

procedure Load(const ADllHandle: TIdLibHandle; const AFailed: TStringList);
procedure UnLoad;

var
  (*
   * All the following functions return -1 or NULL on error and in some cases
   * (UI_process()) -2 if interrupted or in some other way cancelled. When
   * everything is fine, they return 0, a positive value or a non-NULL pointer,
   * all depending on their purpose.
   *)

  (* Creators and destructor.   *)
  UI_new: function: PUI cdecl = nil;
  UI_new_method: function(const method: PUI_Method): PUI cdecl = nil;
  UI_free: procedure(ui: PUI) cdecl = nil;

  (*
   * The following functions are used to add strings to be printed and prompt
   * strings to prompt for data.  The names are UI_{add,dup}_<function>_string
   * and UI_{add,dup}_input_boolean.
   *
   * UI_{add,dup}_<function>_string have the following meanings:
   *      add     add a text or prompt string.  The pointers given to these
   *              functions are used verbatim, no copying is done.
   *      dup     make a copy of the text or prompt string, then add the copy
   *              to the collection of strings in the user interface.
   *      <function>
   *              The function is a name for the functionality that the given
   *              string shall be used for.  It can be one of:
   *                      input   use the string as data prompt.
   *                      verify  use the string as verification prompt.  This
   *                              is used to verify a previous input.
   *                      info    use the string for informational output.
   *                      error   use the string for error output.
   * Honestly, there's currently no difference between info and error for the
   * moment.
   *
   * UI_{add,dup}_input_boolean have the same semantics for "add" and "dup",
   * and are typically used when one wants to prompt for a yes/no response.
   *
   * All of the functions in this group take a UI and a prompt string.
   * The string input and verify addition functions also take a flag argument,
   * a buffer for the result to end up with, a minimum input size and a maximum
   * input size (the result buffer MUST be large enough to be able to contain
   * the maximum number of characters).  Additionally, the verify addition
   * functions takes another buffer to compare the result against.
   * The boolean input functions take an action description string (which should
   * be safe to ignore if the expected user action is obvious, for example with
   * a dialog box with an OK button and a Cancel button), a string of acceptable
   * characters to mean OK and to mean Cancel.  The two last strings are checked
   * to make sure they don't have common characters.  Additionally, the same
   * flag argument as for the string input is taken, as well as a result buffer.
   * The result buffer is required to be at least one byte long.  Depending on
   * the answer, the first character from the OK or the Cancel character strings
   * will be stored in the first byte of the result buffer.  No NUL will be
   * added, so the result is *not* a string.
   *
   * On success, the all return an index of the added information.  That index
   * is useful when retrieving results with UI_get0_result(). *)

  UI_add_input_string: function(ui: PUI; const prompt: PIdAnsiChar; flags: TIdC_INT; result_buf: PIdAnsiChar; minsize: TIdC_INT; maxsize: TIdC_INT): TIdC_INT cdecl = nil;
  UI_dup_input_string: function(ui: PUI; const prompt: PIdAnsiChar; flags: TIdC_INT; result_buf: PIdAnsiChar; minsize: TIdC_INT; maxsize: TIdC_INT): TIdC_INT cdecl = nil;
  UI_add_verify_string: function(ui: PUI; const prompt: PIdAnsiChar; flags: TIdC_INT; result_buf: PIdAnsiChar; minsize: TIdC_INT; maxsize: TIdC_INT; const test_buf: PIdAnsiChar): TIdC_INT cdecl = nil;
  UI_dup_verify_string: function(ui: PUI; const prompt: PIdAnsiChar; flags: TIdC_INT; result_buf: PIdAnsiChar; minsize: TIdC_INT; maxsize: TIdC_INT; const test_buf: PIdAnsiChar): TIdC_INT cdecl = nil;
  UI_add_input_boolean: function(ui: PUI; const prompt: PIdAnsiChar; const action_desc: PIdAnsiChar; const ok_chars: PIdAnsiChar; const cancel_chars: PIdAnsiChar; flags: TIdC_INT; result_buf: PIdAnsiChar): TIdC_INT cdecl = nil;
  UI_dup_input_boolean: function(ui: PUI; const prompt: PIdAnsiChar; const action_desc: PIdAnsiChar; const ok_chars: PIdAnsiChar; const cancel_chars: PIdAnsiChar; flags: TIdC_INT; result_buf: PIdAnsiChar): TIdC_INT cdecl = nil;
  UI_add_info_string: function(ui: PUI; const text: PIdAnsiChar): TIdC_INT cdecl = nil;
  UI_dup_info_string: function(ui: PUI; const text: PIdAnsiChar): TIdC_INT cdecl = nil;
  UI_add_error_string: function(ui: PUI; const text: PIdAnsiChar): TIdC_INT cdecl = nil;
  UI_dup_error_string: function(ui: PUI; const text: PIdAnsiChar): TIdC_INT cdecl = nil;

  (*
   * The following function helps construct a prompt.  object_desc is a
   * textual short description of the object, for example "pass phrase",
   * and object_name is the name of the object (might be a card name or
   * a file name.
   * The returned string shall always be allocated on the heap with
   * OPENSSL_malloc(), and need to be free'd with OPENSSL_free().
   *
   * If the ui_method doesn't contain a pointer to a user-defined prompt
   * constructor, a default string is built, looking like this:
   *
   *       "Enter {object_desc} for {object_name}:"
   *
   * So, if object_desc has the value "pass phrase" and object_name has
   * the value "foo.key", the resulting string is:
   *
   *       "Enter pass phrase for foo.key:"
   *)
  UI_construct_prompt: function(ui_method: PUI; const object_desc: PIdAnsiChar; const object_name: PIdAnsiChar): PIdAnsiChar cdecl = nil;

  (*
   * The following function is used to store a pointer to user-specific data.
   * Any previous such pointer will be returned and replaced.
   *
   * For callback purposes, this function makes a lot more sense than using
   * ex_data, since the latter requires that different parts of OpenSSL or
   * applications share the same ex_data index.
   *
   * Note that the UI_OpenSSL() method completely ignores the user data. Other
   * methods may not, however.
   *)
  UI_add_user_data: function(ui: PUI; user_data: Pointer): Pointer cdecl = nil;
  (*
   * Alternatively, this function is used to duplicate the user data.
   * This uses the duplicator method function.  The destroy function will
   * be used to free the user data in this case.
   *)
  UI_dup_user_data: function(ui: PUI; user_data: Pointer): TIdC_INT cdecl = nil;
  (* We need a user data retrieving function as well.  *)
  UI_get0_user_data: function(ui: PUI): Pointer cdecl = nil;

  (* Return the result associated with a prompt given with the index i. *)
  UI_get0_result: function(ui: PUI; i: TIdC_INT): PIdAnsiChar cdecl = nil;
  UI_get_result_length: function(ui: PUI; i: TIdC_INT): TIdC_INT cdecl = nil;

  (* When all strings have been added, process the whole thing. *)
  UI_process: function(ui: PUI): TIdC_INT cdecl = nil;

  (*
   * Give a user interface parameterised control commands.  This can be used to
   * send down an integer, a data pointer or a function pointer, as well as be
   * used to get information from a UI.
   *)
  UI_ctrl: function(ui: PUI; cmd: TIdC_INT; i: TIdC_LONG; p: Pointer; f: UI_ctrl_f): TIdC_INT cdecl = nil;


  (* Some methods may use extra data *)
  //# define UI_set_app_data(s,arg)         UI_set_ex_data(s,0,arg)
  //# define UI_get_app_data(s)             UI_get_ex_data(s,0)

  //# define UI_get_ex_new_index(l, p, newf, dupf, freef) \
  //    CRYPTO_get_ex_new_index(CRYPTO_EX_INDEX_UI, l, p, newf, dupf, freef)
  UI_set_ex_data: function(r: PUI; idx: TIdC_INT; arg: Pointer): TIdC_INT cdecl = nil;
  UI_get_ex_data: function(r: PUI; idx: TIdC_INT): Pointer cdecl = nil;

  (* Use specific methods instead of the built-in one *)
  UI_set_default_method: procedure(const meth: PUI_Method) cdecl = nil;
  UI_get_default_method: function: PUI_METHOD cdecl = nil;
  UI_get_method: function(ui: PUI): PUI_METHOD cdecl = nil;
  UI_set_method: function(ui: PUI; const meth: PUI_METHOD): PUI_METHOD cdecl = nil;

  (* The method with all the built-in thingies *)
  UI_OpenSSL: function: PUI_Method cdecl = nil;

  (*
   * NULL method.  Literally does nothing, but may serve as a placeholder
   * to avoid internal default.
   *)
  UI_null: function: PUI_METHOD cdecl = nil;

  (* ---------- For method writers ---------- *)
  (*
     A method contains a number of functions that implement the low level
     of the User Interface.  The functions are:

          an opener       This function starts a session, maybe by opening
                          a channel to a tty, or by opening a window.
          a writer        This function is called to write a given string,
                          maybe to the tty, maybe as a field label in a
                          window.
          a flusher       This function is called to flush everything that
                          has been output so far.  It can be used to actually
                          display a dialog box after it has been built.
          a reader        This function is called to read a given prompt,
                          maybe from the tty, maybe from a field in a
                          window.  Note that it's called with all string
                          structures, not only the prompt ones, so it must
                          check such things itself.
          a closer        This function closes the session, maybe by closing
                          the channel to the tty, or closing the window.

     All these functions are expected to return:

          0       on error.
          1       on success.
          -1      on out-of-band events, for example if some prompting has
                  been canceled (by pressing Ctrl-C, for example).  This is
                  only checked when returned by the flusher or the reader.

     The way this is used, the opener is first called, then the writer for all
     strings, then the flusher, then the reader for all strings and finally the
     closer.  Note that if you want to prompt from a terminal or other command
     line interface, the best is to have the reader also write the prompts
     instead of having the writer do it.  If you want to prompt from a dialog
     box, the writer can be used to build up the contents of the box, and the
     flusher to actually display the box and run the event loop until all data
     has been given, after which the reader only grabs the given data and puts
     them back into the UI strings.

     All method functions take a UI as argument.  Additionally, the writer and
     the reader take a UI_STRING.
  *)

  UI_create_method: function(const name: PIdAnsiChar): PUI_Method cdecl = nil;
  UI_destroy_method: procedure(ui_method: PUI_Method) cdecl = nil;

  UI_method_set_opener: function(method: PUI_Method; opener: UI_method_opener_cb): TIdC_INT cdecl = nil;
  UI_method_set_writer: function(method: PUI_Method; writer: UI_method_writer_cb): TIdC_INT cdecl = nil;
  UI_method_set_flusher: function(method: PUI_Method; flusher: UI_method_flusher_cb): TIdC_INT cdecl = nil;
  UI_method_set_reader: function(method: PUI_Method; reader: UI_method_reader_cb): TIdC_INT cdecl = nil;
  UI_method_set_closer: function(method: PUI_Method; closer: UI_method_closer_cb): TIdC_INT cdecl = nil;
  UI_method_set_data_duplicator: function(method: PUI_Method; duplicator: UI_method_data_duplicator_cb; &destructor: UI_method_data_destructor_cb): TIdC_INT cdecl = nil;
  UI_method_set_prompt_constructor: function(method: PUI_Method; prompt_constructor: UI_method_prompt_constructor_cb): TIdC_INT cdecl = nil;
  UI_method_set_ex_data: function(method: PUI_Method; idx: TIdC_INT; data: Pointer): TIdC_INT cdecl = nil;

  UI_method_get_opener: function(const method: PUI_METHOD): UI_method_opener_cb cdecl = nil;
  UI_method_get_writer: function(const method: PUI_METHOD): UI_method_writer_cb cdecl = nil;
  UI_method_get_flusher: function(const method: PUI_METHOD): UI_method_flusher_cb cdecl = nil;
  UI_method_get_reader: function(const method: PUI_METHOD): UI_method_reader_cb cdecl = nil;
  UI_method_get_closer: function(const method: PUI_METHOD): UI_method_closer_cb cdecl = nil;
  UI_method_get_prompt_constructor: function(const method: PUI_METHOD): UI_method_prompt_constructor_cb cdecl = nil;
  UI_method_get_data_duplicator: function(const method: PUI_METHOD): UI_method_data_duplicator_cb cdecl = nil;
  UI_method_get_data_destructor: function(const method: PUI_METHOD): UI_method_data_destructor_cb cdecl = nil;
  UI_method_get_ex_data: function(const method: PUI_METHOD; idx: TIdC_INT): Pointer cdecl = nil;

  (*
   * The following functions are helpers for method writers to access relevant
   * data from a UI_STRING.
   *)

  (* Return type of the UI_STRING *)
  UI_get_string_type: function(uis: PUI_String): UI_string_types cdecl = nil;
  (* Return input flags of the UI_STRING *)
  UI_get_input_flags: function(uis: PUI_String): TIdC_INT cdecl = nil;
  (* Return the actual string to output (the prompt, info or error) *)
  UI_get0_output_string: function(uis: PUI_String): PIdAnsiChar cdecl = nil;
  (*
   * Return the optional action string to output (the boolean prompt
   * instruction)
   *)
  UI_get0_action_string: function(uis: PUI_String): PIdAnsiChar cdecl = nil;
  (* Return the result of a prompt *)
  UI_get0_result_string: function(uis: PUI_String): PIdAnsiChar cdecl = nil;
  UI_get_result_string_length: function(uis: PUI_String): TIdC_INT cdecl = nil;
  (*
   * Return the string to test the result against.  Only useful with verifies.
   *)
  UI_get0_test_string: function(uis: PUI_String): PIdAnsiChar cdecl = nil;
  (* Return the required minimum size of the result *)
  UI_get_result_minsize: function(uis: PUI_String): TIdC_INT cdecl = nil;
  (* Return the required maximum size of the result *)
  UI_get_result_maxsize: function(uis: PUI_String): TIdC_INT cdecl = nil;
  (* Set the result of a UI_STRING. *)
  UI_set_result: function(ui: PUI; uis: PUI_String; const result: PIdAnsiChar): TIdC_INT cdecl = nil;
  UI_set_result_ex: function(ui: PUI; uis: PUI_String; const result: PIdAnsiChar; len: TIdC_INT): TIdC_INT cdecl = nil;

  (* A couple of popular utility functions *)
  UI_UTIL_read_pw_string: function(buf: PIdAnsiChar; length: TIdC_INT; const prompt: PIdAnsiChar; verify: TIdC_INT): TIdC_INT cdecl = nil;
  UI_UTIL_read_pw: function(buf: PIdAnsiChar; buff: PIdAnsiChar; size: TIdC_INT; const prompt: PIdAnsiChar; verify: TIdC_INT): TIdC_INT cdecl = nil;
  UI_UTIL_wrap_read_pem_callback: function(cb: pem_password_cb; rwflag: TIdC_INT): PUI_Method cdecl = nil;

implementation

procedure Load(const ADllHandle: TIdLibHandle; const AFailed: TStringList);

  function LoadFunction(const AMethodName: string; const AFailed: TStringList): Pointer;
  begin
    Result := LoadLibFunction(ADllHandle, AMethodName);
    if not Assigned(Result) then
      AFailed.Add(AMethodName);
  end;

begin
  UI_new := LoadFunction('UI_new', AFailed);
  UI_new_method := LoadFunction('UI_new_method', AFailed);
  UI_free := LoadFunction('UI_free', AFailed);
  UI_add_input_string := LoadFunction('UI_add_input_string', AFailed);
  UI_dup_input_string := LoadFunction('UI_dup_input_string', AFailed);
  UI_add_verify_string := LoadFunction('UI_add_verify_string', AFailed);
  UI_dup_verify_string := LoadFunction('UI_dup_verify_string', AFailed);
  UI_add_input_boolean := LoadFunction('UI_add_input_boolean', AFailed);
  UI_dup_input_boolean := LoadFunction('UI_dup_input_boolean', AFailed);
  UI_add_info_string := LoadFunction('UI_add_info_string', AFailed);
  UI_dup_info_string := LoadFunction('UI_dup_info_string', AFailed);
  UI_add_error_string := LoadFunction('UI_add_error_string', AFailed);
  UI_dup_error_string := LoadFunction('UI_dup_error_string', AFailed);
  UI_construct_prompt := LoadFunction('UI_construct_prompt', AFailed);
  UI_add_user_data := LoadFunction('UI_add_user_data', AFailed);
  UI_dup_user_data := LoadFunction('UI_dup_user_data', AFailed);
  UI_get0_user_data := LoadFunction('UI_get0_user_data', AFailed);
  UI_get0_result := LoadFunction('UI_get0_result', AFailed);
  UI_get_result_length := LoadFunction('UI_get_result_length', AFailed);
  UI_process := LoadFunction('UI_process', AFailed);
  UI_ctrl := LoadFunction('UI_ctrl', AFailed);
  UI_set_ex_data := LoadFunction('UI_set_ex_data', AFailed);
  UI_get_ex_data := LoadFunction('UI_get_ex_data', AFailed);
  UI_set_default_method := LoadFunction('UI_set_default_method', AFailed);
  UI_get_default_method := LoadFunction('UI_get_default_method', AFailed);
  UI_get_method := LoadFunction('UI_get_method', AFailed);
  UI_set_method := LoadFunction('UI_set_method', AFailed);
  UI_OpenSSL := LoadFunction('UI_OpenSSL', AFailed);
  UI_null := LoadFunction('UI_null', AFailed);
  UI_create_method := LoadFunction('UI_create_method', AFailed);
  UI_destroy_method := LoadFunction('UI_destroy_method', AFailed);
  UI_method_set_opener := LoadFunction('UI_method_set_opener', AFailed);
  UI_method_set_writer := LoadFunction('UI_method_set_writer', AFailed);
  UI_method_set_flusher := LoadFunction('UI_method_set_flusher', AFailed);
  UI_method_set_reader := LoadFunction('UI_method_set_reader', AFailed);
  UI_method_set_closer := LoadFunction('UI_method_set_closer', AFailed);
  UI_method_set_data_duplicator := LoadFunction('UI_method_set_data_duplicator', AFailed);
  UI_method_set_prompt_constructor := LoadFunction('UI_method_set_prompt_constructor', AFailed);
  UI_method_set_ex_data := LoadFunction('UI_method_set_ex_data', AFailed);
  UI_method_get_opener := LoadFunction('UI_method_get_opener', AFailed);
  UI_method_get_writer := LoadFunction('UI_method_get_writer', AFailed);
  UI_method_get_flusher := LoadFunction('UI_method_get_flusher', AFailed);
  UI_method_get_reader := LoadFunction('UI_method_get_reader', AFailed);
  UI_method_get_closer := LoadFunction('UI_method_get_closer', AFailed);
  UI_method_get_prompt_constructor := LoadFunction('UI_method_get_prompt_constructor', AFailed);
  UI_method_get_data_duplicator := LoadFunction('UI_method_get_data_duplicator', AFailed);
  UI_method_get_data_destructor := LoadFunction('UI_method_get_data_destructor', AFailed);
  UI_method_get_ex_data := LoadFunction('UI_method_get_ex_data', AFailed);
  UI_get_string_type := LoadFunction('UI_get_string_type', AFailed);
  UI_get_input_flags := LoadFunction('UI_get_input_flags', AFailed);
  UI_get0_output_string := LoadFunction('UI_get0_output_string', AFailed);
  UI_get0_action_string := LoadFunction('UI_get0_action_string', AFailed);
  UI_get0_result_string := LoadFunction('UI_get0_result_string', AFailed);
  UI_get_result_string_length := LoadFunction('UI_get_result_string_length', AFailed);
  UI_get0_test_string := LoadFunction('UI_get0_test_string', AFailed);
  UI_get_result_minsize := LoadFunction('UI_get_result_minsize', AFailed);
  UI_get_result_maxsize := LoadFunction('UI_get_result_maxsize', AFailed);
  UI_set_result := LoadFunction('UI_set_result', AFailed);
  UI_set_result_ex := LoadFunction('UI_set_result_ex', AFailed);
  UI_UTIL_read_pw_string := LoadFunction('UI_UTIL_read_pw_string', AFailed);
  UI_UTIL_read_pw := LoadFunction('UI_UTIL_read_pw', AFailed);
  UI_UTIL_wrap_read_pem_callback := LoadFunction('UI_UTIL_wrap_read_pem_callback', AFailed);
end;

procedure UnLoad;
begin
  UI_new := nil;
  UI_new_method := nil;
  UI_free := nil;
  UI_add_input_string := nil;
  UI_dup_input_string := nil;
  UI_add_verify_string := nil;
  UI_dup_verify_string := nil;
  UI_add_input_boolean := nil;
  UI_dup_input_boolean := nil;
  UI_add_info_string := nil;
  UI_dup_info_string := nil;
  UI_add_error_string := nil;
  UI_dup_error_string := nil;
  UI_construct_prompt := nil;
  UI_add_user_data := nil;
  UI_dup_user_data := nil;
  UI_get0_user_data := nil;
  UI_get0_result := nil;
  UI_get_result_length := nil;
  UI_process := nil;
  UI_ctrl := nil;
  UI_set_ex_data := nil;
  UI_get_ex_data := nil;
  UI_set_default_method := nil;
  UI_get_default_method := nil;
  UI_get_method := nil;
  UI_set_method := nil;
  UI_OpenSSL := nil;
  UI_null := nil;
  UI_create_method := nil;
  UI_destroy_method := nil;
  UI_method_set_opener := nil;
  UI_method_set_writer := nil;
  UI_method_set_flusher := nil;
  UI_method_set_reader := nil;
  UI_method_set_closer := nil;
  UI_method_set_data_duplicator := nil;
  UI_method_set_prompt_constructor := nil;
  UI_method_set_ex_data := nil;
  UI_method_get_opener := nil;
  UI_method_get_writer := nil;
  UI_method_get_flusher := nil;
  UI_method_get_reader := nil;
  UI_method_get_closer := nil;
  UI_method_get_prompt_constructor := nil;
  UI_method_get_data_duplicator := nil;
  UI_method_get_data_destructor := nil;
  UI_method_get_ex_data := nil;
  UI_get_string_type := nil;
  UI_get_input_flags := nil;
  UI_get0_output_string := nil;
  UI_get0_action_string := nil;
  UI_get0_result_string := nil;
  UI_get_result_string_length := nil;
  UI_get0_test_string := nil;
  UI_get_result_minsize := nil;
  UI_get_result_maxsize := nil;
  UI_set_result := nil;
  UI_set_result_ex := nil;
  UI_UTIL_read_pw_string := nil;
  UI_UTIL_read_pw := nil;
  UI_UTIL_wrap_read_pem_callback := nil;
end;

end.
