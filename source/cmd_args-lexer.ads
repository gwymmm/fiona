package Cmd_Args.Lexer is

  type Lexer_State is private;

  procedure Init(Lexer: out Lexer_State);

  function Has_Arguments_Left(Lexer: in Lexer_State) return Boolean;

private

  type Lexer_State is
    record

      Arguments_Left : Boolean := False;
      Current_Argument_Index: Positive := 1;

    end record;

end Cmd_Args.Lexer;