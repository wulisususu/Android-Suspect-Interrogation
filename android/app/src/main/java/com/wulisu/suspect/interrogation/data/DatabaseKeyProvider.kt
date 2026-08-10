package com.wulisu.suspect.interrogation.data

import android.content.Context
import android.security.keystore.KeyGenParameterSpec
import android.security.keystore.KeyProperties
import android.util.Base64
import java.security.KeyStore
import java.security.SecureRandom
import javax.crypto.Cipher
import javax.crypto.KeyGenerator
import javax.crypto.SecretKey
import javax.crypto.spec.GCMParameterSpec

class DatabaseKeyProvider(private val context: Context) {
    private val prefs = context.getSharedPreferences("secure_database_key", Context.MODE_PRIVATE)
    private val keyAlias = "suspect_interrogation_db_wrap_key_v1"

    fun getOrCreatePassphrase(): ByteArray {
        val encrypted = prefs.getString("ciphertext", null)
        val iv = prefs.getString("iv", null)
        if (encrypted != null && iv != null) {
            return decrypt(Base64.decode(iv, Base64.NO_WRAP), Base64.decode(encrypted, Base64.NO_WRAP))
        }
        val passphrase = ByteArray(32).also { SecureRandom().nextBytes(it) }
        val (newIv, ciphertext) = encrypt(passphrase)
        prefs.edit().putString("iv", Base64.encodeToString(newIv, Base64.NO_WRAP)).putString("ciphertext", Base64.encodeToString(ciphertext, Base64.NO_WRAP)).apply()
        return passphrase
    }

    private fun wrappingKey(): SecretKey {
        val keyStore = KeyStore.getInstance("AndroidKeyStore").apply { load(null) }
        (keyStore.getKey(keyAlias, null) as? SecretKey)?.let { return it }
        val generator = KeyGenerator.getInstance(KeyProperties.KEY_ALGORITHM_AES, "AndroidKeyStore")
        generator.init(KeyGenParameterSpec.Builder(keyAlias, KeyProperties.PURPOSE_ENCRYPT or KeyProperties.PURPOSE_DECRYPT).setBlockModes(KeyProperties.BLOCK_MODE_GCM).setEncryptionPaddings(KeyProperties.ENCRYPTION_PADDING_NONE).setKeySize(256).build())
        return generator.generateKey()
    }

    private fun encrypt(plain: ByteArray): Pair<ByteArray, ByteArray> {
        val cipher = Cipher.getInstance("AES/GCM/NoPadding")
        cipher.init(Cipher.ENCRYPT_MODE, wrappingKey())
        return cipher.iv to cipher.doFinal(plain)
    }

    private fun decrypt(iv: ByteArray, cipherText: ByteArray): ByteArray {
        val cipher = Cipher.getInstance("AES/GCM/NoPadding")
        cipher.init(Cipher.DECRYPT_MODE, wrappingKey(), GCMParameterSpec(128, iv))
        return cipher.doFinal(cipherText)
    }
}
