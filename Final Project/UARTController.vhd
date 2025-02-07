library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity UARTController is
 Port (
    i_CLK: in std_logic;
    i_ADDR: in std_logic_vector(1 downto 0);
    i_R, i_UARTselect: in std_logic;
    i_RDRout, i_SCSRout, i_SCCRout: in std_logic_vector(7 downto 0);
    i_DATA_BUS_IN: in std_logic_vector(7 downto 0);
    o_DATA_BUS_OUT: out std_logic_vector(7 downto 0);
    o_AD_TDRload, o_AD_SCCRload: out std_logic;
    o_AD_TDRin, o_AD_SCCRin: out std_logic_vector(7 downto 0);
    o_AD_TDREload, o_AD_TDREin: out std_logic;
    o_AD_RDRFload, o_AD_RDRFin: out std_logic
 );
end UARTController;

architecture struct of UARTController is
    signal i_MUX1out: std_logic_vector(7 downto 0);

begin
    i_MUX1: entity work.mux2x18bit(struct)
        port map(i_RDRout, i_SCSRout, i_ADDR(0), i_MUX1out);

    i_MUX2: entity work.mux2x18bit(struct)
        port map(i_MUX1out, i_SCCRout, i_ADDR(1), o_DATA_BUS_OUT);

    o_AD_TDRload <= (not i_ADDR(1) and not i_ADDR(0) and not i_R and i_UARTselect);
    o_AD_SCCRload <= (i_ADDR(1) and not i_R and i_UARTselect);
    o_AD_TDRin <= i_DATA_BUS_IN;
    o_AD_SCCRin <= i_DATA_BUS_IN;
    o_AD_TDREload <= (not i_ADDR(1) and not i_ADDR(0) and not i_R);
    o_AD_TDREin <= '0';
    o_AD_RDRFload <= (not i_ADDR(1) and not i_ADDR(0) and i_R);
    o_AD_RDRFin <= '0';

end struct;
