LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE work.bookUtility.ALL; -- for toString
USE std.textio.ALL;

ENTITY adderGeneric_tb IS
END;

ARCHITECTURE bench OF adderGeneric_tb IS
  SIGNAL tIn1 : std_logic_vector (2 DOWNTO 0):= (others => '0');
  SIGNAL tIn2 : std_logic_vector (2 DOWNTO 0):= (others => '0');
  SIGNAL tQ : std_logic_vector (3 DOWNTO 0);
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
      REPORT toString(tQ);
      write(row, toString(tQ), left, 5);
      write(row, toString(tQ), left, 5);
      writeline(log, row);
    END PROCEDURE;

  BEGIN
    vypis;
    -- ASSERT tQ = "0000" REPORT "reset failed" SEVERITY failure;
    tIn1 <= "010";
    tIn2 <= "010";
    WAIT FOR 10 ns; --count up
    vypis;
    ASSERT tQ = "0100" REPORT "count 0001" SEVERITY failure;
    tIn1 <= "110";
    tIn2 <= "010";
    WAIT FOR 10 ns; --count up
    vypis;
    ASSERT tQ = "1000" REPORT "count 0001" SEVERITY failure;



    -- end
    clockEnable <= '0';
    REPORT "Test OK";
    WAIT;

  END PROCESS;

  UUT : ENTITY work.adderGeneric GENERIC MAP(4) PORT MAP(tIn1, tIn2, tQ);

END bench;