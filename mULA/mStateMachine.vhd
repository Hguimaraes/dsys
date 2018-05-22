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
         numA :  out  STD_LOGIC_VECTOR(3 downto 0);
         numB :  out  STD_LOGIC_VECTOR(3 downto 0);
         numOP : out  STD_LOGIC_VECTOR(3 downto 0);
			
			-- Control state
			rState: out STD_LOGIC;
			opState: in STD_LOGIC;
			wState: in STD_LOGIC);
end component;

-- ULA component
component mULA is
	Port ( A : in  STD_LOGIC_VECTOR(3 downto 0);
          B : in  STD_LOGIC_VECTOR(3 downto 0);
			 OP: in  STD_LOGIC_VECTOR(3 downto 0);
			 CLOCK: in STD_LOGIC;
			 X : out  STD_LOGIC_VECTOR(3 downto 0);
			 
			 -- Control state
			 rState: in STD_LOGIC;
			 opState: out STD_LOGIC;
			 wState: in STD_LOGIC);
end component;

-- WRITER component
component mWRITER is
	Port ( 	-- Shared Variables with State Machine
				numA : in  STD_LOGIC_VECTOR(3 downto 0);
				numB : in  STD_LOGIC_VECTOR(3 downto 0);
				resOP : in  STD_LOGIC_VECTOR(3 downto 0);
				BTN_RESET : in  STD_LOGIC;
				CLOCK : in  STD_LOGIC;
				LED_OUT : out  STD_LOGIC_VECTOR(7 downto 0);
				
				-- Control state
				rState: in STD_LOGIC;
				opState: in STD_LOGIC;
				wState: out STD_LOGIC);
end component;

-- Aux variables to control states or perform operations
SIGNAL numA: STD_LOGIC_VECTOR(3 downto 0);
SIGNAL numB: STD_LOGIC_VECTOR(3 downto 0);
SIGNAL numOP: STD_LOGIC_VECTOR(3 downto 0);
SIGNAL resOP: STD_LOGIC_VECTOR(3 downto 0);

SIGNAL rState: STD_LOGIC;			-- 1 if finished the reading
SIGNAL opState: STD_LOGIC;			-- 1 if finished the calc
SIGNAL wState: STD_LOGIC;			-- 0 off | 1 on

begin
	-- Reader state machine
	C00: mREADER port map(SWT_IN, BTN_A, BTN_B, BTN_RESET,
		CLOCK, numA, numB, numOP, rState, opState, wState);
	
	-- Perform operation if possible
	C01: mULA port map(numA, numB, numOP, 
		CLOCK, resOP, rState, opState, wState);
	
	-- Write operation on the screen
	C02: mWRITER port map(numA, numB, resOP, BTN_RESET,
			CLOCK, LED_OUT, rState, opState, wState);
end Behavioral;