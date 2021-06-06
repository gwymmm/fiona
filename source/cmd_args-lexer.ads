with Ada.Containers.Ordered_Maps;

package Cmd_Args.Lexer is

  type Lexer_State is private;
  type Token_Type is private;

  -- since flags can come in any order it would be tedious to implement each
  -- kind of flag in the grammar, so there is the more generic 'Flag' token.
  type Token_Kind is (Score_Option, Compare_Option, Flag, Char_Sequence,
    End_of_Arguments);

  procedure Init(Lexer: out Lexer_State);

  procedure Next_Token(Lexer: in out Lexer_State; Token: out Token_Type);

  function Get_Kind(Token: in Token_Type) return Token_Kind;

  function Get_Value(Token: in Token_Type) return Flags
    with Pre => ( Get_Kind(Token) = Flag );

  function Get_Value(Token: in Token_Type) return Unbounded_String
    with Pre => ( Get_Kind(Token) = Char_Sequence );

  -- Get_Token_Value for (1) flags and (2) char sequences

private

  -- key type can't be an indefinite type like String, so take Unbounded String
  package Option_Map is new Ada.Containers.Ordered_Maps(
    Key_Type => Unbounded_String, Element_Type => Options,
    "<" => "<", "=" => "=");

  use Option_Map;

  type Lexer_State is  
    record
      Number_of_Arguments : Natural := 0;
      Current_Argument_Index: Positive := 1;
      String_to_Option_Map : Map := Empty_Map;
    end record;

  type Token_Type is
    record
      Kind: Token_Kind := End_of_Arguments;
      Flag_Value: Flags := Flag_Help_Set;
      Char_Sequence_Value: Unbounded_String := To_Unbounded_String("???");
    end record;

  function Get_Kind(Token: in Token_Type) return Token_Kind is (Token.Kind);

  function Get_Value(Token: in Token_Type) return Flags is (Token.Flag_Value);

  function Get_Value(Token: in Token_Type) return Unbounded_String is
    (Token.Char_Sequence_Value);

end Cmd_Args.Lexer;