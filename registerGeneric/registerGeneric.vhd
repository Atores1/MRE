LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY registerGeneric IS
    GENERIC( size: integer);
    PORT (
        clk : IN std_logic;
        load : IN std_logic;
        d :IN std_logic_vector (size-1 DOWNTO 0);
        q : OUT std_logic_vector (size-1 DOWNTO 0):= (others => '0')
    );
END ENTITY;

ARCHITECTURE main OF registerGeneric IS
BEGIN
    PROCESS (clk,load) BEGIN
        IF (rising_edge(clk)) THEN
            IF(load = '1') THEN
                q <= d;
            END IF;
        END IF;
    END PROCESS;
END ARCHITECTURE;