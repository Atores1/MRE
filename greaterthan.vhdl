library IEEE;
use IEEE.std_logic_1164.all;
entity greaterthan is
    port(
        A1,A2,B1,B2: in std_logic :='0';
        GOut: out std_logic := '0'
        );
end entity greaterthan;

architecture main of greaterthan is
    begin 
    GOut <= A1 or B1;
end architecture;