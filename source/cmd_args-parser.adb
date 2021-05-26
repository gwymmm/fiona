with Error_Handling;

package body Cmd_Args.Parser is

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


procedure Parse(Parameter: out Execution_Parameter) is
begin
  raise Parsing_Error with "Seen strange token";
end Parse;

end Cmd_Args.Parser;