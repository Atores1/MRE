LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE work.bookUtility.ALL; -- for toString
USE std.textio.ALL;

ENTITY processor_tb IS
END;

ARCHITECTURE bench OF processor_tb IS
  SIGNAL tHall : STD_LOGIC;
  SIGNAL tLED : STD_LOGIC;
  SIGNAL tTest : STD_LOGIC_VECTOR(5 DOWNTO 0);
  SIGNAL tTestUn : STD_LOGIC;
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
    tHall <= '0';
    --ASSERT tQ = "0" REPORT "reset failed" SEVERITY failure;

    WAIT FOR 10 ns; --count up
    vypis;

    --ASSERT tQ = "0" REPORT "count 0001" SEVERITY failure;
    WAIT FOR 10 ns; --count up
    vypis;

    tHall <= '1';
    WAIT FOR 60 ns; --count up
    tHall <= '0';
    WAIT FOR 50 ns; --count up
    tHall <= '1';
    WAIT FOR 60 ns; --count up
    tHall <= '0';
    WAIT FOR 50 ns; --count up
    tHall <= '1';
    WAIT FOR 60 ns; --count up
    tHall <= '0';
    WAIT FOR 40 ns; --count up
    -- end
    clockEnable <= '0';
    REPORT "Test OK";
    WAIT;

  END PROCESS;

  UUT : ENTITY work.processor PORT MAP(tClk, tHall,tTest,tTestUn);

END bench;