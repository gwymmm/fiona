package Cmd_Args is

  type Options is (Option_Score, Option_Compare, Flag_Help, Flag_Verbose);

  subtype Flags is Options range Flag_Help .. Flag_Verbose;

  type Execution_Options is array (Options) of Boolean;

end Cmd_Args;