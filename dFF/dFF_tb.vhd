LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE work.bookUtility.ALL; -- for toString
USE std.textio.ALL;

ENTITY dFF_tb IS
END;

ARCHITECTURE bench OF dFF_tb IS
  SIGNAL tQ : STD_LOGIC;
  SIGNAL tD : STD_LOGIC := '0';
  SIGNAL tClk : STD_LOGIC := '0';
  SIGNAL clockEnable : STD_LOGIC := '1';

BEGIN

  clock : PROCESS

  BEGIN
    WHILE clockEnable = '1' LOOP
      WAIT FOR 5 ns;
      tClk <= NOT tClk;
      -- REPORT "Clock tick [" & std_logic'image(tClk) & "]";
    END LOOP;
    WAIT;
  END PROCESS;

  testing : PROCESS

    FILE log : text OPEN write_mode IS "counter4b.txt";
    VARIABLE row : line;

    PROCEDURE vypis IS
    BEGIN
      --write(row, tQ, left, 5);
      --write(row, tD, left, 5);
      --writeline(log, row);
    END PROCEDURE;

  BEGIN
    WAIT FOR 1 ns;
    vypis;

    --ASSERT tQ = "0" REPORT "reset failed" SEVERITY failure;

    WAIT FOR 10 ns; --count up
    vypis;
    tD <= '1';

    --ASSERT tQ = "0" REPORT "count 0001" SEVERITY failure;
    WAIT FOR 10 ns; --count up
    vypis;

    WAIT FOR 10 ns; --count up
    vypis;

    tD <= '0';
        WAIT FOR 10 ns; --count up
    vypis;
        WAIT FOR 10 ns; --count up
    vypis;

    -- end
    clockEnable <= '0';
    REPORT "Test OK";
    WAIT;

  END PROCESS;

  UUT : ENTITY work.dFF PORT MAP(tClk,tD, tQ);

END bench;