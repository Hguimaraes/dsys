----------------------------------------------------------------------------------
-- Create Date:    20:07:11 05/31/2018 
-- Module Name:    binadder - binadder_behav 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity binadder is
    Port ( A, B : in  unsigned(3 downto 0);
           c_in : out  STD_LOGIC;
           SUM : out unsigned(3 downto 0);
           c_out : out  STD_LOGIC);
end binadder;

architecture binadder_behav of binadder is

begin
	-- Sum A+B+c_in and result in a 5-bit vector
	temp <= '0' & A +  B + c_in;
	SUM <= temp(3 downto 0);
	
	-- c_out is the last bit
	c_out <= temp(4);
end binadder_behav;

