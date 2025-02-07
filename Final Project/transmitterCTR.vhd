library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity transmitterCTR is
    Port (
        i_CTRload, i_CTRinc, i_CLK: in std_logic;
        o_c: out std_logic
    );
end transmitterCTR;

architecture struct of transmitterCTR is
    signal COUNT: std_logic_vector(7 downto 0);  
begin
    counter: entity work.leftShiftRegister8bit(struct)  
        port map(i_CTRload, i_CTRinc, i_CLK, "11111111", COUNT);  

    o_c <= COUNT(7);  
end struct;
