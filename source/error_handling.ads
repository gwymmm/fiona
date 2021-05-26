package Error_Handling is

  -- warning messages are simply printed
  -- prepends "Warning: "
  procedure Write_Warning(Warning_Msg: in String);

  -- in case of errors an exception is raised, the error message is attached
  -- to the exception. This helper function concatenates an error message 'Msg'
  -- with line number info
  function Error_Msg(Line_Number: in Positive; Msg: in String) return String;

  procedure Print(Error_Message: in String);

end Error_Handling;