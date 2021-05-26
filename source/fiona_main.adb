with Ada.Command_Line; use Ada.Command_Line;
with Ada.Exceptions; use Ada.Exceptions;

with Fiona;
with Error_Handling;

procedure Fiona_Main is
begin

  Fiona.Run_Main;

  Set_Exit_Status(Success);

exception
  when Error: others =>
    Error_Handling.Print(
      Exception_Name(Error) & ": " & Exception_Message(Error));
    Set_Exit_Status(Failure);

end Fiona_Main;