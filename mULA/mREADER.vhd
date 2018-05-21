----------------------------------------------------------------------------------
-- Create Date:    22:50:00 05/20/2018 
-- Description: 
--      Module to read the variables selected by the user
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mREADER is
    Port ( 
			  -- Shared variables with the State machine
			  SWT_IN : in  STD_LOGIC_VECTOR(3 downto 0);
           BTN_A : in  STD_LOGIC;
           BTN_B : in  STD_LOGIC;
           BTN_RESET : in  STD_LOGIC;
			  CLOCK : in  STD_LOGIC;
			  
			  -- Output variables to share in the State machine
           numA : out  STD_LOGIC_VECTOR(3 downto 0);
           numB : out  STD_LOGIC_VECTOR(3 downto 0);
           numOP : out  STD_LOGIC_VECTOR(3 downto 0);
			  outMod: out STD_LOGIC);
end mREADER;

architecture Behavioral of mREADER is

-- States from this module
type STATE_TYPE is ( 
	sA,   	-- number A
	sB,   	-- number B
	sOP,   	-- Operation
	sNULL		-- NULL State
);
SIGNAL state: STATE_TYPE;

BEGIN
	PROCESS (BTN_A, BTN_B, BTN_RESET, CLOCK)
	BEGIN
		-- Evento de pressionar botão RESET
		IF (BTN_RESET = '1') THEN 
			state <= sNULL;
		ELSE
			IF (CLOCK'EVENT AND CLOCK = '1') THEN
				-- Read State Machine implementation
				CASE state IS
					-- READ Number A
					WHEN sA =>
						numA <= SWT_IN;
						IF(BTN_A = '1') THEN
							state <= sB;
						END IF;

					-- READ Number B
					WHEN sB =>
						numB <= SWT_IN;
						IF(BTN_B = '1') THEN
							state <= sOP;
						END IF;

					-- READ what operation to perform
					WHEN sOP =>
						numOP <= SWT_IN;
						IF(BTN_A = '1') THEN
							state <= sN1;
						END IF;

					-- Null state and finish this state machine
					WHEN sNULL =>
						outMod <= '1';
						state <= state;
				END CASE;
			END IF;
		END IF;
	END PROCESS;
END Behavioral;