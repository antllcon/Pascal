PROGRAM Test(INPUT, OUTPUT);

VAR
  F: TEXT;
  Ch: CHAR;
  Finished: BOOLEAN;  (* Flag to control loop termination *)

BEGIN
  ASSIGN(F, 'poem.txt');
  RESET(F);

  Finished := FALSE;

  WHILE NOT(EOF(F)) AND NOT Finished DO  (* Added Finished flag *)
    BEGIN
      WHILE NOT(EOLN(F)) AND NOT Finished DO  (* Added Finished flag *)
        BEGIN
          READ(F, Ch);
          WHILE (Ch <> ' ') AND NOT Finished DO  (* Added Finished flag *)
            BEGIN
              WRITE(Ch);
              READ(F, Ch);
            END;
          
        END;
       IF NOT(EOF(F)) 
       THEN
         READLN(F)
    END;
  CLOSE(F);
END.