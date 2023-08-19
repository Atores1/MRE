LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE work.bookUtility.ALL; -- for toString
USE std.textio.ALL;

ENTITY registerGeneric_tb IS
END;

ARCHITECTURE bench OF registerGeneric_tb IS
  SIGNAL tQ : std_logic_vector (3 DOWNTO 0);
  SIGNAL tD : std_logic_vector (3 DOWNTO 0);
  SIGNAL tLoad: STD_LOGIC;
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

    FILE log : text OPEN write_mode IS "registerGeneric.txt";
    VARIABLE row : line;

    PROCEDURE vypis IS
    BEGIN
      REPORT toString(tQ);
      write(row, toString(tD), left, 5);
      writeline(log, row);
    END PROCEDURE;

  BEGIN
    clockEnable <= '1';
    WAIT FOR 1 ns;
    vypis;

    ASSERT tQ = "0000" REPORT "reset failed" SEVERITY failure;

    WAIT FOR 10 ns; --count up
    vypis;
    ASSERT tQ = "0000" REPORT "count 0001" SEVERITY failure;

    tD <= "1010";
    tLoad <= '1';
    WAIT FOR 10 ns; --count up
    tLoad <= '0';
    vypis;
    ASSERT tQ = "1010" REPORT "count 0001" SEVERITY failure;
    
    
    WAIT FOR 10 ns; --count up
    vypis;
    ASSERT tQ = "1010" REPORT "count 0001" SEVERITY failure;
    
    tD <= "0101";
    tLoad <= '1';
    WAIT FOR 10 ns; --count up
    tLoad <= '0';
    vypis;
    ASSERT tQ = "0101" REPORT "count 0001" SEVERITY failure;

    WAIT FOR 10 ns; --count up
    vypis;
    ASSERT tQ = "0101" REPORT "count 0001" SEVERITY failure;

    -- end
    clockEnable <= '0';
    REPORT "Test OK";
    WAIT;

  END PROCESS;

  UUT : ENTITY work.registerGeneric GENERIC MAP(4) PORT MAP(tClk,tLoad, tD,tQ);

END bench;