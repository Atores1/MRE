library IEEE;
use IEEE.std_logic_1164.all;

entity test is
end;

architecture bench of test is

component greaterthan
    port(
        A1,A2,B1,B2: in std_logic;
        GOut: out std_logic
        );
end component;

signal tA1,tA2,tB1,tB2,tGOut: std_logic;

begin

testing:process
procedure vypis is 
    begin   
    report std_logic'image(tA1) & " + " & std_logic'image(tB1) & " = " & std_logic'image(tGOut);
end procedure;

begin

    tA1 <= '1'; tB1 <= '0'; wait for 10 ns;
    vypis;
    tA1 <= '0'; tB1 <= '0'; wait for 10 ns;
    vypis;
    tA1 <= '1'; tB1 <= '1'; wait for 10 ns;
    vypis;
    tA1 <= '0'; tB1 <= '1'; wait for 10 ns;
    vypis;
    report "Test OK";
    wait;
end process;

UUT: greaterthan port map (tA1,tA2,tB1,tB2,tGOut);

end bench;

    
