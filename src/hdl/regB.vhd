----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/05/2024 09:39:43 PM
-- Design Name: 
-- Module Name: regB - Behavioral
-- Project Name: C3C Megan Leong and C3C Raine Komata
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
entity regB is
    Port ( 
           i_load : in STD_LOGIC;
           i_B : in STD_LOGIC_VECTOR (7 downto 0);
           o_B : out STD_LOGIC_VECTOR (7 downto 0)
           );
end regB;
architecture Behavioral of regB is
begin
            process (i_load)
            begin
                if (i_load = '1') then
                    o_B <= i_B;
                end if;
            end process;
end Behavioral;
