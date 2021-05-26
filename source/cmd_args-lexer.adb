with Ada.Command_Line;

package body Cmd_Args.Lexer is

  procedure Init(Lexer: out Lexer_State) is
  begin

    Lexer.Number_of_Arguments := Ada.Command_Line.Argument_Count;
    Lexer.Current_Argument_Index := 1;

    Insert(Lexer.String_to_Option_Map,
      To_Unbounded_String("score"), Option_Score);
    Insert(Lexer.String_to_Option_Map,
      To_Unbounded_String("compare"), Option_Compare);

    Insert(Lexer.String_to_Option_Map,
      To_Unbounded_String("-h"), Flag_Help);
    Insert(Lexer.String_to_Option_Map,
      To_Unbounded_String("--help"), Flag_Help);
    Insert(Lexer.String_to_Option_Map,
      To_Unbounded_String("-v"), Flag_Verbose);
    Insert(Lexer.String_to_Option_Map,
      To_Unbounded_String("--verbose"), Flag_Verbose);

  end Init;

end Cmd_Args.Lexer;