with Ada.Command_Line; use Ada.Command_Line;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Exceptions; use Ada.Exceptions;

with Fiona;

procedure Fiona_Main is
begin

  Fiona.Run_Main;

  Set_Exit_Status(Success);

exception
  when Error: others =>
    Put_Line(Exception_Name(Error));
    Put_Line(Exception_Message(Error));
    Set_Exit_Status(Failure);

end Fiona_Main;