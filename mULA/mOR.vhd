----------------------------------------------------------------------------------
-- Create Date:    20:35:00 05/20/2018 
-- Description: 
--      Module to make an OR operation between A,B (4 bits)
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mOR is
    Port ( A : in  STD_LOGIC_VECTOR(3 DOWNTO 0);
           B : in  STD_LOGIC_VECTOR(3 DOWNTO 0);
           X : out  STD_LOGIC_VECTOR(3 DOWNTO 0));
end mOR;

architecture Behavioral of mOR is

begin
	-- 4-bit OR operation
	X <= A OR B;

end Behavioral;