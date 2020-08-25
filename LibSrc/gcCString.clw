  MEMBER

  MAP
    MODULE('')
      OutputDebugString(*CSTRING), PASCAL, RAW, NAME('OutputDebugStringA')
    END
  END

  INCLUDE('gcCString.inc'),ONCE


! Init


gcCString.Construct    PROCEDURE!, PROTECTED
  CODE

  
gcCString.Destruct     PROCEDURE!, PROTECTED, VIRTUAL
  CODE
  SELF.Destroy()


gcCString.Init    PROCEDURE(LONG pSize)!, VIRTUAL
  CODE
  SELF.Destroy()
  IF pSize <= 1 THEN pSize = 1 END
  SELF.Value &= NEW CSTRING(pSize)
  SELF.Value[1] = '<0>'
  

gcCString.Destroy    PROCEDURE()!, VIRTUAL
  CODE
  IF NOT SELF.Value &= NULL THEN
    DISPOSE(SELF.Value)
  END


gcCString._New        PROCEDURE(LONG pSize) !, STATIC ! Can only be called from a instantiated class, causes a GPF when called from a class reference
sString               &gcCString
  CODE
  sString &= NEW gcCString
  sString.Init(pSize)
  RETURN sString

  
! Properties


gcCString.Resize      PROCEDURE(LONG pSize, BYTE pAppend=False)!, VIRTUAL
sValue                &CSTRING
  CODE
  sValue &= SELF.Value
  IF pAppend THEN
    SELF.Init(SIZE(SELF.Value) + pSize)
  ELSE
    SELF.Init(pSize)
  END
  IF NOT sValue &= NULL THEN
    SELF.Value = sValue
  END
  DISPOSE(sValue)

  
! Debug

        
gcCString.DebugOutput  PROCEDURE(STRING pMessage)!, VIRTUAL
Msg CSTRING(2048)
  CODE
  Msg = 'gcCString: ' & pMessage
  OutputDebugString(Msg)


