library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- MUX 2 to 1 with inputs and outputs as 12 bit std_logic_vectors
-- o_OUT1 <= i_IN1 when i_Sel is 0
-- o_OUT1 <= i_IN2 when i_Sel is 1
entity mux2x112bit is
    port (
        i_IN1, i_IN2 : in std_logic_vector(11 downto 0);
        i_Sel : in std_logic;
        o_OUT1 : out std_logic_vector(11 downto 0)
    );
end mux2x112bit;

architecture struct of mux2x112bit is
begin
    o_OUT1(11) <= ((i_IN1(11) and not(i_Sel)) or (i_IN2(11) and i_Sel));
    o_OUT1(10) <= ((i_IN1(10) and not(i_Sel)) or (i_IN2(10) and i_Sel));
    o_OUT1(9) <= ((i_IN1(9) and not(i_Sel)) or (i_IN2(9) and i_Sel));
    o_OUT1(8) <= ((i_IN1(8) and not(i_Sel)) or (i_IN2(8) and i_Sel));
    o_OUT1(7) <= ((i_IN1(7) and not(i_Sel)) or (i_IN2(7) and i_Sel));
    o_OUT1(6) <= ((i_IN1(6) and not(i_Sel)) or (i_IN2(6) and i_Sel));
    o_OUT1(5) <= ((i_IN1(5) and not(i_Sel)) or (i_IN2(5) and i_Sel));
    o_OUT1(4) <= ((i_IN1(4) and not(i_Sel)) or (i_IN2(4) and i_Sel));
    o_OUT1(3) <= ((i_IN1(3) and not(i_Sel)) or (i_IN2(3) and i_Sel));
    o_OUT1(2) <= ((i_IN1(2) and not(i_Sel)) or (i_IN2(2) and i_Sel));
    o_OUT1(1) <= ((i_IN1(1) and not(i_Sel)) or (i_IN2(1) and i_Sel));
    o_OUT1(0) <= ((i_IN1(0) and not(i_Sel)) or (i_IN2(0) and i_Sel));
end struct;
