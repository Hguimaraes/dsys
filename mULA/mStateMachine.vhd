----------------------------------------------------------------------------------
-- Create Date:    23:30:00 05/20/2018 
-- Description: 
--      Top module of this project. State machine to control user flow
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mStateMachine is
	Port(	-- Input variables to control the user flow in the State Machine
			SWT_IN : in  STD_LOGIC_VECTOR(3 downto 0);
			BTN_A : in  STD_LOGIC;
			BTN_B : in  STD_LOGIC;
			BTN_RESET : in  STD_LOGIC;
			CLOCK : in  STD_LOGIC;
			LED_OUT: out STD_LOGIC_VECTOR(7 downto 0));
end mStateMachine;

architecture Behavioral of mStateMachine is

-- READER component
component mREADER
	Port (-- Variveis de entrada compartilhadas com o módulo mULA
			 SWT_IN : in  STD_LOGIC_VECTOR(3 downto 0);
          BTN_A : in  STD_LOGIC;
          BTN_B : in  STD_LOGIC;
          BTN_RESET : in  STD_LOGIC;
			 CLOCK : in  STD_LOGIC;
			  
			 -- Variveis de saída compartilhadas com o módulo mULA
         numA : out  STD_LOGIC_VECTOR(3 downto 0);
         numB : out  STD_LOGIC_VECTOR(3 downto 0);
         numOP : out  STD_LOGIC_VECTOR(3 downto 0);
			outMod: out STD_LOGIC);
end component;

-- WRITER component
component mWRITER is
	Port ( 	-- Variaveis compartilhadas
				numA : in  STD_LOGIC;
				numB : in  STD_LOGIC;
				numOP : in  STD_LOGIC;
				BTN_RESET : in  STD_LOGIC;
				CLOCK : in  STD_LOGIC;
				LED_OUT : out  STD_LOGIC;
				outMod: out STD_LOGIC);
end component;

-- ULA component
component mULA is
	Port ( A : in  STD_LOGIC_VECTOR(3 downto 0);
          B : in  STD_LOGIC_VECTOR(3 downto 0);
			 OP: in  STD_LOGIC_VECTOR(3 downto 0);
          X : out  STD_LOGIC_VECTOR(5 downto 0));
end component;

-- Aux variables to control states or perform operations
SIGNAL numA: STD_LOGIC_VECTOR(3 downto 0);
SIGNAL numB: STD_LOGIC_VECTOR(3 downto 0);
SIGNAL numOP: STD_LOGIC_VECTOR(3 downto 0);

SIGNAL rState: STD_LOGIC;			-- 1 if executing the reading
SIGNAL opState: STD_LOGIC;			-- 1 if executing the operation
SIGNAL wState: STD_LOGIC;			-- 1 if executing the writer

SIGNAL rOP: STD_LOGIC_VECTOR(3 downto 0);

begin
	C01: mULA port map(numA, numB, numOP, LED_OUT);
	C02: mREADER port map(SWT_IN, BTN_A, BTN_B, BTN_RESET,CLOCK, numA, numB, numOP, rState);
	C03: mWRITER port map(numA, numB, numOP, BTN_RESET, CLOCK, LED_OUT, wState);	
end Behavioral;

