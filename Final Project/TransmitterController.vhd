library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TransmitterController is
    Port (
        Greset, CLK: in std_logic;
        UARTselect, TDRE: in std_logic;
        o_TDREload, o_TDREin: out std_logic;
        o_TxDFFload, o_TxDFFset, o_TxDFFSEL: out std_logic;
        o_TSRload, o_TSRshiftR: out std_logic
    );
end TransmitterController;

architecture struct of TransmitterController is
    signal CTRload, CTRinc: std_logic;
    signal CTRout: std_logic;
    signal Y3_i, Y2_i, Y1_i, Y0_i: std_logic;
    signal y3, y2, y1, y0: std_logic;
    signal y3Bar, y2Bar, y1Bar, y0Bar: std_logic;
    signal resetcondition: std_logic; 
begin

    -- Reset condition logic
    resetcondition <= (y3Bar and y2Bar and y1Bar and y0Bar);

    -- State transitions for the FSM
    Y3_i <= (y2 and not UARTselect) or (y3 and CTRout);
    Y2_i <= (y1 and not TDRE and not UARTselect);
    Y1_i <= y0 or (y1 and (TDRE or UARTselect));
    Y0_i <= resetcondition or (y3 and not CTRout);

    -- Counter instance for FSM
    counter: entity work.transmitterCTR(struct)
        port map(CTRload, CTRinc, CLK, CTRout);

    -- DFFs for state registers
    DFF0: entity work.dFF_2(rtl)
        port map(Y0_i, CLK, y0, y0Bar);
    DFF1: entity work.dFF_2(rtl)
        port map(Y1_i, CLK, y1, y1Bar);
    DFF2: entity work.dFF_2(rtl)
        port map(Y2_i, CLK, y2, y2Bar);
    DFF3: entity work.dFF_2(rtl)
        port map(Y3_i, CLK, y3, y3Bar);

    -- Output assignments
    o_TDREload <= y0;
    o_TDREin <= y0;
    o_TxDFFload <= '1';
    o_TxDFFset <=  y0 or y1;
    o_TSRload <= y2 or y3;
    o_TSRshiftR <= y3;
    CTRload <= y2 or y3;
    CTRinc <= y3;
    o_TxDFFSEL <= y3;

end struct;
