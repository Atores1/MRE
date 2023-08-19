LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY dFF IS
    PORT (
        clk : IN std_logic;
        D : IN std_logic;
        Q : OUT std_logic := '0'
    );
END ENTITY;

ARCHITECTURE main OF dFF IS
    SIGNAL delay: std_logic := '0';
    SIGNAL delay1: std_logic := '0';
BEGIN
    process(clk)
    begin
        IF rising_edge(clk) THEN
            Q <= D;
        END IF;
    end process;
END ARCHITECTURE;