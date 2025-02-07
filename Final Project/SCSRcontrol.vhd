library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SCSRcontrol is
    Port (
        i_UARTselect: in std_logic;
        i_TC_TDREload, i_AD_TDREload: in std_logic;
        i_TC_TDREin, i_AD_TDREin: in std_logic;
        i_RC_RDRFload, i_AD_RDRFload: in std_logic;
        i_RC_RDRFin, i_AD_RDRFin: in std_logic;
        o_TDREload, o_TDREin, o_RDRFload, o_RDRFin: out std_logic
    );
end SCSRcontrol;

architecture struct of SCSRcontrol is
begin
    mux2x11bit1: entity work.mux2x11bit(struct)
        port map(i_TC_TDREload, i_AD_TDREload, i_UARTselect, o_TDREload);

    mux2x11bit2: entity work.mux2x11bit(struct)
        port map(i_TC_TDREin, i_AD_TDREin, i_UARTselect, o_TDREin);

    mux2x11bit3: entity work.mux2x11bit(struct)
        port map(i_RC_RDRFload, i_AD_RDRFload, i_UARTselect, o_RDRFload);

    mux2x11bit4: entity work.mux2x11bit(struct)
        port map(i_RC_RDRFin, i_AD_RDRFin, i_UARTselect, o_RDRFin);
end struct;
