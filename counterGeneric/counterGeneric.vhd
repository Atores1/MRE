LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY counterGeneric IS
    GENERIC( size: integer);
    PORT (
        clk : IN std_logic;
        reset : IN std_logic;
        q : OUT std_logic_vector (size-1 DOWNTO 0):= (others => '0')
    );
END ENTITY;

ARCHITECTURE main OF counterGeneric IS
    SIGNAL count : unsigned (size-1 DOWNTO 0):= (others => '0');
BEGIN
    PROCESS (clk, reset) BEGIN
        IF (reset = '1') THEN
            count <= (OTHERS => '0');
        ELSIF (rising_edge(clk)) THEN
            count <= count + 1;
        END IF;
    END PROCESS;
    q <= std_logic_vector(count);
END ARCHITECTURE;