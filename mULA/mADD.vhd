----------------------------------------------------------------------------------
-- Create Date:    21:20:00 05/20/2018 
-- Description: 
--      Module to make an 4bit adder
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- 4-bit adder
entity mADD is
    Port ( A : in  STD_LOGIC_VECTOR(3 downto 0);
			  B : in  STD_LOGIC_VECTOR(3 downto 0);
           c_in : in  STD_LOGIC;
           X : out  STD_LOGIC_VECTOR(3 downto 0);
           c_out : out  STD_LOGIC);
end mADD;

architecture mADD_behav of mADD is

signal c:std_logic_vector(4 downto 0);

-- Importing the 1-bit adder
component adder1bit
	port(a,b,c: in std_logic;
			sum, carry: out std_logic);
end component;

begin
	-- Implementing the 4-bit adder with concatenated 1-bit adders
	ADD01: adder1bit port map(A(0), B(0), c_in, X(0), c(1));
	ADD02: adder1bit port map(A(1), B(1), c(1), X(1), c(2));
	ADD03: adder1bit port map(A(2), B(2), c(2), X(2), c(3));
	ADD04: adder1bit port map(A(3), B(3), c(3), X(3), c(4));
	
	c_out <= c(4);
	
end mADD_behav;