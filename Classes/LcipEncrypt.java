


import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;
import javax.crypto.spec.IvParameterSpec;

public class LcipEncrypt {
	private static final String key = "ABCDEFGH";//会单独提供
	private static SecretKeyFactory keyFactory;
	private static DESKeySpec desKeySpec;
	private static SecretKey secretKey;
	private static IvParameterSpec iv;
	private static Cipher cipher;


	public LcipEncrypt(String cuskey) throws Exception {
		cipher = Cipher.getInstance("DES/CBC/PKCS5Padding");
		desKeySpec = new DESKeySpec(key.getBytes("UTF-8"));
		keyFactory = SecretKeyFactory.getInstance("DES");
		secretKey = keyFactory.generateSecret(desKeySpec);
		iv = new IvParameterSpec(key.getBytes("UTF-8"));
	}

	public static void main(String[] args) throws Exception {
		String mobile = "1511111111";//
		String sign = new LcipEncrypt(key).EnCrypt(mobile);// 加密
		System.out.println(sign);
		String reason = new LcipEncrypt(key).deCrypt(sign);// 解密(结果:1511111111)
		System.out.println(reason);
	}

	// 加密
	public  String EnCrypt(String message) throws Exception {
		try {
			Cipher cipher1 = Cipher.getInstance("DES/CBC/PKCS5Padding");
			cipher = Cipher.getInstance("DES/CBC/PKCS5Padding");
			keyFactory = SecretKeyFactory.getInstance("DES");
			secretKey = keyFactory.generateSecret(desKeySpec);
			cipher1.init(Cipher.ENCRYPT_MODE, secretKey, iv);
			byte data[] = message.getBytes("UTF-8");
			byte[] encryptedData = cipher1.doFinal(data);
			BASE64Encoder decoder = new BASE64Encoder();
			//System.out.println(decoder.encode(encryptedData));
			return decoder.encode(encryptedData);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("加密异常");
			return null;
		}
	}

	// 解密
	public String deCrypt(String message) throws Exception {
		try {
			cipher.init(Cipher.DECRYPT_MODE, secretKey, iv);
			byte data[] = getFromBASE64(message);
			byte[] encryptedData = cipher.doFinal(data);
			return new String(encryptedData);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	private byte[] getFromBASE64(String s) {
		if (s == null)
			return null;
		BASE64Decoder decoder = new BASE64Decoder();
		try {
			byte[] b = decoder.decodeBuffer(s);
			return b;
		} catch (Exception e) {
			return null;
		}
	}

}
