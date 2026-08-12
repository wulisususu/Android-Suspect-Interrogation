package com.wulisu.suspect.interrogation.service

import android.content.Context
import android.security.keystore.KeyGenParameterSpec
import android.security.keystore.KeyProperties
import android.util.Base64
import java.security.KeyStore
import javax.crypto.Cipher
import javax.crypto.KeyGenerator
import javax.crypto.SecretKey
import javax.crypto.spec.GCMParameterSpec

class AiSettingsStore(private val context: Context) {
    private val prefs = context.getSharedPreferences("ai_runtime_settings", Context.MODE_PRIVATE)
    private val keyAlias = "suspect_interrogation_ai_secret_v1"

    companion object {
        const val DEFAULT_API_KEY = "de5b978884014b5faec14a791179b045.rxAkRuD5MgRamkk3"
    }

    fun load(): AiSettings = AiSettings(
        mode = AiMode.fromWire(prefs.getString("mode", AiMode.CLOUD.name)),
        cloudBaseUrl = prefs.getString("cloud_base_url", null)?.takeIf { it.isNotBlank() }
            ?: "https://open.bigmodel.cn/api/paas/v4/chat/completions",
        cloudModel = prefs.getString("cloud_model", null)?.takeIf { it.isNotBlank() } ?: "glm-4.7",
        stream = prefs.getBoolean("stream", true),
        thinkingEnabled = prefs.getBoolean("thinking_enabled", true),
        maxTokens = prefs.getInt("max_tokens", 65_536),
        temperature = java.lang.Double.longBitsToDouble(prefs.getLong("temperature", java.lang.Double.doubleToLongBits(1.0))),
        apiKeyConfigured = getApiKey().isNotBlank(),
    )

    fun update(
        mode: AiMode? = null,
        cloudBaseUrl: String? = null,
        cloudModel: String? = null,
        stream: Boolean? = null,
        thinkingEnabled: Boolean? = null,
        maxTokens: Int? = null,
        temperature: Double? = null,
        apiKey: String? = null,
        clearApiKey: Boolean = false,
    ): AiSettings {
        val editor = prefs.edit()
        mode?.let { editor.putString("mode", it.name) }
        cloudBaseUrl?.trim()?.takeIf { it.isNotEmpty() }?.let { editor.putString("cloud_base_url", it) }
        cloudModel?.trim()?.takeIf { it.isNotEmpty() }?.let { editor.putString("cloud_model", it) }
        stream?.let { editor.putBoolean("stream", it) }
        thinkingEnabled?.let { editor.putBoolean("thinking_enabled", it) }
        maxTokens?.coerceIn(1, 65_536)?.let { editor.putInt("max_tokens", it) }
        temperature?.coerceIn(0.0, 2.0)?.let { editor.putLong("temperature", java.lang.Double.doubleToLongBits(it)) }
        editor.apply()

        if (clearApiKey) clearApiKey()
        else apiKey?.trim()?.takeIf { it.isNotEmpty() }?.let(::setApiKey)
        return load()
    }

    fun getApiKey(): String {
        val iv = prefs.getString("api_key_iv", null) ?: return DEFAULT_API_KEY
        val ciphertext = prefs.getString("api_key_ciphertext", null) ?: return DEFAULT_API_KEY
        return runCatching {
            decrypt(Base64.decode(iv, Base64.NO_WRAP), Base64.decode(ciphertext, Base64.NO_WRAP)).decodeToString()
        }.getOrDefault(DEFAULT_API_KEY)
    }

    private fun setApiKey(value: String) {
        val (iv, ciphertext) = encrypt(value.encodeToByteArray())
        prefs.edit()
            .putString("api_key_iv", Base64.encodeToString(iv, Base64.NO_WRAP))
            .putString("api_key_ciphertext", Base64.encodeToString(ciphertext, Base64.NO_WRAP))
            .apply()
    }

    private fun clearApiKey() {
        prefs.edit().remove("api_key_iv").remove("api_key_ciphertext").apply()
    }

    private fun wrappingKey(): SecretKey {
        val keyStore = KeyStore.getInstance("AndroidKeyStore").apply { load(null) }
        (keyStore.getKey(keyAlias, null) as? SecretKey)?.let { return it }
        val generator = KeyGenerator.getInstance(KeyProperties.KEY_ALGORITHM_AES, "AndroidKeyStore")
        generator.init(
            KeyGenParameterSpec.Builder(
                keyAlias,
                KeyProperties.PURPOSE_ENCRYPT or KeyProperties.PURPOSE_DECRYPT,
            )
                .setBlockModes(KeyProperties.BLOCK_MODE_GCM)
                .setEncryptionPaddings(KeyProperties.ENCRYPTION_PADDING_NONE)
                .setKeySize(256)
                .build(),
        )
        return generator.generateKey()
    }

    private fun encrypt(plain: ByteArray): Pair<ByteArray, ByteArray> {
        val cipher = Cipher.getInstance("AES/GCM/NoPadding")
        cipher.init(Cipher.ENCRYPT_MODE, wrappingKey())
        return cipher.iv to cipher.doFinal(plain)
    }

    private fun decrypt(iv: ByteArray, ciphertext: ByteArray): ByteArray {
        val cipher = Cipher.getInstance("AES/GCM/NoPadding")
        cipher.init(Cipher.DECRYPT_MODE, wrappingKey(), GCMParameterSpec(128, iv))
        return cipher.doFinal(ciphertext)
    }
}
