----------------------------------------------------------------------------------
-- Create Date:    21:12:00 05/20/2018 
-- Description: 
--      Module to calculate the two's complement of A (4-bit)
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--  Módulo para realizar o complemento a 2 de um vetor
entity m2CMPLMT is
    Port (A : in  STD_LOGIC_VECTOR(3 downto 0);
          X : out  STD_LOGIC_VECTOR(3 downto 0);
			 COUT: out STD_LOGIC);
end m2CMPLMT;

architecture Behavioral of m2CMPLMT is

signal notA:std_logic_vector(3 downto 0);

-- Componente de Negação de um vetor de 4 Bits
component mNOT
	port(A: in std_logic_vector(3 downto 0);
			X: out std_logic_vector(3 downto 0));
end component;

-- Componente para somar +1 ao vetor negado e obter o complemento a 2
component mADD
	Port ( A,B : in  STD_LOGIC_VECTOR(3 downto 0);
           c_in : in  STD_LOGIC;
           X : out  STD_LOGIC_VECTOR(3 downto 0);
           c_out : out  STD_LOGIC);
end component;

signal ONE:STD_LOGIC_VECTOR(3 DOWNTO 0);
signal CIN: STD_LOGIC;

begin
	ONE <= "0001";
	CIN <= '0';
	
	M2C01: mNOT port map(A, notA);
	M2C02: mADD port map(notA, ONE, CIN, X, COUT);

end Behavioral;