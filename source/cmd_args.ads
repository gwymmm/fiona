with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package Cmd_Args is

  type Options is (Option_Score_Set, Option_Compare_Set,
    Flag_Help_Set, Flag_Verbose_Set);

  subtype Flags is Options range Flag_Help_Set .. Flag_Verbose_Set;

  type Execution_Options is array (Options) of Boolean;

  type Execution_Parameter is
    record
      Exec_Opts: Execution_Options := (others => False);
      Input_File_Name: Unbounded_String := To_Unbounded_String("???");
      Output_File_Name: Unbounded_String := To_Unbounded_String("???");
    end record;

  Lexing_Error: exception;
  Parsing_Error: exception;

end Cmd_Args;