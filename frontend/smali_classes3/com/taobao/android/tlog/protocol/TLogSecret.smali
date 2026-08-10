.class public Lcom/taobao/android/tlog/protocol/TLogSecret;
.super Ljava/lang/Object;
.source "TLogSecret.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/taobao/android/tlog/protocol/TLogSecret$CreateInstance;
    }
.end annotation


# static fields
.field public static final encryptionType:Ljava/lang/Integer;


# instance fields
.field private final DEFAULT_RSAPUBLICKEY:Ljava/lang/String;

.field private TAG:Ljava/lang/String;

.field private mRc4EncryptSecret:Ljava/lang/String;

.field private mRsaPublicMd5:Ljava/lang/String;

.field private rsaPublishKey:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const/4 v0, 0x0

    .line 27
    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    sput-object v0, Lcom/taobao/android/tlog/protocol/TLogSecret;->encryptionType:Ljava/lang/Integer;

    return-void
.end method

.method private constructor <init>()V
    .locals 1

    .line 37
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-string v0, "TLogProtocol"

    iput-object v0, p0, Lcom/taobao/android/tlog/protocol/TLogSecret;->TAG:Ljava/lang/String;

    const-string v0, "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC1cueeBrz4VMOr09PxnO7ILYh6jDhcZwEUgzjPfwy2apBZIHAfGagR8LzN35O0UhvoeN570mJP4g0nLm2KL1H/K1NGYqT254w0sdV51kzO/yu+WcfgPkPLosnR1kVaPqiYKT2Bl1Yi85ZJwApO2y8lPmFwpIrMmKiTYqR2Gmd9nQIDAQAB"

    iput-object v0, p0, Lcom/taobao/android/tlog/protocol/TLogSecret;->DEFAULT_RSAPUBLICKEY:Ljava/lang/String;

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/taobao/android/tlog/protocol/TLogSecret;->rsaPublishKey:Ljava/lang/String;

    return-void
.end method

.method synthetic constructor <init>(Lcom/taobao/android/tlog/protocol/TLogSecret$1;)V
    .locals 0

    .line 19
    invoke-direct {p0}, Lcom/taobao/android/tlog/protocol/TLogSecret;-><init>()V

    return-void
.end method

.method public static declared-synchronized getInstance()Lcom/taobao/android/tlog/protocol/TLogSecret;
    .locals 2

    const-class v0, Lcom/taobao/android/tlog/protocol/TLogSecret;

    monitor-enter v0

    .line 48
    :try_start_0
    invoke-static {}, Lcom/taobao/android/tlog/protocol/TLogSecret$CreateInstance;->access$100()Lcom/taobao/android/tlog/protocol/TLogSecret;

    move-result-object v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v0

    return-object v1

    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method

.method public static main([Ljava/lang/String;)V
    .locals 1

    .line 107
    :try_start_0
    invoke-static {}, Lcom/taobao/android/tlog/protocol/TLogSecret;->getInstance()Lcom/taobao/android/tlog/protocol/TLogSecret;

    move-result-object p0

    const-string v0, "123456776654"

    invoke-virtual {p0, v0}, Lcom/taobao/android/tlog/protocol/TLogSecret;->getRc4EncryptSecretValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    const-string v0, "MIICdQIBADANBgkqhkiG9w0BAQEFAASCAl8wggJbAgEAAoGBALVy554GvPhUw6vT0/Gc7sgtiHqMOFxnARSDOM9/DLZqkFkgcB8ZqBHwvM3fk7RSG+h43nvSYk/iDScubYovUf8rU0ZipPbnjDSx1XnWTM7/K75Zx+A+Q8uiydHWRVo+qJgpPYGXViLzlknACk7bLyU+YXCkisyYqJNipHYaZ32dAgMBAAECgYBYcFwSOwiKJY6FxqaMIkiESyU1Tfj+mLn/DIJ5KFzC4KfguR3NGs0/iU4NLkco4ch2g8s1IPMIKo7spQWBD9VvrmrW4PBqjG2CoP5iVWYOnz5xDPllmUmMRzLs6voBn5vKgn/qZVHg5ElPh4Q57z2vzDNLzVMpmeFIBrpKz8iDhQJBAOUGRNUB3+O3JKO4/vfuDIIxPh/8xZNAR76Yj/QeL5ojO0gzPXrR5fAvvfRUMhHA4jV5iXqBwbu/A9isHXTZIEcCQQDK0hjFvBEFg8ocSdSCkk6wAUEqhci7i8cDUXc+RQn6xGsN0gnq+FjzIUWsFsj4ROhrFHp2K9U/QaeEgHbkWGj7AkBfkscksNyStbnXjPrx0ehsaEpJpP16XqfR9O6V7AbnZu51SdTNLUysd+/oRz6BxCFiOW7SrdWAGM1tHR5JxdY/AkAKJDlC4eWD/hQEGBj9Mm2m1Vk51Bi2cAXSf6dTwMX/+QRVW5RNYH+qIJbIRRdleqSYfhylfgmasSC8OmQ3hMgzAkAZTTBNMdfWkJAn063xGMGQYbuRoWZC8qz+au6DuFL5iSJ+OXcB8tc/Woi4JIVTKZLsHm0uclhE+ch3OPDVjzjB"

    .line 113
    invoke-static {p0}, Lcom/taobao/android/tlog/protocol/utils/Base64;->decode(Ljava/lang/String;)[B

    move-result-object p0

    invoke-static {p0, v0}, Lcom/taobao/android/tlog/protocol/utils/RSAUtils;->decryptByPrivateKey([BLjava/lang/String;)[B

    move-result-object p0

    .line 115
    new-instance v0, Ljava/lang/String;

    invoke-direct {v0, p0}, Ljava/lang/String;-><init>([B)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method


# virtual methods
.method public getRc4EncryptSecretValue(Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    iget-object v0, p0, Lcom/taobao/android/tlog/protocol/TLogSecret;->mRc4EncryptSecret:Ljava/lang/String;

    if-nez v0, :cond_0

    .line 93
    invoke-virtual {p1}, Ljava/lang/String;->getBytes()[B

    move-result-object p1

    invoke-virtual {p0}, Lcom/taobao/android/tlog/protocol/TLogSecret;->getRsaPublishKey()Ljava/lang/String;

    move-result-object v0

    invoke-static {p1, v0}, Lcom/taobao/android/tlog/protocol/utils/RSAUtils;->encryptByPublicKey([BLjava/lang/String;)[B

    move-result-object p1

    .line 94
    invoke-static {p1}, Lcom/taobao/android/tlog/protocol/utils/Base64;->encodeBase64String([B)Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lcom/taobao/android/tlog/protocol/TLogSecret;->mRc4EncryptSecret:Ljava/lang/String;

    :cond_0
    iget-object p1, p0, Lcom/taobao/android/tlog/protocol/TLogSecret;->mRc4EncryptSecret:Ljava/lang/String;

    if-nez p1, :cond_1

    iget-object p1, p0, Lcom/taobao/android/tlog/protocol/TLogSecret;->TAG:Ljava/lang/String;

    const-string v0, " rc4 Encrypt secret obtain failure "

    .line 98
    invoke-static {p1, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 p1, 0x0

    :cond_1
    return-object p1
.end method

.method public getRsaMd5Value()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/taobao/android/tlog/protocol/TLogSecret;->mRsaPublicMd5:Ljava/lang/String;

    if-nez v0, :cond_0

    .line 57
    invoke-virtual {p0}, Lcom/taobao/android/tlog/protocol/TLogSecret;->getRsaPublishKey()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->getBytes()[B

    move-result-object v0

    invoke-static {v0}, Lcom/taobao/android/tlog/protocol/utils/MD5Utils;->encrypt([B)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/android/tlog/protocol/TLogSecret;->mRsaPublicMd5:Ljava/lang/String;

    :cond_0
    iget-object v0, p0, Lcom/taobao/android/tlog/protocol/TLogSecret;->mRsaPublicMd5:Ljava/lang/String;

    return-object v0
.end method

.method public getRsaPublishKey()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/taobao/android/tlog/protocol/TLogSecret;->rsaPublishKey:Ljava/lang/String;

    if-nez v0, :cond_0

    const-string v0, "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC1cueeBrz4VMOr09PxnO7ILYh6jDhcZwEUgzjPfwy2apBZIHAfGagR8LzN35O0UhvoeN570mJP4g0nLm2KL1H/K1NGYqT254w0sdV51kzO/yu+WcfgPkPLosnR1kVaPqiYKT2Bl1Yi85ZJwApO2y8lPmFwpIrMmKiTYqR2Gmd9nQIDAQAB"

    :cond_0
    return-object v0
.end method

.method public setRsapublickey(Ljava/lang/String;)V
    .locals 0

    if-eqz p1, :cond_0

    iput-object p1, p0, Lcom/taobao/android/tlog/protocol/TLogSecret;->rsaPublishKey:Ljava/lang/String;

    :cond_0
    return-void
.end method
