with Error_Handling;
with Cmd_Args.Lexer; use Cmd_Args.Lexer;

package body Cmd_Args.Parser is

  type Parser_State is (Start, Stop, Flags_or_Input, Expect_End);

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
  function Not_Set(File_Name: in Unbounded_String) return Boolean is 
    (File_Name = "???");

-- procedures mapping to grammar rules


-- value of Current_State needed in precondition, so passed as 'in out'
  procedure Evaluate_Start(Token: in Token_Type;
    Parameter: in out Execution_Parameter; Current_State: in out Parser_State)
      with Pre => Current_State = Start and
        Not_Set(Parameter.Input_File_Name);

  procedure Evaluate_Flags_or_Input(Token: in Token_Type;
    Parameter: in out Execution_Parameter; Current_State: in out Parser_State)
      with Pre => Current_State = Flags_or_Input and
        Not_Set(Parameter.Input_File_Name);

--------------------------------------------------------------------------------
  procedure Next_State(Current_State: in out Parser_State; Token: in Token_Type;
    Parameter: in out Execution_Parameter) is
  begin

    case Current_State is
      when Start =>
        Evaluate_Start(Token, Parameter, Current_State);
      when Flags_or_Input =>
        --Evaluate_Flags_or_Input(Token, Parameter, Current_State);
        null;
      when Expect_End =>
        null;
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
    Parameter: in out Execution_Parameter; Current_State: in out Parser_State)
  is

    TK: Token_Kind;
    Next_State: Parser_State;
    
  begin

    TK := Get_Kind(Token);

    case TK is
      when Score_Option =>

        Parameter.Exec_Opts(Option_Score_Set) := True;
        Next_State := Flags_or_Input;

      when Compare_Option =>

        Parameter.Exec_Opts(Option_Compare_Set) := True;
        Next_State := Flags_or_Input;

      when Flag =>

        Parameter.Exec_Opts(Get_Value(Token)) := True;
        Next_State := Flags_or_Input;

      when Char_Sequence =>

        Parameter.Input_File_Name := Get_Value(Token);
        Next_State := End_of_Input;

      when others =>
        raise Parsing_Error with "Expected an option, a flag or a file name. "
          & "Seen: " & TK'Image;
    end case;

    Current_State := Next_State;

  end Evaluate_Start;


  --  FLAGS_OR_INPUT :=
  --   <flag> FLAGS_OR_INPUT
  --   <char sequence> END
  procedure Evaluate_Flags_or_Input(Token: in Token_Type;
    Parameter: in out Execution_Parameter; Current_State: in out Parser_State)
  is

    TK: Token_Kind;
    Next_State: Parser_State;
    
  begin

    TK := Get_Kind(Token);

    case TK is
      when Flag =>

        Parameter.Exec_Opts(Get_Value(Token)) := True;
        Next_State := Flags_or_Input;

      when Char_Sequence =>

        Parameter.Input_File_Name := Get_Value(Token);
        Next_State := End_of_Input;

    end case;

    Current_State := Next_State;

  end Evaluate_Flags_or_Input;

end Cmd_Args.Parser;