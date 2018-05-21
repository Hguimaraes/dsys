----------------------------------------------------------------------------------
-- Create Date:    20:45:00 05/20/2018 
-- Description: 
--      Module to make a NOT operation on A (4 bits)
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mNOT is
    Port ( A : in  STD_LOGIC_VECTOR(3 DOWNTO 0);
           X : out  STD_LOGIC_VECTOR(3 DOWNTO 0));
end mNOT;

architecture Behavioral of mNOT is

begin
	-- NOT operation in 4-bit number
	X <= (NOT A);

end Behavioral;

