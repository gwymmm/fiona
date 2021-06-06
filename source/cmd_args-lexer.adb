with Ada.Command_Line;

package body Cmd_Args.Lexer is

  --function Get_Kind(Token: in Token_Type) return Token_Kind is
  --begin
  --  return Token.Kind;
  --end Get_Kind;

  procedure Init(Lexer: out Lexer_State) is
  begin

    Lexer.Number_of_Arguments := Ada.Command_Line.Argument_Count;
    Lexer.Current_Argument_Index := 1;

    Insert(Lexer.String_to_Option_Map,
      To_Unbounded_String("score"), Option_Score_Set);
    Insert(Lexer.String_to_Option_Map,
      To_Unbounded_String("compare"), Option_Compare_Set);

    Insert(Lexer.String_to_Option_Map,
      To_Unbounded_String("-h"), Flag_Help_Set);
    Insert(Lexer.String_to_Option_Map,
      To_Unbounded_String("--help"), Flag_Help_Set);
    Insert(Lexer.String_to_Option_Map,
      To_Unbounded_String("-v"), Flag_Verbose_Set);
    Insert(Lexer.String_to_Option_Map,
      To_Unbounded_String("--verbose"), Flag_Verbose_Set);

  end Init;

  -- set token kind and flag value according to recognized option
  procedure Set_Token(Token: out Token_Type; Recognized_Option: in Options);


  procedure Next_Token(Lexer: in out Lexer_State; Token: out Token_Type) is
    Current_Argument_Value: Unbounded_String;
  begin

    if Lexer.Current_Argument_Index <= Lexer.Number_of_Arguments then

      Current_Argument_Value := To_Unbounded_String(
        Ada.Command_Line.Argument(Lexer.Current_Argument_Index) );

      if Contains(Lexer.String_to_Option_Map, Current_Argument_Value) then

        -- flag or option seen
        Set_Token(Token,
          Element(Lexer.String_to_Option_Map, Current_Argument_Value) );

      elsif ( Length(Current_Argument_Value) > 1 and then
              Element(Current_Argument_Value, 1) = '-' ) then

        -- unknown flag seen
        raise Lexing_Error with "Encountered unknown flag: " &
          To_String(Current_Argument_Value);

      else

        -- character sequence seen
        Token.Kind := Char_Sequence;
        Token.Char_Sequence_Value := Current_Argument_Value;

      end if;

      -- move to next command line argument
      Lexer.Current_Argument_Index := Lexer.Current_Argument_Index + 1;

    else

      -- no arguments left
      Token.Kind := End_of_Arguments;

    end if;

  end Next_Token;


  procedure Set_Token(Token: out Token_Type; Recognized_Option: in Options) is
  begin

    case Recognized_Option is

      when Option_Score_Set =>

        Token.Kind := Score_Option;

      when Option_Compare_Set =>

        Token.Kind := Compare_Option;

      when (Flags) =>

        Token.Kind := Flag;
        Token.Flag_Value := Recognized_Option;

    end case;

  end Set_Token;

end Cmd_Args.Lexer;