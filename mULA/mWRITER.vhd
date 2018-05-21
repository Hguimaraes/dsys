----------------------------------------------------------------------------------
-- Create Date:    23:00:00 05/20/2018 
-- Description: 
--      Module to write the output variables
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mWRITER is
    Port ( numA : in  STD_LOGIC;
           numB : in  STD_LOGIC;
           numOP : in  STD_LOGIC;
			  resOP: in STD_LOGIC_VECTOR(3 downto 0);
           BTN_RESET : in  STD_LOGIC;
           CLOCK : in  STD_LOGIC;
			  LED_OUT : out  STD_LOGIC_VECTOR(7 downto 0);
			  rState: in STD_LOGIC;
			  opState: in STD_LOGIC;
           wState: out STD_LOGIC);
end mWRITER;

architecture Behavioral of mWRITER is

-- Estados da máquina de Leitura
type STATE_TYPE is ( 
	sNA,   	-- Display on the LEDs numA
	sNB,   	-- Display on the LEDs numB
	sNOP,   	-- Display on the LEDs numOP
	sNULL		-- NULL State
);
SIGNAL state: STATE_TYPE;

-- Variaveis do Divisor de Freq
SIGNAL counter: integer := 0;
SIGNAL PTS: integer := 100000000;

begin
	PROCESS (BTN_A, BTN_B, BTN_RESET, CLOCK)
	BEGIN
		IF (BTN_RESET = '1') THEN 
			state <= sNULL;
			wState <= '0';
		ELSE
			IF (CLK'EVENT AND CLK='1' AND rState = '1' AND opState = '1') THEN
				CASE state IS
					-- Print the number A
					WHEN sN1 =>
						IF (counter = PTS) THEN
							-- SET Result
							LED_OUT <= "0000" & numA;
							
							-- Indicate number A
							LED_OUT(0) <= '0';
							LED_OUT(1) <= '1';
							
							-- Control state and frequency divisor
							state <= sN2;
							counter <= 0;
						ELSE
							counter <= counter + 1;
						END IF;
						
					-- Print the number A
					WHEN sN2 =>
						IF (counter = PTS) THEN
							-- SET Result
							LED_OUT <= "0000" & numB;
							
							-- Indicate number A
							LED_OUT(0) <= '1';
							LED_OUT(1) <= '0';
							
							-- Control state and frequency divisor
							state <= sN3;
							counter <= 0;
						ELSE
							counter <= counter + 1;
						END IF;
						
					-- Input da Operação e realização da conta
					WHEN sN3 =>
						IF (counter = PTS) THEN
							-- SET Result
							LED_OUT <= "0000" & resOP;
							
							-- Indicate number A
							LED_OUT(0) <= '1';
							LED_OUT(1) <= '1';
							
							-- Control state and frequency divisor
							state <= sN1;
							counter <= 0;
						ELSE
							counter <= counter + 1;
						END IF;
						
					-- NULL State (Do nothing - stop writing)
					WHEN sNULL =>
						state <= state;
				END CASE;
			END IF;
		END IF;
	END PROCESS;
end Behavioral;