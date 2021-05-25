with Ada.Command_Line;

package body Cmd_Args.Lexer is

  procedure Init(Lexer: out Lexer_State) is

    Number_of_Arguments: constant Natural := Ada.Command_Line.Argument_Count;

  begin

    if Number_of_Arguments = 0 then
      Lexer.Arguments_Left := False;
      return;
    end if;

    -- at least one command line argument was passed
    Lexer.Current_Argument_Index := 1;
  end Init;

  function Has_Arguments_Left(Lexer: in Lexer_State) return Boolean is
  begin
    return Lexer.Arguments_Left;
  end Has_Arguments_Left;

end Cmd_Args.Lexer;