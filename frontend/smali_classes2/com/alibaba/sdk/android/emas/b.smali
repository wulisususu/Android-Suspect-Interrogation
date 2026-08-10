.class Lcom/alibaba/sdk/android/emas/b;
.super Ljava/lang/Object;
.source "AesGcmCipher.java"


# static fields
.field private static final a:Lcom/alibaba/sdk/android/emas/b;


# instance fields
.field private a:Ljava/security/KeyStore;

.field private b:Z


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 81
    new-instance v0, Lcom/alibaba/sdk/android/emas/b;

    invoke-direct {v0}, Lcom/alibaba/sdk/android/emas/b;-><init>()V

    sput-object v0, Lcom/alibaba/sdk/android/emas/b;->a:Lcom/alibaba/sdk/android/emas/b;

    return-void
.end method

.method private constructor <init>()V
    .locals 1

    .line 70
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/alibaba/sdk/android/emas/b;->b:Z

    .line 72
    :try_start_0
    invoke-direct {p0}, Lcom/alibaba/sdk/android/emas/b;->a()V

    .line 74
    invoke-direct {p0}, Lcom/alibaba/sdk/android/emas/b;->a()Ljava/security/Key;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/alibaba/sdk/android/emas/b;->a(Ljava/security/Key;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/alibaba/sdk/android/emas/b;->b:Z

    :goto_0
    return-void
.end method

.method public static a()Lcom/alibaba/sdk/android/emas/b;
    .locals 1

    sget-object v0, Lcom/alibaba/sdk/android/emas/b;->a:Lcom/alibaba/sdk/android/emas/b;

    return-object v0
.end method

.method private a()Ljava/security/Key;
    .locals 5

    const/4 v0, 0x0

    .line 126
    :try_start_0
    new-instance v1, Landroid/security/keystore/KeyGenParameterSpec$Builder;

    const-string v2, "emas_rest_key"

    const/4 v3, 0x3

    invoke-direct {v1, v2, v3}, Landroid/security/keystore/KeyGenParameterSpec$Builder;-><init>(Ljava/lang/String;I)V

    const/16 v2, 0x100

    .line 128
    invoke-virtual {v1, v2}, Landroid/security/keystore/KeyGenParameterSpec$Builder;->setKeySize(I)Landroid/security/keystore/KeyGenParameterSpec$Builder;

    const/4 v2, 0x1

    new-array v3, v2, [Ljava/lang/String;

    const-string v4, "GCM"

    aput-object v4, v3, v0

    .line 129
    invoke-virtual {v1, v3}, Landroid/security/keystore/KeyGenParameterSpec$Builder;->setBlockModes([Ljava/lang/String;)Landroid/security/keystore/KeyGenParameterSpec$Builder;

    new-array v3, v2, [Ljava/lang/String;

    const-string v4, "NoPadding"

    aput-object v4, v3, v0

    .line 130
    invoke-virtual {v1, v3}, Landroid/security/keystore/KeyGenParameterSpec$Builder;->setEncryptionPaddings([Ljava/lang/String;)Landroid/security/keystore/KeyGenParameterSpec$Builder;

    sget v3, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v4, 0x1c

    if-lt v3, v4, :cond_0

    .line 132
    invoke-virtual {v1, v2}, Landroid/security/keystore/KeyGenParameterSpec$Builder;->setUnlockedDeviceRequired(Z)Landroid/security/keystore/KeyGenParameterSpec$Builder;

    :cond_0
    const-string v2, "AES"

    .line 134
    invoke-static {v2}, Ljavax/crypto/KeyGenerator;->getInstance(Ljava/lang/String;)Ljavax/crypto/KeyGenerator;

    move-result-object v2

    .line 135
    invoke-virtual {v1}, Landroid/security/keystore/KeyGenParameterSpec$Builder;->build()Landroid/security/keystore/KeyGenParameterSpec;

    move-result-object v1

    invoke-virtual {v2, v1}, Ljavax/crypto/KeyGenerator;->init(Ljava/security/spec/AlgorithmParameterSpec;)V

    .line 136
    invoke-virtual {v2}, Ljavax/crypto/KeyGenerator;->generateKey()Ljavax/crypto/SecretKey;

    move-result-object v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return-object v0

    :catchall_0
    move-exception v1

    .line 139
    invoke-static {v1}, Landroid/util/Log;->getStackTraceString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/alibaba/sdk/android/tbrest/utils/LogUtil;->e(Ljava/lang/String;)V

    iput-boolean v0, p0, Lcom/alibaba/sdk/android/emas/b;->b:Z

    const/4 v0, 0x0

    return-object v0
.end method

.method private a()V
    .locals 2

    :try_start_0
    const-string v0, "AndroidKeyStore"

    .line 92
    invoke-static {v0}, Ljava/security/KeyStore;->getInstance(Ljava/lang/String;)Ljava/security/KeyStore;

    move-result-object v0

    iput-object v0, p0, Lcom/alibaba/sdk/android/emas/b;->a:Ljava/security/KeyStore;

    const/4 v1, 0x0

    .line 93
    invoke-virtual {v0, v1}, Ljava/security/KeyStore;->load(Ljava/security/KeyStore$LoadStoreParameter;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception v0

    .line 95
    invoke-static {v0}, Landroid/util/Log;->getStackTraceString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/alibaba/sdk/android/tbrest/utils/LogUtil;->e(Ljava/lang/String;)V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/alibaba/sdk/android/emas/b;->b:Z

    :goto_0
    return-void
.end method

.method private a(Ljava/security/Key;)V
    .locals 3

    const-string v0, "emas_rest_key"

    :try_start_0
    iget-object v1, p0, Lcom/alibaba/sdk/android/emas/b;->a:Ljava/security/KeyStore;

    .line 107
    invoke-virtual {v1, v0}, Ljava/security/KeyStore;->containsAlias(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    iget-object v1, p0, Lcom/alibaba/sdk/android/emas/b;->a:Ljava/security/KeyStore;

    const/4 v2, 0x0

    .line 108
    invoke-virtual {v1, v0, p1, v2, v2}, Ljava/security/KeyStore;->setKeyEntry(Ljava/lang/String;Ljava/security/Key;[C[Ljava/security/cert/Certificate;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception p1

    .line 111
    invoke-static {p1}, Landroid/util/Log;->getStackTraceString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lcom/alibaba/sdk/android/tbrest/utils/LogUtil;->e(Ljava/lang/String;)V

    const/4 p1, 0x0

    iput-boolean p1, p0, Lcom/alibaba/sdk/android/emas/b;->b:Z

    :cond_0
    :goto_0
    return-void
.end method


# virtual methods
.method a([B)[B
    .locals 9

    iget-boolean v0, p0, Lcom/alibaba/sdk/android/emas/b;->b:Z

    const/4 v1, 0x0

    if-nez v0, :cond_0

    return-object v1

    :cond_0
    :try_start_0
    const-string v0, "AES/GCM/NoPadding"

    .line 159
    invoke-static {v0}, Ljavax/crypto/Cipher;->getInstance(Ljava/lang/String;)Ljavax/crypto/Cipher;

    move-result-object v2

    iget-object v0, p0, Lcom/alibaba/sdk/android/emas/b;->a:Ljava/security/KeyStore;

    const-string v3, "emas_rest_key"

    .line 160
    invoke-virtual {v0, v3, v1}, Ljava/security/KeyStore;->getKey(Ljava/lang/String;[C)Ljava/security/Key;

    move-result-object v0

    const/4 v3, 0x1

    invoke-virtual {v2, v3, v0}, Ljavax/crypto/Cipher;->init(ILjava/security/Key;)V

    .line 161
    invoke-virtual {v2}, Ljavax/crypto/Cipher;->getIV()[B

    move-result-object v0

    .line 162
    array-length v3, p1

    invoke-virtual {v2, v3}, Ljavax/crypto/Cipher;->getOutputSize(I)I

    move-result v3

    const/16 v4, 0xc

    add-int/2addr v3, v4

    new-array v8, v3, [B

    const/4 v3, 0x0

    .line 164
    invoke-static {v0, v3, v8, v3, v4}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    const/4 v4, 0x0

    .line 166
    array-length v5, p1

    const/16 v7, 0xc

    move-object v3, p1

    move-object v6, v8

    invoke-virtual/range {v2 .. v7}, Ljavax/crypto/Cipher;->doFinal([BII[BI)I
    :try_end_0
    .catch Ljavax/crypto/ShortBufferException; {:try_start_0 .. :try_end_0} :catch_7
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_0 .. :try_end_0} :catch_6
    .catch Ljavax/crypto/NoSuchPaddingException; {:try_start_0 .. :try_end_0} :catch_5
    .catch Ljava/security/KeyStoreException; {:try_start_0 .. :try_end_0} :catch_4
    .catch Ljava/security/InvalidKeyException; {:try_start_0 .. :try_end_0} :catch_3
    .catch Ljava/security/UnrecoverableKeyException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljavax/crypto/BadPaddingException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljavax/crypto/IllegalBlockSizeException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v8

    :catch_0
    move-exception p1

    goto :goto_0

    :catch_1
    move-exception p1

    goto :goto_0

    :catch_2
    move-exception p1

    goto :goto_0

    :catch_3
    move-exception p1

    goto :goto_0

    :catch_4
    move-exception p1

    goto :goto_0

    :catch_5
    move-exception p1

    goto :goto_0

    :catch_6
    move-exception p1

    goto :goto_0

    :catch_7
    move-exception p1

    .line 171
    :goto_0
    invoke-static {p1}, Landroid/util/Log;->getStackTraceString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lcom/alibaba/sdk/android/tbrest/utils/LogUtil;->e(Ljava/lang/String;)V

    return-object v1
.end method

.method b([B)[B
    .locals 8

    iget-boolean v0, p0, Lcom/alibaba/sdk/android/emas/b;->b:Z

    const/4 v1, 0x0

    if-nez v0, :cond_0

    return-object v1

    :cond_0
    :try_start_0
    const-string v0, "AES/GCM/NoPadding"

    .line 187
    invoke-static {v0}, Ljavax/crypto/Cipher;->getInstance(Ljava/lang/String;)Ljavax/crypto/Cipher;

    move-result-object v2

    .line 188
    new-instance v0, Ljavax/crypto/spec/GCMParameterSpec;

    const/16 v3, 0x80

    const/4 v4, 0x0

    const/16 v5, 0xc

    invoke-direct {v0, v3, p1, v4, v5}, Ljavax/crypto/spec/GCMParameterSpec;-><init>(I[BII)V

    iget-object v3, p0, Lcom/alibaba/sdk/android/emas/b;->a:Ljava/security/KeyStore;

    const-string v4, "emas_rest_key"

    .line 190
    invoke-virtual {v3, v4, v1}, Ljava/security/KeyStore;->getKey(Ljava/lang/String;[C)Ljava/security/Key;

    move-result-object v3

    const/4 v4, 0x2

    invoke-virtual {v2, v4, v3, v0}, Ljavax/crypto/Cipher;->init(ILjava/security/Key;Ljava/security/spec/AlgorithmParameterSpec;)V

    .line 192
    array-length v0, p1

    sub-int/2addr v0, v5

    invoke-virtual {v2, v0}, Ljavax/crypto/Cipher;->getOutputSize(I)I

    move-result v0

    new-array v0, v0, [B

    const/16 v4, 0xc

    .line 193
    array-length v3, p1

    add-int/lit8 v5, v3, -0xc

    const/4 v7, 0x0

    move-object v3, p1

    move-object v6, v0

    invoke-virtual/range {v2 .. v7}, Ljavax/crypto/Cipher;->doFinal([BII[BI)I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return-object v0

    :catchall_0
    move-exception p1

    .line 196
    invoke-static {p1}, Landroid/util/Log;->getStackTraceString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lcom/alibaba/sdk/android/tbrest/utils/LogUtil;->e(Ljava/lang/String;)V

    return-object v1
.end method
