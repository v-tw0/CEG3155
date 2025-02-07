library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity counter3bit is
    Port ( 
           i_En : in std_logic;
           i_Clk : in std_logic;
           i_Reset : in std_logic;
           o_Count : out std_logic_vector(2 downto 0)
    );
end counter3bit;

architecture Structural of counter3bit is

    signal Din : std_logic_vector(2 downto 0);
    signal countout : std_logic_vector(2 downto 0);

begin

    Din(2) <= countout(2) xor (countout(1) and countout(0));
    Din(1) <= countout(1) xor countout(0);
    Din(0) <= not countout(0);

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

    o_Count(2) <= countout(2);
    o_Count(1) <= countout(1);
    o_Count(0) <= countout(0);

end Structural;
