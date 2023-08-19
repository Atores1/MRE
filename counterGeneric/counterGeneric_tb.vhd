LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE work.bookUtility.ALL; -- for toString
USE std.textio.ALL;

ENTITY counterGeneric_tb IS
END;

ARCHITECTURE bench OF counterGeneric_tb IS
  SIGNAL tQ : std_logic_vector (3 DOWNTO 0);
  SIGNAL tReset : STD_LOGIC;
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

    ASSERT tQ = "0000" REPORT "reset failed" SEVERITY failure;

    WAIT FOR 10 ns; --count up
    vypis;
    ASSERT tQ = "0001" REPORT "count 0001" SEVERITY failure;

    WAIT FOR 10 ns; --count up
    vypis;
    ASSERT tQ = "0010" REPORT "count 0001" SEVERITY failure;
    WAIT FOR 10 ns; --count up
    vypis;
    ASSERT tQ = "0011" REPORT "count 0001" SEVERITY failure;
    WAIT FOR 10 ns; --count up
    vypis;
    ASSERT tQ = "0100" REPORT "count 0001" SEVERITY failure;

    tReset <= '1';
    WAIT FOR 10 ns; --wait for clock
    tReset <= '0';
    vypis;
    ASSERT tQ = "0000" REPORT "count 0001" SEVERITY failure;
    WAIT FOR 10 ns; --count up
    vypis;
    ASSERT tQ = "0001" REPORT "count 0001" SEVERITY failure;
    WAIT FOR 10 ns; --count up
    vypis;
    ASSERT tQ = "0010" REPORT "count 0001" SEVERITY failure;
    WAIT FOR 10 ns; --count up
    vypis;
    ASSERT tQ = "0011" REPORT "count 0001" SEVERITY failure;
    WAIT FOR 10 ns; --count up
    vypis;
    ASSERT tQ = "0100" REPORT "count 0001" SEVERITY failure;
    WAIT FOR 10 ns; --count up
    vypis;
    ASSERT tQ = "0101" REPORT "count 0001" SEVERITY failure;
    WAIT FOR 10 ns; --count up
    vypis;
    ASSERT tQ = "0110" REPORT "count 0001" SEVERITY failure;
    WAIT FOR 10 ns; --count up
    vypis;
    ASSERT tQ = "0111" REPORT "count 0001" SEVERITY failure;
    WAIT FOR 10 ns; --count up
    vypis;
    ASSERT tQ = "1000" REPORT "count 0001" SEVERITY failure;
    WAIT FOR 10 ns; --count up
    vypis;
    ASSERT tQ = "1001" REPORT "count 0001" SEVERITY failure;
    WAIT FOR 10 ns; --count up
    vypis;
    ASSERT tQ = "1010" REPORT "count 0001" SEVERITY failure;
    WAIT FOR 10 ns; --count up
    vypis;
    ASSERT tQ = "1011" REPORT "count 0001" SEVERITY failure;
    WAIT FOR 10 ns; --count up
    vypis;
    ASSERT tQ = "1100" REPORT "count 0001" SEVERITY failure;
    WAIT FOR 10 ns; --count up
    vypis;
    ASSERT tQ = "1101" REPORT "count 0001" SEVERITY failure;
    WAIT FOR 10 ns; --count up
    vypis;
    ASSERT tQ = "1110" REPORT "count 0001" SEVERITY failure;
    WAIT FOR 10 ns; --count up
    vypis;
    ASSERT tQ = "1111" REPORT "count 0001" SEVERITY failure;
    WAIT FOR 10 ns; --count up
    vypis;
    ASSERT tQ = "0000" REPORT "count 0001" SEVERITY failure;
    WAIT FOR 10 ns; --count up
    vypis;
    ASSERT tQ = "0001" REPORT "count 0001" SEVERITY failure;
    -- end
    clockEnable <= '0';
    REPORT "Test OK";
    WAIT;

  END PROCESS;

  UUT : ENTITY work.counterGeneric GENERIC MAP(4) PORT MAP(tClk, tReset, tQ);

END bench;