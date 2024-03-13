public class TestByte {
    public static void main(String[] args) {
        int b1 = 0xc1;  // 1100 0001
        int b2 = 0xaf;  // 1010 1111
        int i = ((b1 & 0x1F) << 6) | (b2 & 0x3F << 0);
        System.out.println(i);
        System.out.println((char) i);
        String hex1 = Integer.toHexString(i);
        System.out.println(hex1);
        String hex2 = Integer.toHexString(i & 0xFF);
        System.out.println(hex2);
    }
}
