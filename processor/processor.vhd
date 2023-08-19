LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY processor IS
    PORT (
        clk : IN std_logic;
        Hall : IN std_logic;
        LED : OUT std_logic_vector(5 DOWNTO 0);
        test : OUT std_logic
    );
END ENTITY;

ARCHITECTURE main OF processor IS
    CONSTANT PCWidth : integer := 6;
    SIGNAL dFFOut : std_logic := '0';
    SIGNAL dFFWrite : std_logic;
    SIGNAL tEndWrite : std_logic;
    SIGNAL tStartWrite : std_logic;
    SIGNAL PC : std_logic_vector(PCWidth-1 DOWNTO 0);
    SIGNAL T1 : std_logic_vector(PCWidth DOWNTO 0);
    SIGNAL T1_Adder: std_logic_vector(PCWidth DOWNTO 0):= (others => '0');
    SIGNAL T2: std_logic_vector(PCWidth DOWNTO 0);
    SIGNAL T2_processed: std_logic_vector(PCWidth DOWNTO 0);
    SIGNAL tEndClock : std_logic_vector(PCWidth-1 DOWNTO 0);
    SIGNAL tStartClock : std_logic_vector(PCWidth-1 DOWNTO 0);
    SIGNAL T1Write : std_logic;
    COMPONENT counterGeneric is
        generic(size: integer);
        port(clk, reset: IN std_logic;
        q: OUT std_logic_vector(PCWidth-1 DOWNTO 0));
    END COMPONENT;
    COMPONENT adderGeneric is
        generic(size: integer);
        port(in1, in2: IN std_logic_vector(PCWidth-1 DOWNTO 0);
        q: OUT std_logic_vector(PCWidth DOWNTO 0));
    END COMPONENT;
    COMPONENT registerGeneric is
        generic(size: integer);
        port(clk,load: IN std_logic;
        d: IN std_logic_vector(size-1 DOWNTO 0);
        q: OUT std_logic_vector(size-1 DOWNTO 0));
    END COMPONENT;
    COMPONENT dFF is
        port(clk, D: IN std_logic;
        Q: OUT std_logic);
    END COMPONENT;
BEGIN
    programCounter: counterGeneric GENERIC MAP(PCWidth) PORT MAP(clk, '0', PC);
    tStartRegister: registerGeneric GENERIC MAP(PCWidth) PORT MAP(clk,tStartWrite, PC,tStartClock);
    tEndRegister: registerGeneric GENERIC MAP(PCWidth) PORT MAP(tEndWrite,tEndWrite, PC,tEndClock);
    T2Register: registerGeneric GENERIC MAP(PCWidth+1) PORT MAP(tEndWrite,tEndWrite, T1,T2);
    T1Register: registerGeneric GENERIC MAP(PCWidth+1) PORT MAP(clk,T1Write, T1_Adder,T1);
    T1Adder: adderGeneric GENERIC MAP(PCWidth+1) PORT MAP(tStartClock,tEndClock,T1_Adder);
    hallDFF: dFF PORT MAP(clk, Hall, dFFOut);
    tStartWrite <= (Hall AND (NOT (dFFOut))) AND clk;
    tEndWrite <= (NOT (Hall) AND dFFOut) AND clk;
    LED <= PC;
    PROCESS (clk) 
    BEGIN   
        IF rising_edge(clk) THEN
            T1Write <= tEndWrite;
        END IF;
    END PROCESS;
END ARCHITECTURE;