library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ReceiverController is
 Port (
    i_Greset, i_CLK: in std_logic;
    i_RxD, i_RDRF: in std_logic;
    o_RSRload, o_RSRshiftR: out std_logic;
    o_RDRload: out std_logic;
    o_RDRFload, o_RDRFin: out std_logic;
    o_FEload, o_FEin: out std_logic;
    o_OEload, o_OEin: out std_logic
 );
end ReceiverController;

architecture struct of ReceiverController is
    signal i_CLKCTRload, i_CLKCTRinc, i_CLKCTRSEL, i_SCTRload, i_SCTRinc: std_logic;
    signal i_CLKCTRout, i_SCTRout: std_logic;
    signal i_Y10_i, i_Y9_i, i_Y8_i, i_Y7_i, i_Y6_i, i_Y5_i, i_Y4_i, i_Y3_i, i_Y2_i, i_Y1_i, i_Y0_i: std_logic;
    signal i_y10, i_y9, i_y8, i_y7, i_y6, i_y5, i_y4, i_y3, i_y2, i_y1, i_y0: std_logic;
    signal i_y10Bar, i_y9Bar, i_y8Bar, i_y7Bar, i_y6Bar, i_y5Bar, i_y4Bar, i_y3Bar, i_y2Bar, i_y1Bar, i_y0Bar: std_logic;
    signal i_resetcondition: std_logic;
begin

    i_resetcondition <= (i_y10Bar and i_y9Bar and i_y8Bar and i_y7Bar and i_y6Bar and i_y5Bar and i_y4Bar and i_y3Bar and i_y2Bar and i_y1Bar and i_y0Bar);

    i_Y10_i <= (i_y8 or i_y9);
    i_Y9_i <= (i_y5 and not i_RxD);
    i_Y8_i <= (i_y7 and (i_RDRF and not i_RxD));
    i_Y7_i <= (i_y6) or (i_y7 and (i_RDRF and i_RxD));
    i_Y6_i <= (i_y5 and i_RxD);
    i_Y5_i <= (i_y4 and not i_CLKCTRout);
    i_Y4_i <= (i_y2 and not i_SCTRout) or (i_y4 and i_CLKCTRout);
    i_Y3_i <= (i_y2 and i_SCTRout) or (i_y3 and i_CLKCTRout);
    i_Y2_i <= (i_y1 and not i_CLKCTRout) or (i_y3 and not i_CLKCTRout);
    i_Y1_i <= (i_y1 and i_CLKCTRout) or (i_y0 and not i_RxD);
    i_Y0_i <= i_resetcondition or (i_y0 and i_RxD) or (i_y7 and not i_RDRF);

    i_SampleCounter: entity work.counterClock(struct)
        port map(i_SCTRload, i_SCTRinc, i_CLK, i_SCTRout);

    i_CLKCounter: entity work.counterClock(struct)
        port map(i_CLKCTRload, i_CLKCTRinc, i_CLKCTRSEL, i_CLK, i_CLKCTRout);

    i_DFF0: entity work.dFF_2(rtl)
        port map(i_Y0_i, i_CLK, i_y0, i_y0Bar);
    i_DFF1: entity work.dFF_2(rtl)
        port map(i_Y1_i, i_CLK, i_y1, i_y1Bar);
    i_DFF2: entity work.dFF_2(rtl)
        port map(i_Y2_i, i_CLK, i_y2, i_y2Bar);
    i_DFF3: entity work.dFF_2(rtl)
        port map(i_Y3_i, i_CLK, i_y3, i_y3Bar);
    i_DFF4: entity work.dFF_2(rtl)
        port map(i_Y4_i, i_CLK, i_y4, i_y4Bar);
    i_DFF5: entity work.dFF_2(rtl)
        port map(i_Y5_i, i_CLK, i_y5, i_y5Bar);
    i_DFF6: entity work.dFF_2(rtl)
        port map(i_Y6_i, i_CLK, i_y6, i_y6Bar);
    i_DFF7: entity work.dFF_2(rtl)
        port map(i_Y7_i, i_CLK, i_y7, i_y7Bar);
    i_DFF8: entity work.dFF_2(rtl)
        port map(i_Y8_i, i_CLK, i_y8, i_y8Bar);
    i_DFF9: entity work.dFF_2(rtl)
        port map(i_Y9_i, i_CLK, i_y9, i_y9Bar);
    i_DFF10: entity work.dFF_2(rtl)
        port map(i_Y10_i, i_CLK, i_y10, i_y10Bar);

    -- signals
    i_CLKCTRload <= i_y0 or i_y1 or i_y2 or i_y3 or i_y4;
    i_CLKCTRinc <= i_y1 or i_y3 or i_y4;
    i_CLKCTRSEL <= i_y0;
    i_SCTRload <= i_y1 or i_y2;
    i_SCTRinc <= i_y2;

    -- outputs
    o_RSRload <= i_y2;
    o_RSRshiftR <= i_y2;
    o_RDRload <= i_y6;
    o_RDRFload <= i_y6;
    o_RDRFin <= i_y6;
    o_FEload <= i_y9;
    o_FEin <= i_y9;
    o_OEload <= i_y8;
    o_OEin <= i_y8;

end struct;
