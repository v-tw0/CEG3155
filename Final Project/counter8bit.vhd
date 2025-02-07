library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity counter8bit is
    Port ( 
           i_En : in std_logic;
           i_Clk : in std_logic;
           i_Reset : in std_logic;
           o_Count : out std_logic_vector(7 downto 0)
    );
end counter8bit;

architecture Structural of counter8bit is

    signal countout : std_logic_vector(7 downto 0);
    signal Din : std_logic_vector(7 downto 0);

begin

    Din(7) <= countout(7) xor (countout(6) and countout(5) and countout(4) and countout(3) and countout(2) and countout(1) and countout(0));
    Din(6) <= countout(6) xor (countout(5) and countout(4) and countout(3) and countout(2) and countout(1) and countout(0));
    Din(5) <= countout(5) xor (countout(4) and countout(3) and countout(2) and countout(1) and countout(0));
    Din(4) <= countout(4) xor (countout(3) and countout(2) and countout(1) and countout(0));
    Din(3) <= countout(3) xor (countout(2) and countout(1) and countout(0));
    Din(2) <= countout(2) xor (countout(1) and countout(0));
    Din(1) <= countout(1) xor countout(0);
    Din(0) <= not countout(0);

    D7 : entity work.enARdFF_2(struct)
        port map (
            i_Reset,
            Din(7),
            i_En,
            i_Clk,
            countout(7)
        );

    D6 : entity work.enARdFF_2(struct)
        port map (
            i_Reset,
            Din(6),
            i_En,
            i_Clk,
            countout(6)
        );

    D5 : entity work.enARdFF_2(struct)
        port map (
            i_Reset,
            Din(5),
            i_En,
            i_Clk,
            countout(5)
        );

    D4 : entity work.enARdFF_2(struct)
        port map (
            i_Reset,
            Din(4),
            i_En,
            i_Clk,
            countout(4)
        );

    D3 : entity work.enARdFF_2(struct)
        port map (
            i_Reset,
            Din(3),
            i_En,
            i_Clk,
            countout(3)
        );

    D2 : entity work.enARdFF_2(struct)
        port map (
            i_Reset,
            Din(2),
            i_En,
            i_Clk,
            countout(2)
        );

    D1 : entity work.enARdFF_2(struct)
        port map (
            i_Reset,
            Din(1),
            i_En,
            i_Clk,
            countout(1)
        );

    D0 : entity work.enARdFF_2(struct)
        port map (
            i_Reset,
            Din(0),
            i_En,
            i_Clk,
            countout(0)
        );

    o_Count <= countout;

end Structural;
