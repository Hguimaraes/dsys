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
           BTN_RESET : in  STD_LOGIC;
           CLOCK : in  STD_LOGIC;
           LED_OUT : out  STD_LOGIC);
end mWRITER;

architecture Behavioral of mWRITER is

-- Estados da máquina de Leitura
type STATE_TYPE is ( 
	sN1,   	-- Exibir Número A
	sN2,   	-- Exibir Número B
	sN3   	-- Exibir Resultado numA OP numB
);
SIGNAL state: STATE_TYPE;

-- Variaveis do Divisor de Freq
SIGNAL counter: integer := 0;
SIGNAL PTS: integer := 100000000;

begin
	PROCESS (BTN_A, BTN_B, BTN_RESET, CLOCK)
	BEGIN
		IF (BTN_RESET = '1') THEN 
			state <= A;
		ELSE
			IF (CLK'EVENT AND CLK='1') THEN
				-- Exibir o número nos LEDs
				CASE state IS
					WHEN sN1 =>
						numA <= SWT_IN;
						
					-- Input do número B
					WHEN sN2 =>
						numB <= SWT_IN;
						IF(BTN_B = '1') THEN
							state <= sOP;
						END IF;
					-- Input da Operação e realização da conta
					WHEN sN3 =>
						numOP <= SWT_IN;
						IF(BTN_A = '1') THEN
							state <= sN1;
						END IF;
				END CASE;
			END IF;
		END IF;
	END PROCESS;

end Behavioral;

