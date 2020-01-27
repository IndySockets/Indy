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

unit IdOpenSSLHeaders_ui;

interface

// Headers for OpenSSL 1.1.1
// ui.h

{$i IdCompilerDefines.inc}

uses
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

var
  (*
   * All the following functions return -1 or NULL on error and in some cases
   * (UI_process()) -2 if interrupted or in some other way cancelled. When
   * everything is fine, they return 0, a positive value or a non-NULL pointer,
   * all depending on their purpose.
   *)

  (* Creators and destructor.   *)
  function UI_new: PUI;
  function UI_new_method(const method: PUI_Method): PUI;
  procedure UI_free(ui: PUI);

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

  function UI_add_input_string(ui: PUI; const prompt: PIdAnsiChar; flags: TIdC_INT; result_buf: PIdAnsiChar; minsize: TIdC_INT; maxsize: TIdC_INT): TIdC_INT;
  function UI_dup_input_string(ui: PUI; const prompt: PIdAnsiChar; flags: TIdC_INT; result_buf: PIdAnsiChar; minsize: TIdC_INT; maxsize: TIdC_INT): TIdC_INT;
  function UI_add_verify_string(ui: PUI; const prompt: PIdAnsiChar; flags: TIdC_INT; result_buf: PIdAnsiChar; minsize: TIdC_INT; maxsize: TIdC_INT; const test_buf: PIdAnsiChar): TIdC_INT;
  function UI_dup_verify_string(ui: PUI; const prompt: PIdAnsiChar; flags: TIdC_INT; result_buf: PIdAnsiChar; minsize: TIdC_INT; maxsize: TIdC_INT; const test_buf: PIdAnsiChar): TIdC_INT;
  function UI_add_input_boolean(ui: PUI; const prompt: PIdAnsiChar; const action_desc: PIdAnsiChar; const ok_chars: PIdAnsiChar; const cancel_chars: PIdAnsiChar; flags: TIdC_INT; result_buf: PIdAnsiChar): TIdC_INT;
  function UI_dup_input_boolean(ui: PUI; const prompt: PIdAnsiChar; const action_desc: PIdAnsiChar; const ok_chars: PIdAnsiChar; const cancel_chars: PIdAnsiChar; flags: TIdC_INT; result_buf: PIdAnsiChar): TIdC_INT;
  function UI_add_info_string(ui: PUI; const text: PIdAnsiChar): TIdC_INT;
  function UI_dup_info_string(ui: PUI; const text: PIdAnsiChar): TIdC_INT;
  function UI_add_error_string(ui: PUI; const text: PIdAnsiChar): TIdC_INT;
  function UI_dup_error_string(ui: PUI; const text: PIdAnsiChar): TIdC_INT;

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
  function UI_construct_prompt(ui_method: PUI; const object_desc: PIdAnsiChar; const object_name: PIdAnsiChar): PIdAnsiChar;

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
  function UI_add_user_data(ui: PUI; user_data: Pointer): Pointer;
  (*
   * Alternatively, this function is used to duplicate the user data.
   * This uses the duplicator method function.  The destroy function will
   * be used to free the user data in this case.
   *)
  function UI_dup_user_data(ui: PUI; user_data: Pointer): TIdC_INT;
  (* We need a user data retrieving function as well.  *)
  function UI_get0_user_data(ui: PUI): Pointer;

  (* Return the result associated with a prompt given with the index i. *)
  function UI_get0_result(ui: PUI; i: TIdC_INT): PIdAnsiChar;
  function UI_get_result_length(ui: PUI; i: TIdC_INT): TIdC_INT;

  (* When all strings have been added, process the whole thing. *)
  function UI_process(ui: PUI): TIdC_INT;

  (*
   * Give a user interface parameterised control commands.  This can be used to
   * send down an integer, a data pointer or a function pointer, as well as be
   * used to get information from a UI.
   *)
  function UI_ctrl(ui: PUI; cmd: TIdC_INT; i: TIdC_LONG; p: Pointer; f: UI_ctrl_f): TIdC_INT;


  (* Some methods may use extra data *)
  //# define UI_set_app_data(s,arg)         UI_set_ex_data(s,0,arg)
  //# define UI_get_app_data(s)             UI_get_ex_data(s,0)

  //# define UI_get_ex_new_index(l, p, newf, dupf, freef) \
  //    CRYPTO_get_ex_new_index(CRYPTO_EX_INDEX_UI, l, p, newf, dupf, freef)
  function UI_set_ex_data(r: PUI; idx: TIdC_INT; arg: Pointer): TIdC_INT;
  function UI_get_ex_data(r: PUI; idx: TIdC_INT): Pointer;

  (* Use specific methods instead of the built-in one *)
  procedure UI_set_default_method(const meth: PUI_Method);
  function UI_get_default_method: PUI_METHOD;
  function UI_get_method(ui: PUI): PUI_METHOD;
  function UI_set_method(ui: PUI; const meth: PUI_METHOD): PUI_METHOD;

  (* The method with all the built-in thingies *)
  function UI_OpenSSL: PUI_Method;

  (*
   * NULL method.  Literally does nothing, but may serve as a placeholder
   * to avoid internal default.
   *)
  function UI_null: PUI_METHOD;

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

  function UI_create_method(const name: PIdAnsiChar): PUI_Method;
  procedure UI_destroy_method(ui_method: PUI_Method);

  function UI_method_set_opener(method: PUI_Method; opener: UI_method_opener_cb): TIdC_INT;
  function UI_method_set_writer(method: PUI_Method; writer: UI_method_writer_cb): TIdC_INT;
  function UI_method_set_flusher(method: PUI_Method; flusher: UI_method_flusher_cb): TIdC_INT;
  function UI_method_set_reader(method: PUI_Method; reader: UI_method_reader_cb): TIdC_INT;
  function UI_method_set_closer(method: PUI_Method; closer: UI_method_closer_cb): TIdC_INT;
  function UI_method_set_data_duplicator(method: PUI_Method; duplicator: UI_method_data_duplicator_cb; &destructor: UI_method_data_destructor_cb): TIdC_INT;
  function UI_method_set_prompt_constructor(method: PUI_Method; prompt_constructor: UI_method_prompt_constructor_cb): TIdC_INT;
  function UI_method_set_ex_data(method: PUI_Method; idx: TIdC_INT; data: Pointer): TIdC_INT;

  function UI_method_get_opener(const method: PUI_METHOD): UI_method_opener_cb;
  function UI_method_get_writer(const method: PUI_METHOD): UI_method_writer_cb;
  function UI_method_get_flusher(const method: PUI_METHOD): UI_method_flusher_cb;
  function UI_method_get_reader(const method: PUI_METHOD): UI_method_reader_cb;
  function UI_method_get_closer(const method: PUI_METHOD): UI_method_closer_cb;
  function UI_method_get_prompt_constructor(const method: PUI_METHOD): UI_method_prompt_constructor_cb;
  function UI_method_get_data_duplicator(const method: PUI_METHOD): UI_method_data_duplicator_cb;
  function UI_method_get_data_destructor(const method: PUI_METHOD): UI_method_data_destructor_cb;
  function UI_method_get_ex_data(const method: PUI_METHOD; idx: TIdC_INT): Pointer;

  (*
   * The following functions are helpers for method writers to access relevant
   * data from a UI_STRING.
   *)

  (* Return type of the UI_STRING *)
  function UI_get_string_type(uis: PUI_String): UI_string_types;
  (* Return input flags of the UI_STRING *)
  function UI_get_input_flags(uis: PUI_String): TIdC_INT;
  (* Return the actual string to output (the prompt, info or error) *)
  function UI_get0_output_string(uis: PUI_String): PIdAnsiChar;
  (*
   * Return the optional action string to output (the boolean prompt
   * instruction)
   *)
  function UI_get0_action_string(uis: PUI_String): PIdAnsiChar;
  (* Return the result of a prompt *)
  function UI_get0_result_string(uis: PUI_String): PIdAnsiChar;
  function UI_get_result_string_length(uis: PUI_String): TIdC_INT;
  (*
   * Return the string to test the result against.  Only useful with verifies.
   *)
  function UI_get0_test_string(uis: PUI_String): PIdAnsiChar;
  (* Return the required minimum size of the result *)
  function UI_get_result_minsize(uis: PUI_String): TIdC_INT;
  (* Return the required maximum size of the result *)
  function UI_get_result_maxsize(uis: PUI_String): TIdC_INT;
  (* Set the result of a UI_STRING. *)
  function UI_set_result(ui: PUI; uis: PUI_String; const result: PIdAnsiChar): TIdC_INT;
  function UI_set_result_ex(ui: PUI; uis: PUI_String; const result: PIdAnsiChar; len: TIdC_INT): TIdC_INT;

  (* A couple of popular utility functions *)
  function UI_UTIL_read_pw_string(buf: PIdAnsiChar; length: TIdC_INT; const prompt: PIdAnsiChar; verify: TIdC_INT): TIdC_INT;
  function UI_UTIL_read_pw(buf: PIdAnsiChar; buff: PIdAnsiChar; size: TIdC_INT; const prompt: PIdAnsiChar; verify: TIdC_INT): TIdC_INT;
  function UI_UTIL_wrap_read_pem_callback(cb: pem_password_cb; rwflag: TIdC_INT): PUI_Method;

implementation

end.
