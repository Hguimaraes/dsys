----------------------------------------------------------------------------------
-- Create Date:    22:50:00 05/20/2018 
-- Description: 
--      Module to select what operation to perfom
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mULA is
	Port ( A : in  STD_LOGIC_VECTOR(3 downto 0);
          B : in  STD_LOGIC_VECTOR(3 downto 0);
			 OP: in  STD_LOGIC_VECTOR(3 downto 0);
			 BTN_RESET: in STD_LOGIC;
          CLOCK: in STD_LOGIC;
			 X : out  STD_LOGIC_VECTOR(3 downto 0);
			 
			 -- Control state
			 rState: in STD_LOGIC;
			 opState: out STD_LOGIC;
			 wState: in STD_LOGIC);
end mULA;

architecture Behavioral of mULA is

-- AND
component mAND
	Port ( A,B : in  STD_LOGIC_VECTOR(3 downto 0);
           X : out  STD_LOGIC_VECTOR(3 downto 0));
end component;

-- NAND
component mNAND
	Port ( A,B : in  STD_LOGIC_VECTOR(3 downto 0);
           X : out  STD_LOGIC_VECTOR(3 downto 0));
end component;

-- OR
component mOR
	Port ( A,B : in  STD_LOGIC_VECTOR(3 downto 0);
           X : out  STD_LOGIC_VECTOR(3 downto 0));
end component;

-- XOR
component mXOR
	Port ( A,B : in  STD_LOGIC_VECTOR(3 downto 0);
           X : out  STD_LOGIC_VECTOR(3 downto 0));
end component;

-- NOT
component mNOT
	Port ( A : in  STD_LOGIC_VECTOR(3 downto 0);
          X : out  STD_LOGIC_VECTOR(3 downto 0));
end component;

-- Two's complement
component m2CMPLMT
    Port (A : in  STD_LOGIC_VECTOR(3 downto 0);
          X : out  STD_LOGIC_VECTOR(3 downto 0);
			 COUT: out STD_LOGIC);
end component;

-- 4-bit adder
component mADD
	Port ( A,B : in  STD_LOGIC_VECTOR(3 downto 0);
           c_in : in  STD_LOGIC;
           X : out  STD_LOGIC_VECTOR(3 downto 0);
           c_out : out  STD_LOGIC);
end component;

-- 4-bit subtractor
component mSUB
	Port ( A : in  STD_LOGIC_VECTOR(3 downto 0);
          B : in  STD_LOGIC_VECTOR(3 downto 0);
          X : out  STD_LOGIC_VECTOR(3 downto 0);
			 Brw : out STD_LOGIC);
end component;

-- aux variables for arithmetic operations
SIGNAL c_in: STD_LOGIC;
SIGNAL c_out: STD_LOGIC;
SIGNAL c_out_add: STD_LOGIC;
SIGNAL Brw: STD_LOGIC;

SIGNAL X_AND: STD_LOGIC_VECTOR(3 downto 0);
SIGNAL X_NAND: STD_LOGIC_VECTOR(3 downto 0);
SIGNAL X_OR: STD_LOGIC_VECTOR(3 downto 0);
SIGNAL X_XOR: STD_LOGIC_VECTOR(3 downto 0);
SIGNAL X_NOT: STD_LOGIC_VECTOR(3 downto 0);
SIGNAL X_2CMPLMT: STD_LOGIC_VECTOR(3 downto 0);
SIGNAL X_ADD: STD_LOGIC_VECTOR(3 downto 0);
SIGNAL X_SUB: STD_LOGIC_VECTOR(3 downto 0);

begin
	-- Set cin as 0
	c_in <= '0';
	
	OP00: mAND port map(A,B,X_AND);
	OP01: mNAND port map(A,B,X_NAND);
	OP02: mOR port map(A,B,X_OR);
	OP03: mXOR port map(A,B,X_XOR);
	OP04: mNOT port map(A,X_NOT);
	OP05: m2CMPLMT port map(A, X_2CMPLMT, c_out);
	OP06: mADD port map(A,B,c_in,X_ADD,c_out_add);
	OP07: mSUB port map(A, B, X_SUB, Brw);
			
	-- Select what operation to perform
	PROCESS(BTN_RESET, CLOCK)
	BEGIN
		IF (BTN_RESET = '1') THEN
			opState <= '0';
		ELSE
			IF(CLOCK'EVENT AND CLOCK = '1' AND rState = '1' AND wState = '0') THEN
				CASE OP IS
					WHEN "0000" => X <= X_AND;
					WHEN "0001" => X <= X_NAND;
					WHEN "0010" => X <= X_OR;
					WHEN "0011" => X <= X_XOR;
					WHEN "0100" => X <= X_NOT;
					WHEN "0101" => X <= X_2CMPLMT;
					WHEN "0110" => X <= X_ADD;
					WHEN "0111" => X <= X_SUB;
					WHEN OTHERS => X <= "1111";
				END CASE;
				
				opState <= '1';
			END IF;
		END IF;
	END PROCESS;
end Behavioral;