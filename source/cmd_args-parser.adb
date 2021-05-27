with Error_Handling;
with Cmd_Args.Lexer; use Cmd_Args.Lexer;

package body Cmd_Args.Parser is

  type Parser_State is (Start, Stop, Flags_or_Input);

  procedure Parse(Parameter: out Execution_Parameter);

  procedure Read_Command_Line_Arguments(Parameter: out Execution_Parameter) is
  begin

    Parse(Parameter);

  exception
    when Lexing_Error =>
      Error_Handling.Print("Lexical error (command line input):");
      raise;
    when Parsing_Error =>
      Error_Handling.Print("Grammatical error (command line input):");
      raise;    
    when others =>
      Error_Handling.Print("Error (command line input):");
      raise;
  end Read_Command_Line_Arguments;

--------------------------------------------------------------------------------
  -- consume token, set execution parameter accordingly and move to next state
  procedure Next_State(Current_State: in out Parser_State; Token: in Token_Type;
    Parameter: in out Execution_Parameter);

--------------------------------------------------------------------------------
  procedure Parse(Parameter: out Execution_Parameter) is

    Lexer: Lexer_State;
    Current_Token: Token_Type;
    Current_State: Parser_State := Start;

  begin

    Init(Lexer);

    while Current_State /= Stop loop

      Next_Token(Lexer, Current_Token);
      Next_State(Current_State, Current_Token, Parameter);

    end loop;

  end Parse;

--------------------------------------------------------------------------------
-- procedures mapping to grammar rules

  procedure Evaluate_Start(Token: in Token_Type;
    Parameter in out Execution_Parameter);

  procedure Evaluate_Flags_or_Input(Token: in Token_Type;
    Parameter in out Execution_Parameter);

--------------------------------------------------------------------------------
  procedure Next_State(Current_State: in out Parser_State; Token: in Token_Type;
    Parameter: in out Execution_Parameter) is
  begin

    case Current_State is
      when Start =>
        Evaluate_Start(Token, Parameter);
      when Flags_or_Input =>
        Evaluate_Flags_or_Input(Token, Parameter);
      when Stop =>
        raise Parsing_Error with "Bug: Cannot be in STOP state here.";
    end case;

  end Next_State;

  --  START :=
  --    <score option> FLAGS_OR_INPUT
  --    <compare option> FLAGS_OR_INPUT
  --    <flag> FLAGS_OR_INPUT
  --    <char sequence> END 
  procedure Evaluate_Start(Token: in Token_Type;
    Parameter in out Execution_Parameter) is

    TK: Token_Kind;
    
  begin

    TK := Get_Kind(Token);
    --> TODO
    case TK is
      when Score_Option =>
      when Compare_Option =>
      when Flag =>
      when Char_Sequence =>
      when others =>
        raise Parsing_Error with "Expected an option, a flag or a file name. "
          & "Seen: " & TK'Image;
    end case;

  end Evaluate_Start;

end Cmd_Args.Parser;