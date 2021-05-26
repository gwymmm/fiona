with Ada.Containers.Ordered_Maps;
with Ada.Strings.Unbounded;

package Cmd_Args.Lexer is

  type Lexer_State is private;
  type Token is private;

  -- since flags can come in any order it would be tedious to implement each
  -- kind of flag in the grammar, so there is the more generic 'Flag' token.
  type Token_Kind is (Score_Option, Compare_Option, Flag, Char_Sequence,
    End_of_Arguments);

  procedure Init(Lexer: out Lexer_State);

  -- Get_Token_Value for (1) flags and (2) char sequences

private

  use Ada.Strings.Unbounded;

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

  type Token is
    record
      Kind: Token_Kind := End_of_Arguments;
      Flag_Value: Flags := Flag_Help;
      Char_Sequence_Value: Unbounded_String := To_Unbounded_String("???");
    end record;

end Cmd_Args.Lexer;