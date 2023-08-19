LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY adderGeneric IS
    GENERIC( size: integer);
    PORT (
        in1 : IN std_logic_vector (size-2 DOWNTO 0):= (others => '0');
        in2 : IN std_logic_vector (size-2 DOWNTO 0):= (others => '0');
        q : OUT std_logic_vector (size-1 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE main OF adderGeneric IS
    SIGNAL sum : unsigned (size-1 DOWNTO 0):= (others => '0');
BEGIN
    sum <= unsigned('0'&in1) + unsigned(in2);
    q <= std_logic_vector(sum);
END ARCHITECTURE;