library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- o_OUT1 <= i_IN1 when i_Sel is 0
-- o_OUT1 <= i_IN2 when i_Sel is 1
entity mux2x1 is
    port (
        i_IN1, i_IN2 : in std_logic;
        i_Sel : in std_logic;
        o_OUT1 : out std_logic
    );
end mux2x1;

architecture struct of mux2x1 is
begin
    o_OUT1 <= ((i_IN1 and not(i_Sel)) or (i_IN2 and i_Sel));
end struct;
