library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Entity 
entity mux2bit is
    Port (
        input1    : in  STD_LOGIC_VECTOR(7 downto 0);  
        input2    : in  STD_LOGIC_VECTOR(7 downto 0);  
        input3    : in  STD_LOGIC_VECTOR(7 downto 0);  
        input_left : in  STD_LOGIC;                    
        input_right: in  STD_LOGIC;                    
        clk       : in  STD_LOGIC;                    
        output    : out STD_LOGIC_VECTOR(7 downto 0)   
    );
end mux2bit;

-- Architecture 
architecture Behavioral of mux2bit is
    -- Internal signal to store the selected input
    signal selected_input : STD_LOGIC_VECTOR(7 downto 0);
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if input_left = '1' then
                selected_input <= input1;
            elsif input_right = '1' then
                selected_input <= input2;
            else
				-- Default case, when neither input_left nor input_right is '1'
                selected_input <= input3;  
            end if;
        end if;
    end process;
    
    -- Output assignment
    output <= selected_input;

end Behavioral;
