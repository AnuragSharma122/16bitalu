library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity alu16bit is
port(
     A : in std_logic_vector(15 downto 0);
     B : in std_logic_vector(15 downto 0);
     S : inout std_logic_vector(31 downto 0);
     sel : in std_logic_vector(3 downto 0);
     slt : out std_logic;
     zero : out std_logic;
     overflow : out std_logic;
     Cout : out STD_LOGIC);
end alu16bit;

architecture Behavioral of alu16bit is

begin
process(sel)
begin
case sel is
--   Multiplication
   when "0000" => S <= std_logic_vector(resize(signed(signed(a) * signed(b)), S'length));
   --   Division
   when "0001" => S <= std_logic_vector(resize(signed(signed(a) / signed(b)), S'length));
   --   Addition
   when "0010" => S <= std_logic_vector(resize(signed((signed(a) + signed(b))), S'length));
--   when "0010" => adder:AdderSubtractor port map(A,B,Cin,S,Cout,overflow);
   --   Subtraction
   when "0011" => S <= std_logic_vector(resize(signed(signed(a) - signed(b)), S'length));
   --   And
   when "0100" => S <= std_logic_vector(resize(signed(signed(a) and signed(b)), S'length));
   --   Or   
   when "0101" => S <= std_logic_vector(resize(signed(signed(a) or signed(b)), S'length));
   --   Xor
   when "0110" => S <= std_logic_vector(resize(signed(signed(a) xor signed(b)), S'length));
   --   Xnor
   when "0111" => S <= std_logic_vector(resize(signed(signed(a) xnor signed(b)), S'length));
   --   Nand
   when "1000" => S <= std_logic_vector(resize(signed(signed(a) nand signed(b)), S'length));
   --   Nor
   when "1001" => S <= std_logic_vector(resize(signed(signed(a) nor signed(b)), S'length));
   -- Shift Left unsigned
   when "1010" => S <= std_logic_vector(resize(shift_left(unsigned(a),1), S'length));
--   -- Shift Left signed
   when "1011" => S <= std_logic_vector(resize(shift_left(signed(a),1), S'length));
--   -- Shift Right unsigned
   when "1100" => S <= std_logic_vector(resize(shift_right(unsigned(a),1), S'length));
--   -- Shift Right signed
   when "1101" => S <= std_logic_vector(resize(shift_right(signed(a),1), S'length));
   when others => S <= std_logic_vector(resize(signed(signed(a) + signed(b)), S'length));
end case;
end process;
slt <= S(31);
zero <= not(S(31) or S(30) or S(29) or S(28) or S(27) or S(26) or S(25) or S(24) or S(23) or S(22) or S(21) or
            S(20) or S(19) or S(18) or S(17) or S(16) or S(15) or S(14) or S(13) or S(12) or S(11) or S(10) or S(9) or
            S(8) or S(6) or S(5) or S(4) or S(3) or S(2) or S(1));

end Behavioral;
