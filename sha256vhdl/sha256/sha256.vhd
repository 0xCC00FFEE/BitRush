----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:24:03 05/30/2013 
-- Design Name: 
-- Module Name:    sha256 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sha256 is
			Port(	clk: in STD_LOGIC;
					message: in STD_LOGIC_VECTOR(639 downto 0);
					hashout: out STD_LOGIC_VECTOR(255 downto 0));
end sha256;

architecture Behavioral of sha256 is
		COMPONENT messagechunk
			Port(	clk: in STD_LOGIC;
					messagechunk: in STD_LOGIC_VECTOR(511 downto 0);
					h0,h1,h2,h3,h4,h5,h6,h7: in STD_LOGIC_VECTOR(31 downto 0);
					chunkhash: out STD_LOGIC_VECTOR(255 downto 0));
		END COMPONENT;
		
		COMPONENT preproc
			Port(	message: in STD_LOGIC_VECTOR(639 downto 0);
					messagechunk1,messagechunk2: out STD_LOGIC_VECTOR(511 downto 0));
		END COMPONENT;		
		
		signal smessagechunk1,smessagechunk2: STD_LOGIC_VECTOR(511 downto 0);
		signal firstchunkhash: STD_LOGIC_VECTOR(255 downto 0);
begin

		preprocessing : preproc
		port map (
			message         => message,
			messagechunk1   => smessagechunk1,
			messagechunk2   => smessagechunk2
			);
			
			
		firstchunkhash : messagechunk
		port map (
			clk            => clk,
			messagechunk   => smessagechunk1,
			h0             => x"6a09e667",
			h1             => x"bb67ae85",
			h2             => x"3c6ef372",
			h3             => x"a54ff53a",
			h4      			=> x"510e527f",
			h5        		=> x"9b05688c",
			h6       		=> x"1f83d9ab",
			h7        		=> x"5be0cd19",
			chunkhash      => firstchunkhash
			);
			
		secondchunkhash : messagechunk
		port map (
			clk            => clk,
			messagechunk   => smessagechunk2,
			h0             => firstchuckhash(255 downto 223),
			h1             => firstchuckhash(223 downto 191),
			h2             => firstchuckhash(191 downto 159),
			h3             => firstchuckhash(159 downto 127),
			h4      			=> firstchuckhash(127 downto 95),
			h5        		=> firstchuckhash(95 downto 63),
			h6       		=> firstchuckhash(63 downto 31),
			h7        		=> firstchuckhash(31 downto 0),
			chunkhash      => hashout
			);
			
	

end Behavioral;

